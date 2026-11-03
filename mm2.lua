-- Tree Hub 🌲 | MM2 Pro (Wersja Mobilna - Stabilna GUI)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Usuń stare menu jeśli już działa
if CoreGui:FindFirstChild("TreeHubPro") then
    CoreGui.TreeHubPro:Destroy()
end

-- Zmienne funkcji
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.EspOn = false

-- Tworzenie głównego okna
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TreeHubPro"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Pasek tytułowy
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 160, 80)
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
TitleText.Text = "Tree Hub 🌲 | MM2 Pro"
TitleText.Parent = TitleBar

-- Przycisk zamknięcia (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "X"
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Kontener na opcje (ScrollingFrame)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 450)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = Scroll

-- Funkcja pomocnicza do tworzenia przycisków/przełączników
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name
    btn.Parent = Scroll
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. Przycisk Speed (Szybkość 100)
createButton("Przełącz Szybkość (100 / 16)", function()
    if _G.SpeedVal == 16 then
        _G.SpeedVal = 100
    else
        _G.SpeedVal = 16
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedVal
    end
end)

-- 2. Przycisk Siła Skoku
createButton("Przełącz Skok (150 / 50)", function()
    if _G.JumpVal == 50 then
        _G.JumpVal = 150
    else
        _G.JumpVal = 50
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = _G.JumpVal
    end
end)

-- 3. Przycisk Noclip (Przenikanie przez ściany)
createButton("Noclip: WYŁĄCZONY / WŁĄCZONY", function()
    _G.NoclipOn = not _G.NoclipOn
    print("Noclip: " .. tostring(_G.NoclipOn))
end)

-- 4. Przycisk ESP Ról MM2 (Zielony/Niebieski/Czerwony)
createButton("ESP Ról (Green/Blue/Red): WYŁ", function()
    _G.EspOn = not _G.EspOn
end)

-- 5. Teleport do Upuszczonej Broni (Gun Drop)
createButton("Teleport do upuszczonej broni (Gun)", function()
    local found = false
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                found = true
            end
        end
    end
end)

-- Pętle działające w tle (Noclip, ESP, WalkSpeed)
RunService.Stepped:Connect(function()
    if _G.NoclipOn and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    
    -- ESP Ról
    if _G.EspOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local col = Color3.fromRGB(0, 255, 0) -- Domyślnie zielony (Niewinny)
                
                local backpack = p:FindFirstChild("Backpack")
                local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or char:FindFirstChild("Knife")
                local hasGun = (backpack and backpack:FindFirstChild("Gun")) or char:FindFirstChild("Gun")
                
                if hasKnife then
                    col = Color3.fromRGB(255, 0, 0) -- Czerwony = Murder
                elseif hasGun then
                    col = Color3.fromRGB(0, 120, 255) -- Niebieski = Sheriff
                end
                
                local hl = char:FindFirstChild("TreeESP")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "TreeESP"
                    hl.Parent = char
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
                hl.FillColor = col
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("TreeESP") then
                p.Character.TreeESP:Destroy()
            end
        end
    end
end)
