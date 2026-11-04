-- Exon Hub V1 | Murder Mystery 2 (Rozbudowana wersja)
local Success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Success or not Rayfield then
    warn("Błąd: Nie udało się załadować Rayfield UI!")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "Exon Hub V1 ⚡ | MM2 Pro",
   LoadingTitle = "Ładowanie Exon Hub...",
   LoadingSubtitle = "Rozbudowana wersja",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Serwisy i zmienne
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

_G.SpeedVal = 16
_G.JumpVal = 50
_G.FovVal = 70
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeed = 50
_G.KillAuraOn = false
_G.KillAuraRange = 15
_G.AutoShootSheriff = false
_G.EspRolesOn = false
_G.EspNamesOn = false
_G.EspCoinsOn = false
_G.EspTrapsOn = false
_G.EspGunDropOn = false

-- Kolory ESP dla ról
_G.MurderColor = Color3.fromRGB(255, 0, 0)
_G.SheriffColor = Color3.fromRGB(0, 120, 255)
_G.InnocentColor = Color3.fromRGB(0, 255, 0)

-- Zakładki
local TabHome = Window:CreateTab("Start", 4483362458)
local TabPlayer = Window:CreateTab("Character", 4483362458)
local TabMurder = Window:CreateTab("Murder", 4483362458)
local TabSheriff = Window:CreateTab("Sheriff", 4483362458)
local TabEsp = Window:CreateTab("ESP & Alerts", 4483362458)
local TabTeleport = Window:CreateTab("Teleport", 4483362458)
local TabTroll = Window:CreateTab("Troll", 4483362458)

-------------------------------------------------
-- ZAKŁADKA: START
-------------------------------------------------
TabHome:CreateParagraph({
   Title = "Witaj w Exon Hub!",
   Content = "Witam w Exon Hub to skrypt do MM2. Życzę miłego grania V1"
})

