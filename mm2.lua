-- Jasiu Hub V2 | Murder Mystery 2 (Rayfield + ESP Dropped Gun + Prawdziwe Freeze & Animacje + Ultra Invisible)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Jasiu Hub V2 🌲 | MM2 Pro",
   LoadingTitle = "Ładowanie Jasiu Hub V2...",
   LoadingSubtitle = "Stworzone dla Arceus X",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "JasiuHub",
      FileName = "MM2Config"
   },
   KeySystem = false,
})

-- Zakładki
local TabMurder = Window:CreateTab("Murder", 4483362458)
local TabSheriff = Window:CreateTab("Sheriff", 4483362458)
local TabPlayer = Window:CreateTab("Player", 4483362458)
local TabEsp = Window:CreateTab("ESP", 4483362458)
local TabTroll = Window:CreateTab("Troll", 4483362458)

-- Serwisy i zmienne lokalne
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
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
_G.FreezeAllOn = false
_G.EspRolesOn = false
_G.EspCoinsOn = false
_G.EspTrapsOn = false
_G.EspNamesOn = false
_G.EspGunDropOn = false

-------------------------------------------------
-- ZAKŁADKA: MURDER
-------------------------------------------------
TabMurder:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
      _G.KillAuraOn = Value
   end,
})

TabMurder:CreateSlider({
   Name = "Zasięg Kill Aury",
   Range = {10, 100},
   Increment = 5,
   Suffix = " studów",
   CurrentValue = 10,
   Flag = "KARange",
   Callback = function(Value)
      _G.KillAuraRange = Value
   end,
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
   Callback = function(Value)
      _G.NoclipOn = Value
   end,
})

TabPlayer:CreateToggle({
   Name = "Infinite Jump (Nieskończony skok)",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      _G.InfJumpOn = Value
   end,
})

TabPlayer:CreateToggle({
   Name = "Fly (Latanie)",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(Value)
      _G.FlyOn = Value
   end,
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
   Callback = function(Value)
      _G.EspRolesOn = Value
   end,
})

TabEsp:CreateToggle({
   Name = "ESP Nazw i Ról nad głowami",
   CurrentValue = false,
   Flag = "EspNames",
   Callback = function(Value)
      _G.EspNamesOn = Value
   end,
})

TabEsp:CreateToggle({
   Name = "ESP Coinów (Monety)",
   CurrentValue = false,
   Flag = "EspCoins",
   Callback = function(Value)
      _G.EspCoinsOn = Value
   end,
})

TabEsp:CreateToggle({
   Name = "ESP Trapów (Pułapki)",
   CurrentValue = false,
   Flag = "EspTraps",
   Callback = function(Value)
      _G.EspTrapsOn = Value
   end,
})

TabEsp:CreateToggle({
   Name = "ESP Dropped Gun (Widoczność leżącej broni)",
   CurrentValue = false,
   Flag = "EspGunDrop",
   Callback = function(Value)
      _G.EspGunDropOn = Value
   end,
})

-------------------------------------------------
-- ZAKŁADKA: TROLL (Freeze All + Animacje)
-------------------------------------------------
TabTroll:CreateToggle({
   Name = "Freeze All (Zamroź wszystkich na serwerze)",
   CurrentValue = false,
   Flag = "FreezeAll",
   Callback = function(Value)
      _G.FreezeAllOn = Value
      if not Value then
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character then
                  local hum = p.Character:FindFirstChildOfClass("Humanoid")
                  local root = p.Character:FindFirstChild("HumanoidRootPart")
                  if hum then hum.WalkSpeed = 16 end
                  if root then root.Anchored = false end
              end
          end
      end
   end,
})

TabTroll:CreateButton({
   Name = "🎬 Animacja Zabicia (Troll)",
   Callback = function()
      pcall(function()
          local char = LocalPlayer.Character
          if char and char:FindFirstChildOfClass("Humanoid") then
              local anim = Instance.new("Animation")
              anim.AnimationId = "rbxassetid://184570534" -- Animacja ciosu/ataku
              local track = char.Humanoid:LoadAnimation(anim)
              track:Play()
          end
      end)
   end,
})

TabTroll:CreateButton({
   Name = "🛌 Animacja Leżenia (Troll)",
   Callback = function()
      pcall(function()
          local char = LocalPlayer.Character
          if char and char:FindFirstChildOfClass("Humanoid") then
              local anim = Instance.new("Animation")
              anim.AnimationId = "rbxassetid://282574440" -- Animacja upadku/leżenia
              local track = char.Humanoid:LoadAnimation(anim)
              track:Play()
          end
      end)
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
    
    if _G.FreezeAllOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if hum then hum.WalkSpeed = 0 end
                if root then root.Anchored = true end
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

    -- ESP Dropped Gun (Leżąca broń)
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

local camera = Workspace.CurrentCamera
RunService.RenderStepped:Connect(function()
    if _G.FlyOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.PlatformStand = true
        local moveDirection = humanoid.MoveDirection
        local velocity = Vector3.new(0, 0, 0)
        if moveDirection.Magnitude > 0 then
            velocity = camera.CFrame.LookVector * (moveDirection.Z * _G.FlySpeed) + camera.CFrame.RightVector * (moveDirection.X * _G.FlySpeed)
        end
        rootPart.Velocity = velocity
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end)
