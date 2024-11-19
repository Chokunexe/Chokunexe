local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()


_G.AutoFarm = true

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
                ["CFrameMon"] = CFrame.new(1196.172, 11.8689699, 1616.95923)
            }
        elseif Lv.Value >= 10 and Lv.Value < 29 then
            return {
                ["Mon"] = 'Monkey',
                ["NumQ"] = 1,
                ["NameQ"] = 'JungleQuest',
                ["CFrameQ"] = CFrame.new(-1598.08911, 35.5501175, 153.377838),
                ["CFrameMon"] = CFrame.new(-1619.10632, 21.7005882, 142.148117)
            }
        elseif Lv.Value >= 30 and Lv.Value <= 39 then
            return {
                ["Mon"] = 'Pirate',
                ["NumQ"] = 1,
                ["NameQ"] = 'BuggyQuest1',
                ["CFrameQ"] = CFrame.new(-1140.762939453125, 5.277381896972656, 3830.43017578125),
                ["CFrameMon"] = CFrame.new(-1180.4862060546875, 4.877380847930908, 3948.302978515625)
            }
        elseif Lv.Value >= 40 and Lv.Value <= 59 then
            return {
                ["Mon"] = 'Brute',
                ["NumQ"] = 2,
                ["NameQ"] = 'BuggyQuest1',
                ["CFrameQ"] = CFrame.new(-1140.762939453125, 5.277381896972656, 3830.43017578125),
                ["CFrameMon"] = CFrame.new(-1145.1796875, 14.935205459594727, 4315.4931640625)
            }
        elseif Lv.Value >= 60 and Lv.Value < 69 then
            return {
                ["Mon"] = 'Desert Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'DesertQuest',
                ["CFrameQ"] = CFrame.new(893.2763671875, 6.563793659210205, 4393.5732421875),
                ["CFrameMon"] = CFrame.new(922.5709228515625, 6.574110507965088, 4476.7412109375)
            }
        elseif Lv.Value >= 70 and Lv.Value <= 89 then
            return {
                ["Mon"] = 'Desert Officer',
                ["NumQ"] = 2,
                ["NameQ"] = 'DesertQuest',
                ["CFrameQ"] = CFrame.new(893.2763671875, 6.563793659210205, 4393.5732421875),
                ["CFrameMon"] = CFrame.new(1606.2596435546875, 1.7362850904464722, 4362.77783203125)
            }
        elseif Lv.Value >= 90 and Lv.Value <= 99 then
            return {
                ["Mon"] = 'Snow Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'SnowQuest',
                ["CFrameQ"] = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685),
                ["CFrameMon"] = CFrame.new(1412.92346, 55.3503647, -1260.62036, -0.246266365, -0.0169920288, -0.969053388, 0.000432241941, 0.999844253, -0.0176417865, 0.969202161, -0.00476344163, -0.246220857)
            }
        elseif Lv.Value >= 100 and Lv.Value <= 119 then
            return {
                ["Mon"] = 'Snowman',
                ["NumQ"] = 2,
                ["NameQ"] = 'SnowQuest',
                ["CFrameQ"] = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685),
                ["CFrameMon"] = CFrame.new(1376.86401, 97.2779999, -1396.93115, -0.986755967, 7.71178321e-08, -0.162211925, 7.71531674e-08, 1, 6.08143536e-09, 0.162211925, -6.51427134e-09, -0.986755967)
            }
        elseif Lv.Value >= 120 and Lv.Value <= 129 then
            return {
                ["Mon"] = 'Chief Petty Officer',
                ["NumQ"] = 1,
                ["NameQ"] = 'MarineQuest2',
                ["CFrameQ"] = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                ["CFrameMon"] = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
            }
        elseif Lv.Value >= 130 and Lv.Value <= 174 then
            return {
                ["Mon"] = 'Sky Bandit',
                ["NumQ"] = 1,
                ["NameQ"] = 'SkyQuest',
                ["CFrameQ"] = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268),
                ["CFrameMon"] = CFrame.new(-4959.51367, 365.39267, -2974.56812, 0.964867651, 7.74418396e-08, 0.262737453, -6.95931988e-08, 1, -3.91783708e-08, -0.262737453, 1.95171506e-08, 0.964867651)
            }
        elseif Lv.Value >= 175 and Lv.Value <= 189 then
            return {
                ["Mon"] = 'Dark Master',
                ["NumQ"] = 2,
                ["NameQ"] = 'SkyQuest',
                ["CFrameQ"] = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268),
                ["CFrameMon"] = CFrame.new(-5079.98096, 376.477356, -2194.17139, 0.465965867, -3.69776352e-08, 0.884802461, 3.40249851e-09, 1, 4.00000886e-08, -0.884802461, -1.56281423e-08, 0.465965867)
            }
        elseif Lv.Value >= 190 and Lv.Value <= 209 then
            return {
                ["Mon"] = 'Prisoner',
                ["NumQ"] = 1,
                ["NameQ"] = 'PrisonerQuest',
                ["CFrameQ"] = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712),
                ["CFrameMon"] = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
            }
        end
    end
    return nil
