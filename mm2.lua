-- Jasiu Hub V2 | MM2 Mobile (Rayfield + Piękna podążająca kula Vortex)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Jasiu Hub V2 🌲 | MM2 Pro",
   LoadingTitle = "Ładowanie Jasiu Hub V2...",
   LoadingSubtitle = "Stworzone dla Arceus X",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Zakładki
local TabMurder = Window:CreateTab("Murder", 4483362458)
local TabSheriff = Window:CreateTab("Sheriff", 4483362458)
local TabPlayer = Window:CreateTab("Player", 4483362458)
local TabEsp = Window:CreateTab("ESP", 4483362458)
local TabTroll = Window:CreateTab("Troll", 4483362458)
local TabVisual = Window:CreateTab("Visual", 4483362458)

-- Serwisy
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

_G.KillAuraOn = false
_G.KillAuraRange = 10
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeed = 50
_G.InvisibilityOn = false
_G.EspRolesOn = false
_G.EspCoinsOn = false
_G.EspTrapsOn = false
_G.EspNamesOn = false
_G.EspGunDropOn = false
_G.VortexActive = false

-------------------------------------------------
-- ZAKŁADKA: MURDER
-------------------------------------------------
TabMurder:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value) _G.KillAuraOn = Value end,
})

TabMurder:CreateSlider({
   Name = "Zasięg Kill Aury",
   Range = {10, 100},
   Increment = 5,
   Suffix = " studów",
   CurrentValue = 10,
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

TabPlayer:CreateToggle({
   Name = "Niewidzialność (Ultra Invisible - nic nie widać)",
   CurrentValue = false,
   Flag = "Invisible",
   Callback = function(Value)
      _G.InvisibilityOn = Value
      if not Value and LocalPlayer.Character then
          for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
              if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                  part.Transparency = 0
              elseif part:IsA("Decal") then
                  part.Transparency = 0
              end
          end
      end
   end,
})

-------------------------------------------------
-- ZAKŁADKA: ESP
-------------------------------------------------
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
   Name = "ESP Dropped Gun (Leżąca broń)",
   CurrentValue = false,
   Flag = "EspGunDrop",
   Callback = function(Value) _G.EspGunDropOn = Value end,
})

-------------------------------------------------
-- ZAKŁADKA: TROLL (Piękny Vortex Podążający za Tobą)
-------------------------------------------------
local vortexOrb = nil

TabTroll:CreateToggle({
   Name = "🌀 Piękny Vortex Spawner (Chodzi za Tobą)",
   CurrentValue = false,
   Flag = "VortexToggle",
   Callback = function(Value)
      _G.VortexActive = Value
      if Value then
          -- Tworzenie pięknej, świecącej, pulsującej kuli
          if not vortexOrb and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              vortexOrb = Instance.new("Part")
              vortexOrb.Shape = Enum.PartType.Ball
              vortexOrb.Size = Vector3.new(5, 5, 5)
              vortexOrb.BrickColor = BrickColor.new("Cyan")
              vortexOrb.Material = Enum.Material.Neon
              vortexOrb.CanCollide = false
              vortexOrb.Anchored = true
              
              -- Dodanie świecącego efektu (Highlight/Particle)
              local fire = Instance.new("Fire")
              fire.Size = 6
              fire.Heat = 5
              fire.Color = Color3.fromRGB(0, 200, 255)
              fire.SecondaryColor = Color3.fromRGB(255, 0, 255)
              fire.Parent = vortexOrb
              
              vortexOrb.Parent = Workspace
          end
      else
          if vortexOrb then
              vortexOrb:Destroy()
              vortexOrb = nil
          end
      end
   end,
})

-------------------------------------------------
-- ZAKŁADKA: VISUAL
-------------------------------------------------
TabVisual:CreateButton({
   Name = "💀 Fake Headless (Usunięcie głowy)",
   Callback = function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
          LocalPlayer.Character.Head.Transparency = 1
          if LocalPlayer.Character.Head:FindFirstChildOfClass("Decal") then
              LocalPlayer.Character.Head:FindFirstChildOfClass("Decal").Transparency = 1
          end
      end
   end,
})

TabVisual:CreateButton({
   Name = "🦵 Fake Korblox Right Leg",
   Callback = function()
      if LocalPlayer.Character then
          local leg = LocalPlayer.Character:FindFirstChild("RightLowerLeg") or LocalPlayer.Character:FindFirstChild("Right Leg")
          if leg then
              leg.MeshId = "rbxassetid://902942093"
              leg.Transparency = 0
          end
      end
   end,
})

