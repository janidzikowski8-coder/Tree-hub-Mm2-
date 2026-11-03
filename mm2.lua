-- Jasiu Hub V2.2 | Murder Mystery 2 (Ultra Mobile Compatibility Fix)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Wybór bezpiecznego kontenera na GUI
local ParentGui
pcall(function()
    ParentGui = LocalPlayer:WaitForChild("PlayerGui", 5)
end)
if not ParentGui then
    pcall(function()
        ParentGui = game:GetService("CoreGui")
    end)
end

-- Usunięcie starej wersji GUI, jeśli istnieje
if ParentGui then
    local oldGui = ParentGui:FindFirstChild("JasiuHubV1")
    if oldGui then
        oldGui:Destroy()
    end
end

-- Zmienne globalne
_G.SpeedVal = 16
_G.JumpVal = 50
_G.NoclipOn = false
_G.InfJumpOn = false
_G.FlyOn = false
_G.FlySpeedVal = 50
_G.KillAuraOn = false
_G.KillAuraRangeVal = 10
_G.EspRolesOn = false
_G.EspCoinsOn = false
_G.EspTrapsOn = false
_G.EspNamesOn = false
_G.InvisibilityOn = false
_G.FakeAdminOn = false
_G.Fake3FXOn = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JasiuHubV1"
ScreenGui.ResetOnSpawn = false

pcall(function()
    ScreenGui.Parent = ParentGui
end)

-- Główne okno (Powiększone: 400x450)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 450)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 200, 90)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Pasek tytułowy
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 8)
TitleCover.Position = UDim2.new(0, 0, 1, -8)
TitleCover.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
TitleCover.BorderSizePixel = 0
TitleCover.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -70, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 15
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Text = "Jasiu Hub V2 🌲 | Admin Panel Pro"
TitleText.Parent = TitleBar

-- Przycisk zwijania (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -64, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 60)
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Text = "-"
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Parent = TitleBar
local minC = Instance.new("UICorner") minC.CornerRadius = UDim.new(0, 6) minC.Parent = MinimizeBtn

-- Przycisk zamknięcia (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "X"
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TitleBar
local closeC = Instance.new("UICorner") closeC.CornerRadius = UDim.new(0, 6) closeC.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Mała ikona otwierania
local OpenIcon = Instance.new("TextButton")
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 20, 0.2, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
OpenIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenIcon.Text = "🌲 J"
OpenIcon.TextSize = 14
OpenIcon.Font = Enum.Font.SourceSansBold
OpenIcon.Visible = false
OpenIcon.Active = true
OpenIcon.Draggable = true
OpenIcon.Parent = ScreenGui
local openC = Instance.new("UICorner") openC.CornerRadius = UDim.new(0, 10) openC.Parent = OpenIcon
local openS = Instance.new("UIStroke") openS.Color = Color3.fromRGB(255, 255, 255) openS.Thickness = 1.5 openS.Parent = OpenIcon

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenIcon.Visible = true
end)

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenIcon.Visible = false
end)

-- Pasek zakładek
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -16, 0, 32)
TabBar.Position = UDim2.new(0, 8, 0, 48)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 6)
TabList.Parent = TabBar