end

local function TW(...)
    local CFrame = {...}
    pcall(function()
        if not _G.StopTween and Char and Char:FindFirstChild("HumanoidRootPart") then
            local Distance = (CFrame[1].Position - Char.HumanoidRootPart.Position).Magnitude
            Tween = game:GetService("TweenService"):Create(Char.HumanoidRootPart, TweenInfo.new(Distance/270, Enum.EasingStyle.Cubic), {CFrame = CFrame[1]})
            if _G.StopTween then 
                Tween:Cancel()
            elseif Char.Humanoid.Health > 0 then 
                Tween:Play() 
            end
            if not Char.HumanoidRootPart:FindFirstChild("OMG Hub") then
                local Noclip = Instance.new("BodyVelocity")
                Noclip.Name = "OMG Hub"
                Noclip.Parent = Char.HumanoidRootPart
                Noclip.MaxForce = Vector3.new(9e99, 9e99, 9e99)
                Noclip.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

local function ClearQ()
    local currentQuest = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    local questData = CheckQuest()
    if questData and not string.find(currentQuest, questData.Mon) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    end
end


getgenv().FastAttack = true
local plr = game.Players.LocalPlayer

local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade()
    local y = CbFw2.activeController
    local ret = y.blades[1]
    if not ret then return end
    while ret.Parent ~= game.Players.LocalPlayer.Character do 
        ret = ret.Parent 
    end
    return ret
end

spawn(function()
    while wait(0.4) do
        if getgenv().FastAttack then
            pcall(function()
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
            end)
        end
    end
end)

local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
local CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local y = debug.getupvalues(CombatFrameworkR)[2]

spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().FastAttack then
            if typeof(y) == "table" then
                pcall(function()
                    CameraShaker:Stop()
                    y.activeController.timeToNextAttack = 0
                    y.activeController.timeToNextAttack = 0
                    y.activeController.hitboxMagnitude = 2048
                    y.activeController.active = false
                    y.activeController.timeToNextBlock = 0
                    y.activeController.focusStart = 0
                    y.activeController.increment = 1
                    y.activeController.blocking = false
                    y.activeController.attacking = false
                    y.activeController.humanoid.AutoRotate = true
                    GetCurrentBlade()
                    local ret = GetCurrentBlade()
                    if ret then
                        ret.activeController.timeToNextAttack = 0
                        ret.activeController.timeToNextAttack = 0
                        ret.activeController.hitboxMagnitude = 2048
                        ret.activeController.active = false
                        ret.activeController.timeToNextBlock = 0
                        ret.activeController.focusStart = 0
                        ret.activeController.increment = 1
                        ret.activeController.blocking = false
                        ret.activeController.attacking = false
                        ret.activeController.humanoid.AutoRotate = true
                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(GetCurrentBlade()))
                        game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                    end
                end)
            end
        end
    end)
end)

spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().Config['ClickAttack'] then
             pcall(function()
                game:GetService'VirtualUser':CaptureController()
						
			game:GetService'VirtualUser':Button1Down(Vector2.new(0,1,0,1))
            end)
        end
    end)
end)


spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoFarm then
                local UIQ = Player.PlayerGui.Main.Quest
                ClearQ()
                local questData = CheckQuest()
                if questData then
                    if not UIQ.Visible or UIQ.Visible == false then
                        TW(questData.CFrameQ)
                        if (questData.CFrameQ.Position - Char.HumanoidRootPart.Position).Magnitude <= 15 then
                            wait(.2)
                            GetQuests(questData.NameQ, questData.NumQ)
                        end
                    else
                        local enemy = game:GetService("Workspace").Enemies:FindFirstChild(questData.Mon)
                        if enemy then
                            repeat
                                if enemy and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                    TW(enemy:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 20, 0))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                else
                                    Char.HumanoidRootPart.CFrame = questData.CFrameMon * CFrame.new(0, 20, 0)
                                end
                                wait(1)
                                enemy = game:GetService("Workspace").Enemies:FindFirstChild(questData.Mon)
                            until not _G.AutoFarm or not UIQ.Visible
                        else
                            Char.HumanoidRootPart.CFrame = questData.CFrameMon * CFrame.new(0, 20, 0)
                        end
                    end
                end
            end
        end)
    end
end)

_G.BringMob = true
spawn(function()
    while wait() do
        if _G.BringMob then
            pcall(function()
                local questData = CheckQuest()
                for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    for x, y in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == questData.Mon then
                            if y.Name == questData.Mon then
                                v.HumanoidRootPart.CFrame = y.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                y.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                y.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                y.Humanoid.WalkSpeed = 0
                                v.Humanoid.JumpPower = 0
                                y.Humanoid.JumpPower = 0
                                if sethiddenproperty then
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
