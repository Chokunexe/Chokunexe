local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()


_G.AutoFarm = true

local function GetQuests(NameQuest,LvQuest)
    local args = {
        [1] = "StartQuest",
        [2] = NameQuest,
        [3] = LvQuest
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))    
end

function CheckQuest()
    local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Lv >= 1 or Lv <= 9 then
        Mon = "Bandit [Lv. 5]"
        NameMon = "Bandit"
        LvQuest = 1
        NameQuest = "BanditQuest1"
        CFrameMon = CFrame.new(1038.2711, 24.5372, 1550.2586)
        CFrameQuest = CFrame.new(1059.8109, 16.3627, 1549.0882)
    elseif Lv >= 10 or Lv <= 14 then
        Mon = "Monkey [Lv. 14]"
        NameMon = "Monkey"
        LvQuest = 1
        NameQuest = "JungleQuest"
        CFrameMon = CFrame.new(-1443.7662, 61.8519, -47.5559)
        CFrameQuest = CFrame.new(-1599.8194, 36.8521, 153.0706)
    elseif Lv >= 15 or Lv <= 99 then
        Mon = "Gorilla [Lv. 20]"
        NameMon = "Gorilla"
        LvQuest = 2
        NameQuest = "JungleQuest"
        CFrameMon = CFrame.new(-1443.7662, 61.8519, -47.5559)
        CFrameQuest = CFrame.new(-1599.8194, 36.8521, 153.0706)
    end
end

function Equip(ToolX)
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX) then
        getgenv().Tol = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tol)
    end
end


function TP(P)
    local Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed = 280
    local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local tween = tweenService:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, tweenInfo, { CFrame = P })
    tween:Play()
end


(getgenv()).Config = {
    ["FastAttack"] = true
} 

coroutine.wrap(function()
    local StopCamera = require(game.ReplicatedStorage.Util.CameraShaker)
    StopCamera:Stop()
    
    for v, v in pairs(getreg()) do
        if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework then
            for v, v in pairs(debug.getupvalues(v)) do
                if typeof(v) == "table" then
                    spawn(function()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if getgenv().Config['FastAttack'] then
                                pcall(function()
                                    v.activeController.timeToNextAttack = 280
                                    v.activeController.attacking = false
                                    v.activeController.increment = 4
                                    v.activeController.blocking = false   
                                    v.activeController.hitboxMagnitude = 150
                                    v.activeController.humanoid.AutoRotate = true
                                    v.activeController.focusStart = 0
                                    v.activeController.currentAttackTrack = 0
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRaxNerous", math.huge)
                                end)
                            end
                        end)
                    end)
                end
            end
        end
    end
end)()

function click()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
end


spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                CheckQuest()
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    TP(CFrameQuest)
                    if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(0.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LvQuest)
                    end
                else
                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                        for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                                if v.Humanoid.Health > 0 then
                                    repeat
                                        wait()
                                        click()
                                        Equip(_G.SelectWeapon)
                                        local HealthMin = v.Humanoid.MaxHealth * 90 / 100
                                        local Magma = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                        if Magma <= 230 then
                                            if v.Humanoid.Health > HealthMin then
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 14)
                                            else
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                                            end
                                        end
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.CanCollide = false
                                    until not _G.AutoFarm or v.Humanoid.Health <= 0
                                else
                                    TP(CFrameMon)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        if _G.AutoFarm then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                setfflag("HumanoidParallelRemoveNoPhysics", "False")
                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end
    end)
end)


_G.BringMob = true
spawn(function()
    while wait() do
        if _G.BringMob then
            pcall(function()
                CheckQuest()
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    for _, y in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == Mon and y.Name == Mon then
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
            end)
        end
    end
end)