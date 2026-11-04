-- Jasiu Hub V4 | Murder Mystery 2 (Clean & Stable Edition dla Arceus X)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Jasiu Hub V4 🌲 | MM2 Ultimate Pro",
   LoadingTitle = "Ładowanie Jasiu Hub V4...",
   LoadingSubtitle = "Oficjalna stabilna wersja",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Zakładki
local TabMurder = Window:CreateTab("Murder", 4483362458)
local TabSheriff = Window:CreateTab("Sheriff", 4483362458)
local TabFarm = Window:CreateTab("Auto Farm", 4483362458)
local TabPlayer = Window:CreateTab("Player", 4483362458)
local TabEsp = Window:CreateTab("ESP & Alerts", 4483362458)
local TabUtility = Window:CreateTab("Utility", 4483362458)
local TabTroll = Window:CreateTab("Troll", 4483362458)

-- Serwisy i Zmienne
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

_G.KillAuraOn = false
_G.KillAuraRange = 15
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeed = 50
_G.EspRolesOn = false
_G.EspCoinsOn = false
_G.EspTrapsOn = false
_G.EspNamesOn = false
_G.EspGunDropOn = false
_G.AutoShootSheriff = false
_G.AutoFarmCoins = false
_G.CoinAuraOn = false
_G.CrosshairOn = false
_G.AntiAfkOn = true
_G.RoleAlertOn = true
_G.FovVal = 70

-------------------------------------------------
-- ZAKŁADKA: MURDER
-------------------------------------------------
TabMurder:CreateToggle({
   Name = "⚡ Ultra Kill Aura Pro",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value) _G.KillAuraOn = Value end,
})

TabMurder:CreateSlider({
   Name = "Zasięg Kill Aury",
   Range = {10, 150},
   Increment = 5,
   Suffix = " studów",
   CurrentValue = 15,
   Flag = "KARange",
   Callback = function(Value) _G.KillAuraRange = Value end,
})

TabMurder:CreateButton({
   Name = "🔥 KILL ALL (Zabij wszystkich)",
   Callback = function()
      local knife = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife"))
      if knife then
          knife.Parent = LocalPlayer.Character
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                  pcall(function() knife:Activate() end)
              end
          end
      end
   end,
})

-------------------------------------------------
-- ZAKŁADKA: SHERIFF
-------------------------------------------------
TabSheriff:CreateToggle({
   Name = "🎯 Auto-Shoot / Silent Aim (Strzał w Murderera)",
   CurrentValue = false,
   Flag = "AutoShoot",
   Callback = function(Value) _G.AutoShootSheriff = Value end,
})

TabSheriff:CreateButton({
   Name = "Teleport do upuszczonej broni",
   Callback = function()
      for _, v in pairs(Workspace:GetChildren()) do
          if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
              if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                  LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
              end
          end
      end
   end,
})

-------------------------------------------------
-- ZAKŁADKA: AUTO FARM
-------------------------------------------------
TabFarm:CreateToggle({
   Name = "🪙 Auto-Farm Monet (Teleport do Coinów)",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value) _G.AutoFarmCoins = Value end,
})

