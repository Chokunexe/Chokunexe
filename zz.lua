getgenv().Config['FastAttack'] = true

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
                                    v.activeController.timeToNextAttack = -(math.huge ^ math.huge ^ math.huge)
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

_G.Click = true

spawn(function()
    while _G.Click do
        pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 20))
        end)
        wait(0.0001)
    end
end)