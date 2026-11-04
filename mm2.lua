-- Jasiu Hub V4 (Fluent UI Edition) | Murder Mystery 2 dla Arceus X
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Jasiu Hub V4 🌲 | MM2 Ultimate Fluent",
    SubTitle = "Dedykowane dla Arceus X",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Wyłączone akrylowe rozmycie dla maksymalnej wydajności na telefonie
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Zakładki
local Tabs = {
    Murder = Window:AddTab({ Title = "Murder", Icon = "sword" }),
    Sheriff = Window:AddTab({ Title = "Sheriff", Icon = "crosshair" }),
    Farm = Window:AddTab({ Title = "Auto Farm", Icon = "coins" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Esp = Window:AddTab({ Title = "ESP & Alerts", Icon = "eye" }),
    Utility = Window:AddTab({ Title = "Utility", Icon = "wrench" }),
    Troll = Window:AddTab({ Title = "Troll", Icon = "ghost" })
}

local Options = Fluent.Options

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
Tabs.Murder:AddToggle("KillAuraToggle", {
    Title = "⚡ Ultra Kill Aura Pro",
    Default = false,
    Callback = function(Value)
        _G.KillAuraOn = Value
    end
})

Tabs.Murder:AddSlider("KARangeSlider", {
    Title = "Zasięg Kill Aury",
    Description = "Wybierz promień działania",
    Default = 15,
    Min = 10,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        _G.KillAuraRange = Value
    end
})

Tabs.Murder:AddButton({
    Title = "🔥 KILL ALL",
    Description = "Zabij wszystkich graczy na mapie",
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
    end
})

-------------------------------------------------
-- ZAKŁADKA: SHERIFF
-------------------------------------------------
Tabs.Sheriff:AddToggle("AutoShootToggle", {
    Title = "🎯 Auto-Shoot / Silent Aim",
    Default = false,
    Callback = function(Value)
        _G.AutoShootSheriff = Value
    end
})

Tabs.Sheriff:AddButton({
    Title = "Teleport do upuszczonej broni",
    Description = "Złap pistolet, gdy szeryf zginie",
    Callback = function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
    end
})

-------------------------------------------------
-- ZAKŁADKA: AUTO FARM
-------------------------------------------------
Tabs.Farm:AddToggle("AutoFarmToggle", {
    Title = "🪙 Auto-Farm Monet (Teleport)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmCoins = Value
    end
})

Tabs.Farm:AddToggle("CoinAuraToggle", {
    Title = "🧲 Coin Aura (Magnes 25 studów)",
    Default = false,
    Callback = function(Value)
        _G.CoinAuraOn = Value
    end
})

-------------------------------------------------
-- ZAKŁADKA: PLAYER
-------------------------------------------------
Tabs.Player:AddSlider("SpeedSlider", {
    Title = "Prędkość (WalkSpeed)",
    Default = 16,
    Min = 16,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        _G.SpeedVal = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.Player:AddSlider("JumpSlider", {
    Title = "Siła Skoku (JumpPower)",
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        _G.JumpVal = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

Tabs.Player:AddSlider("FovSlider", {
    Title = "FOV (Pole widzenia)",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        _G.FovVal = Value
        Camera.FieldOfView = Value
    end
})

Tabs.Player:AddButton({
    Title = "🛡️ Safe Zone",
    Description = "Teleportuj się 50 studów w górę",
    Callback = function()
        pcall(function()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0, 50, 0)
            end
        end)
    end
})

Tabs.Player:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Default = false,
    Callback = function(Value)
        _G.NoclipOn = Value
    end
})

Tabs.Player:AddToggle("InfJumpToggle", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        _G.InfJumpOn = Value
    end
})

Tabs.Player:AddToggle("FlyToggle", {
    Title = "Fly (Latanie)",
    Default = false,
    Callback = function(Value)
        _G.FlyOn = Value
    end
})

-------------------------------------------------
-- ZAKŁADKA: ESP & ALERTS
-------------------------------------------------
Tabs.Esp:AddToggle("RoleAlertToggle", {
    Title = "🔔 Role Alerts",
    Default = true,
    Callback = function(Value)
        _G.RoleAlertOn = Value
    end
})

Tabs.Esp:AddToggle("EspRolesToggle", {
    Title = "ESP Ról (Kolory postaci)",
    Default = false,
    Callback = function(Value)
        _G.EspRolesOn = Value
    end
})

Tabs.Esp:AddToggle("EspNamesToggle", {
    Title = "ESP Nazw i Ról nad głowami",
    Default = false,
    Callback = function(Value)
        _G.EspNamesOn = Value
    end
})

Tabs.Esp:AddToggle("EspCoinsToggle", {
    Title = "ESP Coinów",
    Default = false,
    Callback = function(Value)
        _G.EspCoinsOn = Value
    end
})

Tabs.Esp:AddToggle("EspTrapsToggle", {
    Title = "ESP Trapów",
    Default = false,
    Callback = function(Value)
        _G.EspTrapsOn = Value
    end
})

Tabs.Esp:AddToggle("EspGunDropToggle", {
    Title = "ESP Dropped Gun",
    Default = false,
    Callback = function(Value)
        _G.EspGunDropOn = Value
    end
})

-------------------------------------------------
-- ZAKŁADKA: UTILITY
-------------------------------------------------
local crosshairGui = nil
Tabs.Utility:AddToggle("CrosshairToggle", {
    Title = "🎯 Customowy Celownik",
    Default = false,
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
    end
})

Tabs.Utility:AddToggle("AntiAfkToggle", {
    Title = "🛡️ Anti-AFK",
    Default = true,
    Callback = function(Value)
        _G.AntiAfkOn = Value
    end
})

Tabs.Utility:AddButton({
    Title = "🔄 Server Hop",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

Tabs.Utility:AddButton({
    Title = "🔁 Rejoin",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-------------------------------------------------
-- ZAKŁADKA: TROLL
-------------------------------------------------
Tabs.Troll:AddButton({
    Title = "🌀 Skok-Zmyłka (Teleport 15 studów w górę)",
    Callback = function()
        pcall(function()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0, 15, 0)
            end
        end)
    end
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
            velocity = Camera.CFrame.LookVector * (moveDirection.Z * _G.FlySpeed) + Camera.CFeed.RightVector * (moveDirection.X * _G.FlySpeed)
        end
        rootPart.Velocity = velocity
    elsei
