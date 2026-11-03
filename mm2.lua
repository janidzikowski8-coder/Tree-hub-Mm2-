-- Jasiu Hub V1 | Murder Mystery 2 (Zaawansowane Menu Mobilne)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("JasiuHubV1") then
    CoreGui.JasiuHubV1:Destroy()
end

-- Zmienne
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeedVal = 50
_G.KillAuraOn = false
_G.KillAuraRangeVal = 10
_G.EspRolesOn = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JasiuHubV1"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 420)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
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
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 140, 70)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 15
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Text = "Jasiu Hub V1 🌲 | MM2 Pro"
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "X"
CloseBtn.TextSize = 13
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Pasek zakładek u góry (Murder, Sheriff, Player, ESP)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -10, 0, 32)
TabBar.Position = UDim2.new(0, 5, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabBar

-- Kontenery na zawartość zakładek
local Containers = {}
local function createContainer(name)
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1, -16, 1, -85)
    sc.Position = UDim2.new(0, 8, 0, 78)
    sc.BackgroundTransparency = 1
    sc.CanvasSize = UDim2.new(0, 0, 0, 450)
    sc.ScrollBarThickness = 4
    sc.Visible = false
    sc.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = sc
    
    Containers[name] = sc
    return sc
end

local function createTabButton(name, targetContainer)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 78, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = TabBar
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, cont in pairs(Containers) do cont.Visible = false end
        targetContainer.Visible = true
    end)
end

-- Tworzenie zakładek
local cMurder = createContainer("Murder")
local cSheriff = createContainer("Sheriff")
local cPlayer = createContainer("Player")
local cEsp = createContainer("ESP")

createTabButton("Murder", cMurder)
createTabButton("Sheriff", cSheriff)
createTabButton("Player", cPlayer)
createTabButton("ESP", cEsp)

cMurder.Visible = true -- Domyślna zakładka

-- Funkcja do przełączników (zielony = wł, czerwony = wył)
local function addToggle(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Czerwony (domyślnie wył)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name .. ": WYŁĄCZONY"
    btn.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(40, 180, 80) -- Zielony
            btn.Text = name .. ": WŁĄCZONY"
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Czerwony
            btn.Text = name .. ": WYŁĄCZONY"
        end
    end)
end

-- Funkcja do suwaków (suwaki z przesuwanym paskiem)
local function addSlider(parent, name, min, max, current, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.Parent = parent
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 25)
    label.Position = UDim2.new(0, 5, 0, 2)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.SourceSansSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = name .. ": " .. current
    label.Parent = frame
    
    local sliderBg = Instance.new("TextButton")
    sliderBg.Size = UDim2.new(1, -20, 0, 15)
    sliderBg.Position = UDim2.new(0, 10, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBg.Text = ""
    sliderBg.Parent = frame
    
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 4)
    sc.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((current - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 160, 80)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sfc = Instance.new("UICorner")
    sfc.CornerRadius = UDim.new(0, 4)
    sfc.Parent = sliderFill
    
    local dragging = false
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            label.Text = name .. ": " .. val
            callback(val)
        end
    end)
end

-------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADWORKA: MURDER
-------------------------------------------------
addToggle(cMurder, "Kill Aura", function(v) _G.KillAuraOn = v end)
addSlider(cMurder, "Zasięg Kill Aury", 10, 100, 10, function(v) _G.KillAuraRangeVal = v end)

-------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADKI: SHERIFF
-------------------------------------------------
local btnGun = Instance.new("TextButton")
btnGun.Size = UDim2.new(1, 0, 0, 38)
btnGun.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
btnGun.TextColor3 = Color3.fromRGB(255, 255, 255)
btnGun.TextSize = 13
btnGun.Font = Enum.Font.SourceSansBold
btnGun.Text = "Auto Teleport do upuszczonej broni"
btnGun.Parent = cSheriff
local gc = Instance.new("UICorner") gc.CornerRadius = UDim.new(0, 6) gc.Parent = btnGun
btnGun.MouseButton1Click:Connect(function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name == "GunDrop" or (v:IsA("Tool") and v.Name ~= "Knife" and v.Name ~= "Gun") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
end)

-------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADKI: PLAYER
-------------------------------------------------
addSlider(cPlayer, "Prędkość (WalkSpeed)", 1, 1000, 16, function(v)
    _G.SpeedVal = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

addSlider(cPlayer, "Siła Skoku (JumpPower)", 1, 1000, 50, function(v)
    _G.JumpVal = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)

addSlider(cPlayer, "Prędkość Fly", 1, 1000, 50, function(v) _G.FlySpeedVal = v end)

addToggle(cPlayer, "Noclip", function(v) _G.NoclipOn = v end)
addToggle(cPlayer, "Infinite Jump", function(v) _G.InfJumpOn = v end)
addToggle(cPlayer, "Fly (Latanie)", function(v) _G.FlyOn = v end)

-------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADKI: ESP
-------------------------------------------------
addToggle(cEsp, "ESP Ról (Murder/Sheriff/Innocent)", function(v) _G.EspRolesOn = v end)

-------------------------------------------------
-- PĘTLE W TLE
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
                    if (myRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude <= _G.KillAuraRangeVal then
                        knife.Parent = LocalPlayer.Character
                        pcall(function() knife:Activate() end)
                    end
                end
            end
        end
    end
    
    if _G.EspRolesOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local col = Color3.fromRGB(0, 255, 0) -- Zielony (Innocent)
                local bp = p:FindFirstChild("Backpack")
                if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                    col = Color3.fromRGB(255, 0, 0) -- Czerwony (Murder)
                elseif (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Gun") then
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
            if p.Character and p.Character:FindFirstChild("JasiuESP") then p.Character.JasiuESP:Destroy() end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
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
            velocity = camera.CFrame.LookVector * (moveDirection.Z * _G.FlySpeedVal) + camera.CFrame.RightVector * (moveDirection.X * _G.FlySpeedVal)
        end
        rootPart.Velocity = velocity
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end)
