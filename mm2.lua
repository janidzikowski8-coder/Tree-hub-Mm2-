-- Jasiu Hub V1 | Murder Mystery 2 (Stabilna Wersja Mobilna)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Usuń stare menu jeśli już działa
if CoreGui:FindFirstChild("JasiuHubV1") then
    CoreGui.JasiuHubV1:Destroy()
end

-- Zmienne globalne funkcji
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeedVal = 50
_G.KillAuraOn = false
_G.KillAuraRangeVal = 10
_G.EspRolesOn = false

-- Tworzenie głównego okna
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JasiuHubV1"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Pasek tytułowy
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 140, 70)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Text = "Jasiu Hub V1 🌲 | MM2"
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "X"
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Kontener główny (Scrolling)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -55)
Scroll.Position = UDim2.new(0, 10, 0, 48)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 750)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = Scroll

-- Funkcja do nagłówków kategorii
local function addHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(0, 200, 100)
    lbl.TextSize = 15
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text
    lbl.Parent = Scroll
end

-- Funkcja do zwykłych przycisków stanu (zmień kolor: zielony/czerwony)
local function addToggle(name, getState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Czerwony domyślnie (wył)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name .. ": WYŁĄCZONY"
    btn.Parent = Scroll
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        local newState = callback()
        if newState then
            btn.BackgroundColor3 = Color3.fromRGB(40, 180, 80) -- Zielony (wł)
            btn.Text = name .. ": WŁĄCZONY"
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Czerwony (wył)
            btn.Text = name .. ": WYŁĄCZONY"
        end
    end)
    return btn
end

-- Funkcja do suwaków wartości (Slider tekstowy dla uproszczenia mobilnego)
local function addActionBox(name, onClick)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name
    btn.Parent = Scroll
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(onClick)
end

-------------------------------------------------
-- 1. SEKCJA: MURDER
-------------------------------------------------
addHeader("--- [ MURDER ] ---")

addToggle("Kill Aura (1-100)", function()
    _G.KillAuraOn = not _G.KillAuraOn
    return _G.KillAuraOn
end)

addActionBox("Zmień Zasięg Kill Aury (Aktualnie: " .. _G.KillAuraRangeVal .. ")", function()
    _G.KillAuraRangeVal = _G.KillAuraRangeVal + 10
    if _G.KillAuraRangeVal > 100 then _G.KillAuraRangeVal = 10 end
    print("Zasięg Kill Aury:", _G.KillAuraRangeVal)
end)

-------------------------------------------------
-- 2. SEKCJA: SHERIFF
-------------------------------------------------
addHeader("--- [ SHERIFF ] ---")

addActionBox("Auto Teleport do upuszczonej broni (Gun Drop)", function()
    local found = false
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                found = true
            end
        end
    end
end)

addToggle("ESP Ról (Czerwony=Murder, Niebieski=Sheriff, Zielony=Innocent)", function()
    _G.EspRolesOn = not _G.EspRolesOn
    return _G.EspRolesOn
end)

-------------------------------------------------
-- 3. SEKCJA: PLAYER (Speed, Jump, Noclip, Fly)
-------------------------------------------------
addHeader("--- [ PLAYER ] ---")

addActionBox("Prędkość (WalkSpeed): " .. _G.SpeedVal .. " (Kliknij aby zmienić)", function()
    if _G.SpeedVal == 16 then _G.SpeedVal = 50
    elseif _G.SpeedVal == 50 then _G.SpeedVal = 150
    elseif _G.SpeedVal == 150 then _G.SpeedVal = 300
    elseif _G.SpeedVal == 300 then _G.SpeedVal = 500
    elseif _G.SpeedVal == 500 then _G.SpeedVal = 1000
    else _G.SpeedVal = 16 end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedVal
    end
end)

addActionBox("Siła Skoku (JumpPower): " .. _G.JumpVal .. " (Kliknij aby zmienić)", function()
    if _G.JumpVal == 50 then _G.JumpVal = 150
    elseif _G.JumpVal == 150 then _G.JumpVal = 300
    elseif _G.JumpVal == 300 then _G.JumpVal = 600
    elseif _G.JumpVal == 600 then _G.JumpVal = 1000
    else _G.JumpVal = 50 end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = _G.JumpVal
    end
end)

addToggle("Noclip (Przenikanie przez ściany)", function()
    _G.NoclipOn = not _G.NoclipOn
    return _G.NoclipOn
end)

addToggle("Infinite Jump (Nieskończony skok)", function()
    _G.InfJumpOn = not _G.InfJumpOn
    return _G.InfJumpOn
end)

addToggle("Fly (Latanie)", function()
    _G.FlyOn = not _G.FlyOn
    return _G.FlyOn
end)

-------------------------------------------------
-- OBSŁUGA MECHANIK W TLE
-------------------------------------------------

-- Noclip & KillAura pętla
RunService.Stepped:Connect(function()
    if _G.NoclipOn and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    
    -- Kill Aura logik
    if _G.KillAuraOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LocalPlayer.Character.HumanoidRootPart
        local knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
        if knife then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = p.Character.HumanoidRootPart
                    if (myRoot.Position - targetRoot.Position).Magnitude <= _G.KillAuraRangeVal then
                        knife.Parent = LocalPlayer.Character
                        pcall(function() knife:Activate() end)
                    end
                end
            end
        end
    end
    
    -- ESP Ról Kolorowanie
    if _G.EspRolesOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local col = Color3.fromRGB(0, 255, 0) -- Zielony (Niewinny)
                
                local bp = p:FindFirstChild("Backpack")
                local hasKnife = (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife")
                local hasGun = (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Gun")
                
                if hasKnife then
                    col = Color3.fromRGB(255, 0, 0) -- Czerwony (Murder)
                elseif hasGun then
                    col = Color3.fromRGB(0, 120, 255) -- Niebieski (Sheriff)
                end
                
                local hl = char:FindFirstChild("JasiuESP")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "JasiuESP"
                    hl.Parent = char
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
                hl.FillColor = col
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("JasiuESP") then
                p.Character.JasiuESP:Destroy()
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if _G.InfJumpOn then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Fly system pro
local camera = Workspace.CurrentCamera
RunService.RenderStepped:Connect(function()
    if _G.FlyOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.PlatformStand = true
        local moveDirection = humanoid.MoveDirection
        local velocity = Vector3.new(0, 0, 0)
        if moveDirection.Magnitude > 0 then
            velocity = camera.CFrame.LookVector * (moveDirection.Z * 50) + camera.CFrame.RightVector * (moveDirection.X * 50)
        end
        rootPart.Velocity = velocity
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end)
