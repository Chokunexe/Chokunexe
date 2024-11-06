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
                ["NameQ"] = 'BanditQuest1', 
                ["NumQ"] = 1, 
                ["CFrameQ"] = CFrame.new(1059.37195, 15.4495068, 1550.4231), 
                ["CFrameMon"] = CFrame.new(1196.172, 11.8689699, 1616.95923)
            }
        elseif Lv.Value >= 10 and Lv.Value <= 14 then
            return {
                ["Mon"] = 'Monkey', 
                ["NameQ"] = 'JungleQuest', 
                ["NumQ"] = 1, 
                ["CFrameQ"] = CFrame.new(-1598.08911, 35.5501175, 153.377838), 
                ["CFrameMon"] = CFrame.new(-1619.10632, 21.7005882, 142.148117)
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
                ["Mon"] = 'Pirate',
                ["NameQ"] = 'BuggyQuest1',
                ["NumQ"] = 1,
                ["CFrameQ"] = CFrame.new(-1140.762939453125, 5.277381896972656, 3830.43017578125),
                ["CFrameMon"] = CFrame.new(-1180.4862060546875, 4.877380847930908, 3948.302978515625)
            }
        elseif Lv.Value >= 40 and Lv.Value <= 59 then
            return {
                ["Mon"] = 'Brute',
                ["NameQ"] = 'BuggyQuest1',
                ["NumQ"] = 2,
                ["CFrameQ"] = CFrame.new(-1140.762939453125, 5.277381896972656, 3830.43017578125),
                ["CFrameMon"] = CFrame.new(-1145.1796875, 14.935205459594727, 4315.4931640625)
            }
        elseif Lv.Value >= 60 and Lv.Value < 75 then
            return {
                ["Mon"] = 'Desert Bandit',
                ["NameQ"] = 'DesertQuest',
                ["NumQ"] = 1,
                ["CFrameQ"] = CFrame.new(893.2763671875, 6.563793659210205, 4393.5732421875),
                ["CFrameMon"] = CFrame.new(922.5709228515625, 6.574110507965088, 4476.7412109375)
            }
        elseif Lv.Value >= 76 and Lv.Value <= 89 then
            return {
                ["Mon"] = 'Desert Officer',
                ["NameQ"] = 'DesertQuest',
                ["NumQ"] = 2,
                ["CFrameQ"] = CFrame.new(893.2763671875, 6.563793659210205, 4393.5732421875),
                ["CFrameMon"] = CFrame.new(1606.2596435546875, 1.7362850904464722, 4362.77783203125)
            }
        elseif Lv.Value >= 90 and Lv.Value < 99 then
            return {
                ["Mon"] = 'Snow Bandit',
                ["NameQ"] = 'SnowQuest',
                ["NumQ"] = 1,
                ["CFrameQ"] = CFrame.new(1387.727783203125, 6.563793659210205, 4393.5732421875),
                ["CFrameMon"] = CFrame.new(1445.0704345703125, 6.574110507965088, 4476.7412109375)
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


spawn(function()
    EquipWeapon("Combat") -- สวมใส่อาวุธ Combat

                _G.AutoFarm = true
        StopTween(_G.AutoFarm)
spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                if not string.find(QuestTitle, NameMon) then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    StartMagnet = false
                    CheckQuest()
                    if BypassTP then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude > 1500 then
                    BTP(CFrameQuest)
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude < 1500 then
                    TP1(CFrameQuest)
                    end
                else
                    TP1(CFrameQuest)
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckQuest()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Mon then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        repeat task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            AutoHaki()                                            
                                            PosMon = v.HumanoidRootPart.CFrame
                                            TP1(v.HumanoidRootPart.CFrame * Pos)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(70,70,70)
                                            StartMagnet = true
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                        until not _G.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        StartMagnet = false
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        TP1(CFrameMon)
                        StartMagnet = false
                        if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
                         TP1(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(15,10,2))
                        end
                    end
                end
            end)
        end
    end
end)

_G.BringMonster = true
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.BringMonster then
                CheckQuest()
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if _G.AutoFarm and StartMagnet and v.Name == Mon and (Mon == "Factory Staff [Lv. 800]" or Mon == "Monkey [Lv. 14]" or Mon == "Dragon Crew Warrior [Lv. 1575]" or Mon == "Dragon Crew Archer [Lv. 1600]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 220 then
                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                        v.HumanoidRootPart.CFrame = PosMon
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                    elseif _G.AutoFarm and StartMagnet and v.Name == Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 275 then
                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                        v.HumanoidRootPart.CFrame = PosMon
                        v.Humanoid:ChangeState(14)
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                    end

BypassTP = false
PosY = "35" ---ความสูงการบินฟาร์ม---
_G.HAKI = true ----ฮาคิเกราะ
spawn(function()
	while wait(.1) do
		if _G.HAKI then 
			if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
				local args = {
					[1] = "Buso"
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			end
		end
	end
end)