TabVisual:CreateDropdown({
   Name = "🎨 10 Efektów Shader / Style",
   Options = {"Domyślny", "Cyberpunk", "Sunset Vibes", "Golden Hour", "RTX Glow", "Neon City", "Dark Fantasy", "Pastel World", "Soft Bloom", "Cinema Dramatic"},
   CurrentOption = "Domyślny",
   Flag = "ShadersDropdown",
   Callback = function(Option)
      Lighting.ClockTime = 14
      Lighting.Brightness = 2
      Lighting.FogEnd = 100000
      
      if Option == "Cyberpunk" then
          Lighting.Ambient = Color3.fromRGB(255, 0, 150)
          Lighting.OutdoorAmbient = Color3.fromRGB(0, 255, 255)
      elseif Option == "Sunset Vibes" then
          Lighting.ClockTime = 18
          Lighting.Ambient = Color3.fromRGB(255, 100, 50)
      elseif Option == "Golden Hour" then
          Lighting.ClockTime = 17.5
          Lighting.Brightness = 3
          Lighting.Ambient = Color3.fromRGB(255, 200, 100)
      elseif Option == "RTX Glow" then
          Lighting.Brightness = 4
          Lighting.Ambient = Color3.fromRGB(200, 200, 255)
      elseif Option == "Neon City" then
          Lighting.ClockTime = 0
          Lighting.Ambient = Color3.fromRGB(0, 255, 150)
      elseif Option == "Dark Fantasy" then
          Lighting.ClockTime = 1
          Lighting.Ambient = Color3.fromRGB(80, 0, 120)
      elseif Option == "Pastel World" then
          Lighting.Ambient = Color3.fromRGB(255, 220, 230)
      elseif Option == "Soft Bloom" then
          Lighting.Brightness = 3
          Lighting.Ambient = Color3.fromRGB(240, 240, 240)
      elseif Option == "Cinema Dramatic" then
          Lighting.ClockTime = 19
          Lighting.Brightness = 1.5
          Lighting.Ambient = Color3.fromRGB(100, 100, 120)
      end
   end,
})

TabVisual:CreateDropdown({
   Name = "🌤️ 10 Shaderów Pogody",
   Options = {"Słonecznie", "Gęsta Mgła", "Ciemna Noc", "Deszczowa Burza", "Śnieżyca", "Krwawy Księżyc", "Zaćmienie", "Złota Mgła", "Pochmurno", "Mroźna Poranek"},
   CurrentOption = "Słonecznie",
   Flag = "WeatherDropdown",
   Callback = function(Option)
      Lighting.FogEnd = 100000
      Lighting.ClockTime = 14
      
      if Option == "Gęsta Mgła" then
          Lighting.FogEnd = 150
          Lighting.FogColor = Color3.fromRGB(200, 200, 200)
      elseif Option == "Ciemna Noc" then
          Lighting.ClockTime = 0
          Lighting.Brightness = 0.2
      elseif Option == "Deszczowa Burza" then
          Lighting.ClockTime = 14
          Lighting.FogEnd = 300
          Lighting.FogColor = Color3.fromRGB(80, 90, 100)
      elseif Option == "Śnieżyca" then
          Lighting.FogEnd = 200
          Lighting.FogColor = Color3.fromRGB(240, 245, 255)
      elseif Option == "Krwawy Księżyc" then
          Lighting.ClockTime = 0
          Lighting.Ambient = Color3.fromRGB(255, 0, 0)
      elseif Option == "Zaćmienie" then
          Lighting.ClockTime = 12
          Lighting.Brightness = 0.1
          Lighting.Ambient = Color3.fromRGB(40, 40, 50)
      elseif Option == "Złota Mgła" then
          Lighting.FogEnd = 300
          Lighting.FogColor = Color3.fromRGB(255, 200, 100)
      elseif Option == "Pochmurno" then
          Lighting.Brightness = 1
          Lighting.Ambient = Color3.fromRGB(150, 150, 150)
      elseif Option == "Mroźna Poranek" then
          Lighting.ClockTime = 6
          Lighting.Ambient = Color3.fromRGB(180, 220, 255)
      end
   end,
})

local targetUsername = ""
TabVisual:CreateInput({
   Name = "Nazwa gracza do sklonowania",
   PlaceholderText = "Wpisz nick gracza...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      targetUsername = Text
   end,
})

TabVisual:CreateButton({
   Name = "Zmień się w wybranego gracza (Apply)",
   Callback = function()
      if targetUsername ~= "" then
          pcall(function()
              local targetPlayer = Players:FindFirstChild(targetUsername)
              if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
                  local userId = targetPlayer.UserId
                  local humDesc = Players:GetHumanoidDescriptionFromUserId(userId)
                  if humDesc and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                      LocalPlayer.Character.Humanoid:ApplyDescription(humDesc)
                  end
              end
          end)
      end
   end,
})

-------------------------------------------------
-- GŁÓWNE PĘTLE W TLE
-------------------------------------------------
RunService.Stepped:Connect(function()
    if _G.NoclipOn and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    if _G.InvisibilityOn and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
            elseif part:IsA("Decal") then
                part.Transparency = 1
            end
        end
    end
    
    -- Ruchoma, piękna kula Vortex chodząca za Tobą
    if _G.VortexActive and vortexOrb and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        -- Obraca się wokół Ciebie i śledzi Twoją pozycję
        local angle = tick() * 4
        local offset = Vector3.new(math.cos(angle) * 6, 2, math.sin(angle) * 6)
        vortexOrb.Position = root.Position + offset
        
        -- Wciąganie graczy w pobliżu poza mapę
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - vortexOrb.Position).Magnitude
                if dist <= 8 then
                    p.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
                end
            end
        end
    end
    
    if _G.KillAuraOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LocalPlayer.Character.HumanoidRootPart
        local knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
        if knife then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if (myRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude <= _G.KillAuraRange then
                        knife.Parent = LocalPlayer.Character
                        pcall(function() knife:Activate() end)
                    end
                end
            end
        end
    end
    
    -- Szybkie ESP Ról
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
    
    -- ESP Coinów
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
    
    -- ESP Trapów
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

    -- ESP Dropped Gun
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
            if v:FindFirstChild("GunHigh
