local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local CombatFramework = require(Player.PlayerScripts.CombatFramework)
local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Camera:Stop()

_G.AutoFarm = true
_G.bringmob = true
_G.FastAttack = true

local function EquipWeapon(weaponName)
    local backpack = Player.Backpack
    local weapon = backpack:FindFirstChild(weaponName)

    if weapon then
        -- หากอาวุธอยู่ในกระเป๋า ให้สวมใส่
        Player.Character.Humanoid:EquipTool(weapon)
    else
        -- หากอาวุธไม่อยู่ในกระเป๋า ให้ไปที่ ReplicatedStorage เพื่อค้นหา
        local storageWeapon = ReplicatedStorage:FindFirstChild(weaponName)
        if storageWeapon then
            -- สร้างอาวุธจาก ReplicatedStorage ถ้ามันมี
            local newWeapon = storageWeapon:Clone()
            newWeapon.Parent = backpack
            Player.Character.Humanoid:EquipTool(newWeapon)
        end
    end
end

local function GetQuests(N, NB)
    local args = {
        [1] = "StartQuest",
        [2] = N or "BanditQuest1",
        [3] = NB or 1
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))    
end

local function CheckQuest()
    local Lv = Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Level")
    if Lv and Lv.Value then
        if Lv.Value >= 1 and Lv.Value <= 9 then
            return {
                ["Mon"] = 'Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'BanditQuest1',
                ["CFrameQ"] = CFrame.new(1059.37195, 15.4495068, 1550.4231),
                ["CFrameMon"] = CFrame.new(1196.172, 0, 1616.95923)
            }
        elseif Lv.Value >= 10 and Lv.Value <= 14 then
            return {
                ["Mon"] = 'Monkey',
                ["NumQ"] = 1,
                ["NameQ"] = 'JungleQuest',
                ["CFrameQ"] = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                ["CFrameMon"] = CFrame.new(-1619.10632, 0, 142.148117)
            }
        elseif Lv.Value >= 15 and Lv.Value <= 29 then
            return {
                ["Mon"] = 'Gorilla',
                ["NumQ"] = 2,
                ["NameQ"] = 'JungleQuest',
                ["CFrameQ"] = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                ["CFrameMon"] = CFrame.new(-1261.971, 0, -520.4246826171875)
            }
        elseif Lv.Value >= 30 and Lv.Value <= 39 then
            return {
                ["Mon"] = 'Brute',
                ["NumQ"] = 2,
                ["NameQ"] = 'BuggyQuest1',
                ["CFrameQ"] = CFrame.new(-1140.3, 4.9, 3825.7),
                ["CFrameMon"] = CFrame.new(-1122.5, 0, 3855.7)
            }
        elseif Lv.Value >= 40 and Lv.Value <= 59 then
            return {
                ["Mon"] = 'Desert Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'DesertQuest',
                ["CFrameQ"] = CFrame.new(896.4, 6.4, 4389.8),
                ["CFrameMon"] = CFrame.new(932.4, 0, 4418.8)
            }
        elseif Lv.Value >= 60 and Lv.Value <= 74 then
            return {
                ["Mon"] = 'Desert Officer',
                ["NumQ"] = 2,
                ["NameQ"] = 'DesertQuest',
                ["CFrameQ"] = CFrame.new(896.4, 6.4, 4389.8),
                ["CFrameMon"] = CFrame.new(932.4, 0, 4418.8)
            }
        elseif Lv.Value >= 75 and Lv.Value <= 89 then
            return {
                ["Mon"] = 'Snow Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'SnowQuest',
                ["CFrameQ"] = CFrame.new(1388.4, 87.4, -1295.4),
                ["CFrameMon"] = CFrame.new(1397.2, 0, -1295.4)
            }
        elseif Lv.Value >= 90 and Lv.Value <= 109 then
            return {
                ["Mon"] = 'Snowman',
                ["NumQ"] = 2,
                ["NameQ"] = 'SnowQuest',
                ["CFrameQ"] = CFrame.new(1388.4, 87.4, -1295.4),
                ["CFrameMon"] = CFrame.new(1397.2, 0, -1295.4)
            }
        end
    end
    return nil
end

local function TweenTo(targetCFrame, speed)
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        local distance = (targetCFrame.Position - Char.HumanoidRootPart.Position).Magnitude
        local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(Char.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait() -- รอให้การเคลื่อนไหวเสร็จสิ้น
    end
end

local function ClearQuest()
    local currentQuest = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    local questData = CheckQuest()
    if questData and not string.find(currentQuest, questData.Mon) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    end
end

-- ฟังก์ชัน Fast Attack
local function FastAttack()
    local activeController = getupvalues(CombatFramework)[2]['activeController']
    if activeController.timeToNextAttack then
        activeController.timeToNextAttack = 0
        activeController.hitboxMagnitude = 25 -- ปรับ hitbox ให้เป็น 25
        activeController:attack()
    end
end

coroutine.wrap(function()
    RunService.Stepped:Connect(function()
        if _G.FastAttack then
            FastAttack()
        end
    end)
end)()

spawn(function()
    EquipWeapon("Combat") -- สวมใส่อาวุธ Combat

    while wait() do
        pcall(function()
            if _G.AutoFarm then
                ClearQuest()
                local questData = CheckQuest()
                if questData then
                    local UIQ = Player.PlayerGui.Main.Quest
                    if not UIQ.Visible then
                        TweenTo(questData.CFrameQ, 250) -- บินไปยังตำแหน่งเควสด้วยความเร็ว 250
                        if (questData.CFrameQ.Position - Char.HumanoidRootPart.Position).Magnitude <= 15 then
                            wait(0.2)
                            GetQuests(questData.NameQ, questData.NumQ) -- เริ่มเควส
                        end
                    else
                        local enemy = game:GetService("Workspace").Enemies:FindFirstChild(questData.Mon)
                        if enemy then
                            -- ดึงมอนสเตอร์และลอยตัวเหนือมัน
                            local targetHeight = 20 -- ปรับความสูงที่จะลอยเหนือศัตรู
                            Char.HumanoidRootPart.CFrame = CFrame.new(questData.CFrameMon.Position.X, questData.CFrameMon.Position.Y + targetHeight, questData.CFrameMon.Position.Z) -- บินอยู่เหนือมอนที่ความสูง 20
                            repeat
                                if enemy.Humanoid.Health > 0 then
                                    local targetPosition = enemy.HumanoidRootPart.Position + Vector3.new(0, targetHeight, 0) -- คำนวณตำแหน่งที่ต้องการลอยอยู่
                                    Char.HumanoidRootPart.CFrame = CFrame.new(targetPosition) -- ตั้งตำแหน่งตัวละคร
                                    FastAttack() -- เรียกใช้งานฟังก์ชันตีไว
                                    wait(0.1) -- รอเล็กน้อยก่อนการโจมตีถัดไป
                                end
                            until enemy.Humanoid.Health <= 0 -- ทำซ้ำจนกว่าจะฆ่ามอนสเตอร์
                        end
                    end
                end
            end
        end)
    end
end)()