-------------------------------------------------
-- ZAKŁADKA: CHARACTER
-------------------------------------------------
TabPlayer:CreateSlider({
   Name = "WalkSpeed (Prędkość)",
   Range = {1, 1000},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      _G.SpeedVal = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
          LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

TabPlayer:CreateSlider({
   Name = "JumpPower (Siła skoku)",
   Range = {1, 1000},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpSlider",
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
   Range = {1, 1000},
   Increment = 1,
   Suffix = "°",
   CurrentValue = 70,
   Flag = "FovSlider",
   Callback = function(Value)
      _G.FovVal = Value
      Camera.FieldOfView = Value
   end,
})

TabPlayer:CreateToggle({
   Name = "Noclip (Przenikanie przez ściany)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value) _G.NoclipOn = Value end,
})

TabPlayer:CreateToggle({
   Name = "Infinite Jump (Nieskończone skoki)",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value) _G.InfJumpOn = Value end,
})

TabPlayer:CreateToggle({
   Name = "Fly (Latanie)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value) _G.FlyOn = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: MURDER
-------------------------------------------------
TabMurder:CreateToggle({
   Name = "Kill Aura Pro",
   CurrentValue = false,
   Flag = "KillAuraToggle",
   Callback = function(Value) _G.KillAuraOn = Value end,
})

TabMurder:CreateSlider({
   Name = "Zasięg Kill Aury",
   Range = {10, 100},
   Increment = 5,
   Suffix = " studów",
   CurrentValue = 15,
   Flag = "KARangeSlider",
   Callback = function(Value) _G.KillAuraRange = Value end,
})

TabMurder:CreateButton({
   Name = "🔥 KILL ALL (Teleport do żywych graczy w rundzie)",
   Callback = function()
      local knife = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife"))
      if knife then
          knife.Parent = LocalPlayer.Character
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  local hum = p.Character:FindFirstChildOfClass("Humanoid")
                  -- Sprawdzamy czy gracz żyje i jest w rundzie (np. ma więcej niż 0 HP)
                  if hum and hum.Health > 0 then
                      LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                      pcall(function() knife:Activate() end)
                      task.wait(0.05)
                  end
              end
          end
      end
   end,
})

-------------------------------------------------
-- ZAKŁADKA: SHERIFF
-------------------------------------------------
TabSheriff:CreateToggle({
   Name = "🎯 Auto-Shoot Murderer (Strzał przez ściany)",
   CurrentValue = false,
   Flag = "AutoShootToggle",
   Callback = function(Value) _G.AutoShootSheriff = Value end,
})

TabSheriff:CreateButton({
   Name = "🔫 Strzał w Mordercę natychmiast (Jednorazowy)",
   Callback = function()
      pcall(function()
          local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Character:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Revolver")
          if gun then
              gun.Parent = LocalPlayer.Character
              for _, p in pairs(Players:GetPlayers()) do
                  if p ~= LocalPlayer and p.Character then
                      local bp = p:FindFirstChild("Backpack")
                      local isMurderer = (bp and bp:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
                      if isMurderer and p.Character:FindFirstChild("HumanoidRootPart") then
                          gun.Shoot:FireServer(p.Character.HumanoidRootPart.Position)
                      end
                  end
              end
          end
      end)
   end,
})

TabSheriff:CreateButton({
   Name = "🎯 Auto-Namierz celownik na Mordercę",
   Callback = function()
      pcall(function()
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character then
                  local bp = p:FindFirstChild("Backpack")
                  local isMurderer = (bp and bp:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
                  if isMurderer and p.Character:FindFirstChild("Head") then
                      Camera.CFrame = CFrame.new(Camera.CFrame.Position, p.Character.Head.Position)
                  end
              end
          end
      end)
   end,
})

-------------------------------------------------
-- ZAKŁADKA: ESP & ALERTS
-------------------------------------------------
TabEsp:CreateToggle({
   Name = "ESP Ról (Kolory postacie)",
   CurrentValue = false,
   Flag = "EspRolesToggle",
   Callback = function(Value) _G.EspRolesOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Nazw i Ról nad głowami",
   CurrentValue = false,
   Flag = "EspNamesToggle",
   Callback = function(Value) _G.EspNamesOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Coinów (Monety)",
   CurrentValue = false,
   Flag = "EspCoinsToggle",
   Callback = function(Value) _G.EspCoinsOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Trapów (Ulepszone z dystansem)",
   CurrentValue = false,
   Flag = "EspTrapsToggle",
   Callback = function(Value) _G.EspTrapsOn = Value end,
})

TabEsp:CreateToggle({
   Name = "ESP Dropped Gun (Ulepszone z info o brionii)",
   CurrentValue = false,
   Flag = "EspGunDropToggle",
   Callback = function(Value) _G.EspGunDropOn = Value end,
})

-- Wybór kolorów ról w ESP
TabEsp:CreateColorPicker({
   Name = "Kolor Mordercy w ESP",
   Color = Color3.fromRGB(255, 0, 0),
   Flag = "MurderColorPicker",
   Callback = function(Value) _G.MurderColor = Value end,
})

TabEsp:CreateColorPicker({
   Name = "Kolor Szeryfa w ESP",
   Color = Color3.fromRGB(0, 120, 255),
   Flag = "SheriffColorPicker",
   Callback = function(Value) _G.SheriffColor = Value end,
})

TabEsp:CreateColorPicker({
   Name = "Kolor Niewinnego w ESP",
   Color = Color3.fromRGB(0, 255, 0),
   Flag = "InnocentColorPicker",
   Callback = function(Value) _G.InnocentColor = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: TELEPORT
-------------------------------------------------
TabTeleport:CreateButton({
   Name = "📍 Teleport do Lobby",
   Callback = function()
      pcall(function()
          if Workspace:FindFirstChild("Lobby") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              -- Przykładowa pozycja lobby lub szukanie spawnu
              LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
          end
      end)
   end,
})

TabTeleport:CreateButton({
   Name = "🗺️ Teleport na Mapę (Gra)",
   Callback = function()
      pcall(function()
          for _, v in pairs(Workspace:GetChildren()) do
              if v:IsA("Model") and v:FindFirstChild("Spawns") then
                  local spawnPart = v.Spawns:GetChildren()[1]
                  if spawnPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                      LocalPlayer.Character.HumanoidRootPart.CFrame = spawnPart.CFrame + Vector3.new(0, 5, 0)
                  end
              end
          end
      end)
   end,
})

TabTeleport:CreateButton({
   Name = "gun drop teleport (Do upuszczonej broni)",
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
-- ZAKŁADKA: TROLL
-------------------------------------------------
TabTroll:CreateButton({
   Name = "🌪️ Skok-Zmyłka (Teleport w górę)",
   Callback = function()
      pcall(function()
          local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if root then root.CFrame = root.CFrame + Vector3.new(0, 20, 0) end
      end)
   end,
})

TabTroll:CreateButton({
   Name = "🚀 Wywal gracza poza mapę (Fling Nearest)",
   Callback = function()
      pcall(function()
          local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if not root then return end
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  local targetRoot = p.Character.HumanoidRootPart
                  if (root.Position - targetRoot.Position).Magnitude < 15 then
                      local bv = Instance.new("BodyVelocity")
                      bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                      bv.Velocity = Vector3.new(99999, 99999, 99999)
                      bv.Parent = root
                      task.wait(0.2)
                      bv:Destroy()
                  end
              end
          end
      end)
   end,
})

TabTroll:CreateButton({
   Name = "📢 Oskarż losowego gracza na chacie",
   Callback = function()
      pcall(function()
          local targets = {}
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer then table.insert(targets, p.Name) end
          end
          if #targets > 0 then
              local chosen = targets[math.random(1, #targets)]
              game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("TO ON! MURDERER TO " .. string.upper(chosen) + "!", "All")
          end
      end)
   end,
})

-------------------------------------------------
-- PĘTLE W TLE (LOGIKA)
-------------------------------------------------
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
                    local dist = (myRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= _G.KillAuraRange then
                        knife.Parent = LocalPlayer.Character
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
                if p ~= LocalPlayer and p.Character then
                    local bp = p:FindFirstChild("Backpack")
                    local isMurderer = (bp and bp:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
                    if isMurderer and p.Character:FindFirstChild("HumanoidRootPart") then
                        gun.Parent = LocalPlayer.Character
                        pcall(function()
                            gun.Shoot:FireServer(p.Character.HumanoidRootPart.Position)
                        end)
                    end
                end
            end
        end
    end
    
    -- ESP Aktualizacje
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local col = _G.InnocentColor
            local roleStr = "Innocent"
            
            local bp = p:FindFirstChild("Backpack")
            if (bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("Revolver") or bp:FindFirstChild("Gun"))) or char:FindFirstChild("Knife") or char:FindFirstChild("Revolver") or char:FindFirstChild("Gun") then
                if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                    col = _G.MurderColor
                    roleStr = "Murderer"
                else
                    col = _G.SheriffColor
                    roleStr = "Sheriff"
                end
            end
            
            if _G.EspRolesOn then
                local hl = char:FindFirstChild("ExonESP")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "ExonESP"
                    hl.Parent = char
                end
                hl.FillColor = col
            else
                if char:FindFirstChild("ExonESP") then char.ExonESP:Destroy() end
            end
            
            if _G.EspNamesOn then
                local head = char:FindFirstChild("Head")
                if head then
                    local bg = head:FindFirstChild("ExonNameTag")
                    if not bg then
                        bg = Instance.new("BillboardGui")
                        bg.Name = "ExonNameTag"
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
                if head and head:FindFirstChild("ExonNameTag") then head.ExonNameTag:Destroy() end
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
            velocity = Camera.CFrame.L