TabFarm:CreateToggle({
   Name = "🧲 Coin Aura (Przyciąganie monet w promieniu 25m)",
   CurrentValue = false,
   Flag = "CoinAura",
   Callback = function(Value) _G.CoinAuraOn = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: PLAYER
-------------------------------------------------
TabPlayer:CreateSlider({
   Name = "Prędkość (WalkSpeed)",
   Range = {16, 250},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      _G.SpeedVal = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
          LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

TabPlayer:CreateSlider({
   Name = "Siła Skoku (JumpPower)",
   Range = {50, 300},
   Increment = 5,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      _G.JumpVal = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
          LocalPlayer.Character.Humanoid.UseJumpPower = true
          LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

TabPlayer:CreateSlider({
   Name = "FOV (Pole widzenia)",
   Range = {70, 120},
   Increment = 1,
   Suffix = "°",
   CurrentValue = 70,
   Flag = "FovSlider",
   Callback = function(Value)
      _G.FovVal = Value
      Camera.FieldOfView = Value
   end,
})

TabPlayer:CreateButton({
   Name = "🛡️ Safe Zone (Teleport na górę mapy)",
   Callback = function()
      pcall(function()
          local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if root then
              root.CFrame = root.CFrame + Vector3.new(0, 50, 0)
          end
      end)
   end,
})

TabPlayer:CreateToggle({
   Name = "Noclip (Przenikanie przez ściany)",
   CurrentValue = false,
   Flag = "Noclip",
   Callback = function(Value) _G.NoclipOn = Value end,
})

TabPlayer:CreateToggle({
   Name = "Infinite Jump (Nieskończony skok)",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value) _G.InfJumpOn = Value end,
})

TabPlayer:CreateToggle({
   Name = "Fly (Latanie)",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(Value) _G.FlyOn = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: ESP & ALERTS
-------------------------------------------------
TabEsp:CreateToggle({
   Name = "🔔 Role Alerts (Powiadomienia o roli na starcie)",
   CurrentValue = true,
   Flag = "RoleAlertToggle",
   Callback = function(Value) _G.RoleAlertOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Ról (Kolory postaci)",
   CurrentValue = false,
   Flag = "EspRoles",
   Callback = function(Value) _G.EspRolesOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Nazw i Ról nad głowami",
   CurrentValue = false,
   Flag = "EspNames",
   Callback = function(Value) _G.EspNamesOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Coinów (Monety)",
   CurrentValue = false,
   Flag = "EspCoins",
   Callback = function(Value) _G.EspCoinsOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Trapów (Pułapki)",
   CurrentValue = false,
   Flag = "EspTraps",
   Callback = function(Value) _G.EspTrapsOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Dropped Gun (Widoczność leżącej broni)",
   CurrentValue = false,
   Flag = "EspGunDrop",
   Callback = function(Value) _G.EspGunDropOn = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: UTILITY & VISUAL
-------------------------------------------------
local crosshairGui = nil
TabUtility:CreateToggle({
   Name = "🎯 Customowy Celownik (Crosshair)",
   CurrentValue = false,
   Flag = "CrosshairToggle",
   Callback = function(Value)
      _G.CrosshairOn = Value
      if Value then
          if not crosshairGui then
              crosshairGui = Instance.new("ScreenGui")
              crosshairGui.Name = "JasiuCrosshair"
              crosshairGui.Parent = CoreGui
              
              local dot = Instance.new("Frame")
              dot.Size = UDim2.new(0, 6, 0, 6)
              dot.Position = UDim2.new(0.5, -3, 0.5, -3)
              dot.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
              dot.BorderSizePixel = 0
              dot.Parent = crosshairGui
          end
      else
          if crosshairGui then
              crosshairGui:Destroy()
              crosshairGui = nil
          end
      end
   end,
})

TabUtility:CreateToggle({
   Name = "🛡️ Anti-AFK (Ochrona przed AFK Kick)",
   CurrentValue = true,
   Flag = "AntiAfkToggle",
   Callback = function(Value) _G.AntiAfkOn = Value end,
})

TabUtility:CreateButton({
   Name = "🔄 Server Hop (Zmień serwer)",
   Callback = function()
      TeleportService:Teleport(game.PlaceId, LocalPlayer)
   end,
})

TabUtility:CreateButton({
   Name = "🔁 Rejoin (Dołącz ponownie do tego samego serwera)",
   Callback = function()
      TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
   end,
})

-------------------------------------------------
-- ZAKŁADKA: TROLL
-------------------------------------------------
TabTroll:CreateButton({
   Name = "🌀 Skok-Zmyłka (Teleportuj się 15 studów w górę)",
   Callback = function()
      pcall(function()
          local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if root then
              root.CFrame = root.CFrame + Vector3.new(0, 15, 0)
          end
      end)
   end,
})

-------------------------------------------------
-- GŁÓWNE PĘTLE W TLE
-------------------------------------------------
LocalPlayer.Idled:Connect(function()
    if _G.AntiAfkOn then
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myRoot = LocalPlayer.Character.HumanoidRootPart
                
                if _G.AutoFarmCoins then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if not _G.AutoFarmCoins then break end
                        if v.Name == "CoinContainer" or v.Name == "Coin" then
                            local part = v:IsA("Model") and v.PrimaryPart or v
                            if part and part:IsA("BasePart") then
                                myRoot.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                task.wait(0.15)
                            end
                        end
                    end
                end
                
                if _G.CoinAuraOn then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v.Name == "CoinContainer" or v.Name == "Coin" then
                            local part = v:IsA("Model") and v.PrimaryPart or v
                            if part and part:IsA("BasePart") then
                                if (myRoot.Position - part.Position).Magnitude <= 25 then
                                    part.CFrame = myRoot.CFrame
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

RunService.Stepped:Connect(function()
    if _G.NoclipOn and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    if _G.KillAuraOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LocalPlayer.Character.HumanoidRootPart
        local knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
        
        if knife then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = p.Character.HumanoidRootPart
                    local dist = (myRoot.Position - targetRoot.Position).Magnitude
                    
                    if dist <= _G.KillAuraRange then
                        if knife.Parent ~= LocalPlayer.Character then
                            knife.Parent = LocalPlayer.Character
                        end
                        pcall(function() knife:Activate() end)
                    end
                end
            end
        end
    end
    
    if _G.AutoShootSheriff and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Character:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Revolver")
        if gun then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local isMurderer = p.Character:FindFirstChild("Knife") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Knife"))
                    if isMurderer then
                        gun.Parent = LocalPlayer.Character
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position)
                        pcall(function() gun:Activate() end)
                    end
                end
            end
        end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local col = Color3.fromRGB(0, 255, 0)
            local roleStr = "Innocent"
            
            local bp = p:FindFirstChild("Backpack")
            if (bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("Revolver") or bp:FindFirstChild("Gun"))) or char:FindFirstChild("Knife") or char:FindFirstChild("Revolver") or char:FindFirstChild("Gun") then
                if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                    col = Color3.fromRGB(255, 0, 0)
                    roleStr = "Murderer"
                else
                    col = Color3.fromRGB(0, 120, 255)
                    roleStr = "Sheriff"
                end
            end
            
            if _G.EspRolesOn then
                local hl = char:FindFirstChild("JasiuESP")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "JasiuESP"
                    hl.Parent = char
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
                hl.FillColor = col
            else
                if char:FindFirstChild("JasiuESP") then char.JasiuESP:Destroy() end
            end
            
            if _G.EspNamesOn then
                local head = char:FindFirstChild("Head")
                if head then
                    local bg = head:FindFirstChild("JasiuNameTag")
                    if not bg then
                        bg = Instance.new("BillboardGui")
                        bg.Name = "JasiuNameTag"
                        bg.Size = UDim2.new(0, 100, 0, 40)
                        bg.StudsOffset = Vector3.new(0, 2.5, 0)
                        bg.AlwaysOnTop = true
                        bg.Parent = head
                        
                        local txt = Instance.new("TextLabel")
                        txt.Name = "TagText"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextSize = 13
                        txt.Font = Enum.Font.SourceSansBold
                        txt.Parent = bg
                    end
                    local t = bg:FindFirstChild("TagText")
                    if t then
                        t.Text = p.Name .. "\n[" .. roleStr .. "]"
                        t.TextColor3 = col
                    end
                end
            else
                local head = char:FindFirstChild("Head")
                if head and head:FindFirstChild("JasiuNameTag") then
                    head.JasiuNameTag:Destroy()
                end
            end
        end
    end
    
    if _G.EspCoinsOn then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "CoinContainer" or v.Name == "Coin" then
                if not v:FindFirstChild("CoinHighlight") then
                    local ch = Instance.new("Highlight")
                    ch.Name = "CoinHighlight"
                    ch.FillColor = Color3.fromRGB(255, 215, 0)
                    ch.Parent = v
                end
            end
        end
    else
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "CoinHighlight" then v:Destroy() end
        end
    end
    
    if _G.EspTrapsOn then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "Trap" or (v.Name and string.lower(v.Name):find("trap")) then
                if not v:FindFirstChild("TrapHighlight") then
                    local th = Instance.new("Highlight")
                    th.Name = "TrapHighlight"
                    th.FillColor = Color3.fromRGB(255, 128, 0)
                    th.Parent = v
                end
            end
        end
    else
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "TrapHighlight" then v:Destroy() end
        end
    end

    if _G.EspGunDropOn then
        for _, v in pairs(Workspace:GetChildren()) do
            if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
                if not v:FindFirstChild("GunHighlight") then
                    local gh = Instance.new("Highlight")
                    gh.Name = "GunHighlight"
                    gh.FillColor = Color3.fromRGB(0, 150, 255)
                    gh.Parent = v
                end
            end
        end
    else
        for _, v in pairs(Workspace:GetChildren()) do
            if v:FindFirstChild("GunHighlight") then
                v.GunHighlight:Destroy()
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJumpOn then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.FlyOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.PlatformStand = true
        local moveDirection = humanoid.MoveDirection
        local velocity = Vector3.new(0, 0, 0)
        if moveDirection.Magnitude > 0 then
            velocity = Camera.CFrame.LookVector * (moveDirection.Z * _G.FlySpeed) + Camera.CFrame.RightVector * (moveDirection.X * _G.FlySpeed)
        end
        rootPart.Velocity = velocity
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end)