local Containers = {}
local function createContainer(name)
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1, -16, 1, -95)
    sc.Position = UDim2.new(0, 8, 0, 88)
    sc.BackgroundTransparency = 1
    sc.CanvasSize = UDim2.new(0, 0, 0, 520)
    sc.ScrollBarThickness = 3
    sc.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 90)
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
    btn.Size = UDim2.new(0, 72, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(28, 36, 30)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = TabBar
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(40, 70, 50) stroke.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, cont in pairs(Containers) do cont.Visible = false end
        for _, child in pairs(TabBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(28, 36, 30)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        targetContainer.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

local cMurder = createContainer("Murder")
local cSheriff = createContainer("Sheriff")
local cPlayer = createContainer("Player")
local cEsp = createContainer("ESP")
local cAdmin = createContainer("Admin")

createTabButton("Murder", cMurder)
createTabButton("Sheriff", cSheriff)
createTabButton("Player", cPlayer)
createTabButton("ESP", cEsp)
createTabButton("Admin", cAdmin)

cMurder.Visible = true
for _, child in pairs(TabBar:GetChildren()) do
    if child:IsA("TextButton") and child.Text == "Murder" then
        child.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
        child.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- Uniwersalny Toggle
local function addToggle(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name .. ": WYŁĄCZONY"
    btn.Parent = parent
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
            btn.Text = name .. ": WŁĄCZONY"
        else
            btn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
            btn.Text = name .. ": WYŁĄCZONY"
        end
    end)
end

-- Suwak wartości
local function addSlider(parent, name, min, max, current, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 54)
    frame.BackgroundColor3 = Color3.fromRGB(25, 32, 27)
    frame.Parent = parent
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.TextSize = 13
    label.Font = Enum.Font.SourceSansSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = name .. ": " .. current
    label.Parent = frame
    
    local sliderBg = Instance.new("TextButton")
    sliderBg.Size = UDim2.new(1, -16, 0, 14)
    sliderBg.Position = UDim2.new(0, 8, 0, 32)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 50, 43)
    sliderBg.Text = ""
    sliderBg.Parent = frame
    
    local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 4) sc.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((current - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sfc = Instance.new("UICorner") sfc.CornerRadius = UDim.new(0, 4) sfc.Parent = sliderFill
    
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
-- ZAKŁADKA: MURDER
-------------------------------------------------
addToggle(cMurder, "Kill Aura", function(v) _G.KillAuraOn = v end)
addSlider(cMurder, "Zasięg Kill Aury", 10, 100, 10, function(v) _G.KillAuraRangeVal = v end)

local btnKillAll = Instance.new("TextButton")
btnKillAll.Size = UDim2.new(1, 0, 0, 40)
btnKillAll.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
btnKillAll.TextColor3 = Color3.fromRGB(255, 255, 255)
btnKillAll.TextSize = 13
btnKillAll.Font = Enum.Font.SourceSansBold
btnKillAll.Text = "🔥 KILL ALL (Zabij wszystkich)"
btnKillAll.Parent = cMurder
local kac = Instance.new("UICorner") kac.CornerRadius = UDim.new(0, 6) kac.Parent = btnKillAll

btnKillAll.MouseButton1Click:Connect(function()
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
end)

-------------------------------------------------
-- ZAKŁADKA: SHERIFF
-------------------------------------------------
local btnGun = Instance.new("TextButton")
btnGun.Size = UDim2.new(1, 0, 0, 40)
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
-- ZAKŁADKA: PLAYER
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
-- ZAKŁADKA: ESP
-------------------------------------------------
addToggle(cEsp, "ESP Ról (Kolory postaci)", function(v) _G.EspRolesOn = v end)
addToggle(cEsp, "ESP Nazw i Ról nad głowami", function(v) _G.EspNamesOn = v end)
addToggle(cEsp, "ESP Coinów (Monety)", function(v) _G.EspCoinsOn = v end)
addToggle(cEsp, "ESP Trapów (Pułapki)", function(v) _G.EspTrapsOn = v end)

-------------------------------------------------
-- ZAKŁADKA: ADMIN PANEL
-------------------------------------------------
addToggle(cAdmin, "Niewidzialność (Invisibility)", function(v)
    _G.InvisibilityOn = v
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = v and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = v and 1 or 0
            end
        end
    end
end)

addToggle(cAdmin, "Fake Weryfikacja Admina", function(v)
    _G.FakeAdminOn = v
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local tag = char.Head:FindFirstChild("AdminTagGUI")
        if v and not tag then
            local bg = Instance.new("BillboardGui")
            bg.Name = "AdminTagGUI"
            bg.Size = UDim2.new(0, 150, 0, 50)
            bg.StudsOffset = Vector3.new(0, 3.5, 0)
            bg.AlwaysOnTop = true
            bg.Parent = char.Head
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = "⭐ [ROBLOX ADMIN] ⭐"
            txt.TextColor3 = Color3.fromRGB(255, 215, 0)
            txt.TextSize = 14
            txt.Font = Enum.Font.SourceSansBold
            txt.Parent = bg
        elseif not v and tag then
            tag:Destroy()
        end
    end
end)

addToggle(cAdmin, "Fake 3FX (Efekty Specjalne)", function(v)
    _G.Fake3FXOn = v
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local fx = char.HumanoidRootPart:FindFirstChild("Fake3FXParticles")
        if v and not fx me
            local att = Instance.new("Attachment")
            att.Name = "Fake3FXParticles"
            att.Parent = char.HumanoidRootPart
            
            local pe = Instance.new("ParticleEmitter")
            pe.Color = ColorSequence.new(Color3.fromRGB(0, 255, 120))
            pe.Size = NumberSequence.new(0.5, 0)
            pe.Texture = "rbxassetid://258129463"
            pe.Rate = 30
            pe.Speed = NumberRange.new(5, 10)
            pe.Parent = att
        elseif not v and fx then
            fx:Destroy()
        end
    end
end)

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
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local col = Color3.fromRGB(0, 255, 0)
            local roleStr = "Innocent"
            
            local bp = p:FindFirstChild("Backpack")
            if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                col = Color3.fromRGB(255, 0, 0)
                roleStr = "Murderer"
            elseif (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Gun") then
                col = Color3.fromRGB(0, 120, 255)
                roleStr = "Sheriff"
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
                        txt.Backgrou
