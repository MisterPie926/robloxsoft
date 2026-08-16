-- MistePieMenu v10 (Global Update)
local parent = (gethui and gethui()) or game:GetService('CoreGui') or game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')

if getgenv().MistePieFOV then
    pcall(function() getgenv().MistePieFOV:Remove() end)
end

if parent:FindFirstChild("MistePieMenu") then
    parent.MistePieMenu:Destroy()
end

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local plr = Players.LocalPlayer

local MistePieMenu = Instance.new("ScreenGui")
MistePieMenu.Name = "MistePieMenu"
MistePieMenu.ResetOnSpawn = true
MistePieMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MistePieMenu.DisplayOrder = 999
MistePieMenu.Parent = parent

-- Очистка FOV при уничтожении
MistePieMenu.Destroying:Connect(function()
    if getgenv().MistePieFOV then
        pcall(function() getgenv().MistePieFOV:Remove() end)
    end
end)

-- Новый стиль: тёмный с синими акцентами
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Position = UDim2.new(0.5, -300, 0.5, -250)
Container.Size = UDim2.new(0, 600, 0, 500)
Container.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
Container.BackgroundTransparency = 0.1
Container.BorderSizePixel = 0
Container.Visible = false
Container.ClipsDescendants = true
Container.ZIndex = 999
Container.Parent = MistePieMenu

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 12)
ContainerCorner.Parent = Container

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Color = Color3.fromRGB(60, 120, 255)
ContainerStroke.Thickness = 1.5
ContainerStroke.Transparency = 0.3
ContainerStroke.Parent = Container

-- Передвижение окна
local dragging = false
local dragStart = Vector2.new(0, 0)
local dragOffset = Vector2.new(0, 0)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 18, 30)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 999
TitleBar.Parent = Container

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "✦ MISTE v10 ✦"
TitleText.TextColor3 = Color3.fromRGB(100, 160, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 999
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Перетаскивание
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        dragOffset = Container.AbsolutePosition
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local newPos = dragOffset + (input.Position - dragStart)
        Container.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Вкладки (новый стиль)
local TabFrame = Instance.new("Frame")
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.Size = UDim2.new(0, 120, 1, -40)
TabFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
TabFrame.BorderSizePixel = 0
TabFrame.ZIndex = 999
TabFrame.Parent = Container

local function createTab(name, text, yPos)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Position = UDim2.new(0, 5, 0, yPos)
    tab.Size = UDim2.new(1, -10, 0, 35)
    tab.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
    tab.BorderSizePixel = 0
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(150, 180, 255)
    tab.TextSize = 13
    tab.Font = Enum.Font.Gotham
    tab.ZIndex = 999
    tab.Parent = TabFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tab

    return tab
end

local AimbotTab = createTab("AimbotTab", "🎯 Aimbot", 10)
local VisualTab = createTab("VisualTab", "👁 Visual", 50)
local MiscTab = createTab("MiscTab", "⚡ Misc", 90)
local BulletTab = createTab("BulletTab", "🔫 Bullet", 130)

local ContentFrame = Instance.new("Frame")
ContentFrame.Position = UDim2.new(0, 120, 0, 40)
ContentFrame.Size = UDim2.new(1, -120, 1, -40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
ContentFrame.BackgroundTransparency = 0.05
ContentFrame.BorderSizePixel = 0
ContentFrame.ZIndex = 999
ContentFrame.Parent = Container

-- Функции создания элементов
local function createToggle(name, text, pos, parentObj)
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Position = pos
    toggle.Size = UDim2.new(0, 180, 0, 35)
    toggle.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    toggle.BorderSizePixel = 0
    toggle.Text = text .. ": OFF"
    toggle.TextColor3 = Color3.fromRGB(200, 200, 255)
    toggle.TextSize = 12
    toggle.Font = Enum.Font.Gotham
    toggle.ZIndex = 999
    toggle.Parent = parentObj

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle

    return toggle
end

local function createSlider(name, text, pos, minVal, maxVal, defaultVal, parentObj)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Position = pos
    sliderFrame.Size = UDim2.new(0, 220, 0, 45)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.ZIndex = 999
    sliderFrame.Parent = parentObj

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 18)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text .. ": " .. defaultVal
    sliderLabel.TextColor3 = Color3.fromRGB(150, 180, 255)
    sliderLabel.TextSize = 11
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.ZIndex = 999
    sliderLabel.Parent = sliderFrame

    local sliderBg = Instance.new("Frame")
    sliderBg.Position = UDim2.new(0, 0, 0, 22)
    sliderBg.Size = UDim2.new(1, 0, 0, 6)
    sliderBg.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 999
    sliderBg.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 999
    sliderFill.Parent = sliderBg

    local sliderKnob = Instance.new("TextButton")
    sliderKnob.Name = "Knob"
    sliderKnob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0, -8)
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.Text = ""
    sliderKnob.ZIndex = 999
    sliderKnob.Parent = sliderBg

    local dragging = false

    local function updateSlider(input)
        local mousePos = input.Position.X
        local sliderAbsPos = sliderBg.AbsolutePosition.X
        local sliderWidth = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderAbsPos) / sliderWidth, 0, 1)
        local value = minVal + (maxVal - minVal) * percent
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percent, -8, 0, -8)
        sliderLabel.Text = text .. ": " .. math.floor(value)
        return value
    end

    sliderKnob.MouseButton1Down:Connect(function() dragging = true end)

    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            updateSlider(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return {
        Frame = sliderFrame,
        Label = sliderLabel,
        GetValue = function() return tonumber(sliderLabel.Text:match(": (%d+)")) or defaultVal end
    }
end

local function createInput(name, labelText, placeholder, pos, parentObj)
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = name .. "Frame"
    inputFrame.Position = pos
    inputFrame.Size = UDim2.new(0, 220, 0, 45)
    inputFrame.BackgroundTransparency = 1
    inputFrame.ZIndex = 999
    inputFrame.Parent = parentObj

    local inputLabel = Instance.new("TextLabel")
    inputLabel.Size = UDim2.new(1, 0, 0, 18)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = labelText
    inputLabel.TextColor3 = Color3.fromRGB(150, 180, 255)
    inputLabel.TextSize = 11
    inputLabel.Font = Enum.Font.Gotham
    inputLabel.ZIndex = 999
    inputLabel.Parent = inputFrame

    local inputBox = Instance.new("TextBox")
    inputBox.Name = name
    inputBox.Position = UDim2.new(0, 0, 0, 20)
    inputBox.Size = UDim2.new(1, 0, 0, 22)
    inputBox.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    inputBox.BorderSizePixel = 0
    inputBox.PlaceholderText = placeholder
    inputBox.Text = ""
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 11
    inputBox.Font = Enum.Font.Gotham
    inputBox.ZIndex = 999
    inputBox.Parent = inputFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = inputBox

    return inputBox
end

-- === AIMBOT TAB ===
local AimbotModeLabel = Instance.new("TextLabel")
AimbotModeLabel.Position = UDim2.new(0, 15, 0, 5)
AimbotModeLabel.Size = UDim2.new(0, 150, 0, 20)
AimbotModeLabel.BackgroundTransparency = 1
AimbotModeLabel.Text = "Mode:"
AimbotModeLabel.TextColor3 = Color3.fromRGB(150, 180, 255)
AimbotModeLabel.TextSize = 12
AimbotModeLabel.Font = Enum.Font.Gotham
AimbotModeLabel.Parent = ContentFrame

local RageBtn = Instance.new("TextButton")
RageBtn.Position = UDim2.new(0, 15, 0, 28)
RageBtn.Size = UDim2.new(0, 55, 0, 30)
RageBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
RageBtn.BorderSizePixel = 0
RageBtn.Text = "Rage"
RageBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
RageBtn.TextSize = 12
RageBtn.Font = Enum.Font.Gotham
RageBtn.Parent = ContentFrame

local LegitBtn = Instance.new("TextButton")
LegitBtn.Position = UDim2.new(0, 75, 0, 28)
LegitBtn.Size = UDim2.new(0, 55, 0, 30)
LegitBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
LegitBtn.BorderSizePixel = 0
LegitBtn.Text = "Legit"
LegitBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
LegitBtn.TextSize = 12
LegitBtn.Font = Enum.Font.Gotham
LegitBtn.Parent = ContentFrame

local HumanBtn = Instance.new("TextButton")
HumanBtn.Position = UDim2.new(0, 135, 0, 28)
HumanBtn.Size = UDim2.new(0, 55, 0, 30)
HumanBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
HumanBtn.BorderSizePixel = 0
HumanBtn.Text = "Human"
HumanBtn.TextColor3 = Color3.fromRGB(255, 255, 100)
HumanBtn.TextSize = 12
HumanBtn.Font = Enum.Font.Gotham
HumanBtn.Parent = ContentFrame

local AimbotToggle = createToggle("AimbotToggle", "Aimbot", UDim2.new(0, 15, 0, 65), ContentFrame)
local AimbotFOVSlider = createSlider("AimbotFOV", "FOV", UDim2.new(0, 15, 0, 110), 10, 360, 90, ContentFrame)
local AimbotSpeedSlider = createSlider("AimbotSpeed", "Speed", UDim2.new(0, 15, 0, 165), 1, 20, 10, ContentFrame)
local AimbotSmoothSlider = createSlider("AimbotSmooth", "Smooth", UDim2.new(0, 15, 0, 220), 1, 20, 10, ContentFrame)
local HitboxSlider = createSlider("HitboxSlider", "Hitbox", UDim2.new(0, 15, 0, 275), 1, 3, 1, ContentFrame)
local TriggerBotToggle = createToggle("TriggerBotToggle", "Trigger Bot", UDim2.new(0, 15, 0, 330), ContentFrame)

-- === VISUAL TAB ===
local ESPToggle = createToggle("ESPToggle", "ESP 3D", UDim2.new(0, 15, 0, 10), ContentFrame)

-- === MISC TAB ===
local FlyToggle = createToggle("FlyToggle", "Fly", UDim2.new(0, 15, 0, 10), ContentFrame)
local FlySpeedInput = createInput("FlySpeedInput", "Fly Speed:", "50", UDim2.new(0, 15, 0, 55), ContentFrame)
local NoclipToggle = createToggle("NoclipToggle", "Noclip", UDim2.new(0, 15, 0, 110), ContentFrame)
local SpeedToggle = createToggle("SpeedToggle", "Speed Hack", UDim2.new(0, 15, 0, 155), ContentFrame)
local SpeedValueInput = createInput("SpeedValueInput", "Speed:", "50", UDim2.new(0, 15, 0, 200), ContentFrame)
local InfJumpToggle = createToggle("InfJumpToggle", "Inf Jump", UDim2.new(0, 15, 0, 255), ContentFrame)
local NoRecoilToggle = createToggle("NoRecoilToggle", "No Recoil", UDim2.new(0, 15, 0, 300), ContentFrame)

-- === BULLET TAB ===
local MagicBulletToggle = createToggle("MagicBulletToggle", "Magic Bullet", UDim2.new(0, 15, 0, 10), ContentFrame)

-- === ЛОГИКА ===
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

local aimbotEnabled = false
local triggerBotEnabled = false
local magicBulletEnabled = false
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local infJumpEnabled = false
local espEnabled = false
local noRecoilEnabled = false

local aimFOV = 90
local aimSpeed = 10
local aimSmooth = 10
local hitboxSize = 1
local aimbotMode = "Rage"
local panelVisible = false
local triggerCooldown = 0

UIS.MouseBehavior = Enum.MouseBehavior.Default

-- Aimbot Mode
RageBtn.MouseButton1Click:Connect(function()
    aimbotMode = "Rage"
    RageBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 40)
    LegitBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    HumanBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
end)

LegitBtn.MouseButton1Click:Connect(function()
    aimbotMode = "Legit"
    RageBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    LegitBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 40)
    HumanBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
end)

HumanBtn.MouseButton1Click:Connect(function()
    aimbotMode = "Human"
    RageBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    LegitBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    HumanBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 30)
end)

local function animateShow(frame)
    frame.Visible = true
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundTransparency = 1
    TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 500),
        Position = UDim2.new(0.5, -300, 0.5, -250),
        BackgroundTransparency = 0.1
    }):Play()
end

local function animateHide(frame)
    TweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    task.delay(0.15, function() frame.Visible = false end)
end

local function showTab(tabName)
    local tabs = {
        Aimbot = {AimbotModeLabel, RageBtn, LegitBtn, HumanBtn, AimbotToggle, AimbotFOVSlider.Frame, AimbotSpeedSlider.Frame, AimbotSmoothSlider.Frame, HitboxSlider.Frame, TriggerBotToggle},
        Visual = {ESPToggle},
        Misc = {FlyToggle, FlySpeedInput.Parent, NoclipToggle, SpeedToggle, SpeedValueInput.Parent, InfJumpToggle, NoRecoilToggle},
        Bullet = {MagicBulletToggle}
    }
    for name, elements in pairs(tabs) do
        for _, element in ipairs(elements) do
            if element then element.Visible = (name == tabName) end
        end
    end
end

AimbotTab.MouseButton1Click:Connect(function() showTab("Aimbot") end)
VisualTab.MouseButton1Click:Connect(function() showTab("Visual") end)
MiscTab.MouseButton1Click:Connect(function() showTab("Misc") end)
BulletTab.MouseButton1Click:Connect(function() showTab("Bullet") end)

showTab("Aimbot")

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        panelVisible = not panelVisible
        if panelVisible then animateShow(Container) else animateHide(Container) end
    end
    if input.KeyCode == Enum.KeyCode.Y then
        aimbotEnabled = not aimbotEnabled
        AimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
        AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    panelVisible = false
    animateHide(Container)
end)

-- Переключатели
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

TriggerBotToggle.MouseButton1Click:Connect(function()
    triggerBotEnabled = not triggerBotEnabled
    TriggerBotToggle.Text = "Trigger Bot: " .. (triggerBotEnabled and "ON" or "OFF")
    TriggerBotToggle.BackgroundColor3 = triggerBotEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

MagicBulletToggle.MouseButton1Click:Connect(function()
    magicBulletEnabled = not magicBulletEnabled
    MagicBulletToggle.Text = "Magic Bullet: " .. (magicBulletEnabled and "ON" or "OFF")
    MagicBulletToggle.BackgroundColor3 = magicBulletEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

NoclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipToggle.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggle.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
    SpeedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

InfJumpToggle.MouseButton1Click:Connect(function()
    infJumpEnabled = not infJumpEnabled
    InfJumpToggle.Text = "Inf Jump: " .. (infJumpEnabled and "ON" or "OFF")
    InfJumpToggle.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = "ESP 3D: " .. (espEnabled and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

NoRecoilToggle.MouseButton1Click:Connect(function()
    noRecoilEnabled = not noRecoilEnabled
    NoRecoilToggle.Text = "No Recoil: " .. (noRecoilEnabled and "ON" or "OFF")
    NoRecoilToggle.BackgroundColor3 = noRecoilEnabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(25, 30, 50)
end)

plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    if noclipEnabled then
        task.spawn(function()
            task.wait(0.5)
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if noclipEnabled and char then
        local keyParts = {"HumanoidRootPart", "UpperTorso", "LowerTorso", "Head"}
        for _, partName in ipairs(keyParts) do
            local part = char:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Inf Jump
UIS.JumpRequest:Connect(function()
    if infJumpEnabled and char and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(0.05)
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Fly + Speed
RunService.RenderStepped:Connect(function(deltaTime)
    if speedEnabled and char and hum and rootPart then
        local speedValue = tonumber(SpeedValueInput.Text) or 50
        local moveDirection = hum.MoveDirection
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
            local stepDistance = (speedValue - 16) * deltaTime * 0.5
            if stepDistance > 0 then
                rootPart.CFrame = rootPart.CFrame + (moveDirection * stepDistance)
            end
        end
    end

    if flyEnabled and char and hum and rootPart then
        hum.PlatformStand = true
        local flySpeed = tonumber(FlySpeedInput.Text) or 50
        local direction = Vector3.new()
        local camera = workspace.CurrentCamera
        if UIS:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then direction -= Vector3.new(0, 1, 0) end
        if direction.Magnitude > 0 then direction = direction.Unit end
        rootPart.Velocity = direction * flySpeed
    elseif not flyEnabled and hum then
        hum.PlatformStand = false
    end
end)

-- ESP 3D
task.spawn(function()
    while MistePieMenu and MistePieMenu.Parent do
        if espEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= plr and player.Character then
                    local targetChar = player.Character
                    local targetHum = targetChar:FindFirstChild("Humanoid")
                    local targetHead = targetChar:FindFirstChild("Head")

                    if targetHum and targetHead and targetHum.Health > 0 then
                        local billboard = targetHead:FindFirstChild("ESP3D")
                        if not billboard then
                            billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP3D"
                            billboard.Size = UDim2.new(0, 180, 0, 40)
                            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = targetHead

                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            frame.BackgroundTransparency = 0.4
                            frame.Parent = billboard

                            local nameLabel = Instance.new("TextLabel")
                            nameLabel.Name = "NameLabel"
                            nameLabel.Size = UDim2.new(1, 0, 0, 20)
                            nameLabel.BackgroundTransparency = 1
                            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            nameLabel.TextSize = 13
                            nameLabel.Font = Enum.Font.GothamBold
                            nameLabel.Parent = frame

                            local infoLabel = Instance.new("TextLabel")
                            infoLabel.Name = "InfoLabel"
                            infoLabel.Position = UDim2.new(0, 0, 0, 20)
                            infoLabel.Size = UDim2.new(1, 0, 0, 18)
                            infoLabel.BackgroundTransparency = 1
                            infoLabel.TextColor3 = Color3.fromRGB(100, 160, 255)
                            infoLabel.TextSize = 11
                            infoLabel.Font = Enum.Font.Gotham
                            infoLabel.Parent = frame
                        end

                        local frame = billboard:FindFirstChild("Frame")
                        if frame then
                            frame.NameLabel.Text = player.Name
                            local weaponName = "Нет оружия"
                            for _, child in ipairs(targetChar:GetChildren()) do
                                if child:IsA("Tool") then weaponName = child.Name; break end
                            end
                            local dist = (rootPart and (targetHead.Position - rootPart.Position).Magnitude) or 0
                            frame.InfoLabel.Text = "HP: " .. math.floor(targetHum.Health) .. " | " .. math.floor(dist) .. "m | " .. weaponName
                        end

                        local highlight = targetChar:FindFirstChild("ESP3DHighlight")
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "ESP3DHighlight"
                            highlight.FillTransparency = 0.7
                            highlight.OutlineColor = Color3.fromRGB(100, 160, 255)
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.Parent = targetChar
                        end
                    end
                end
            end
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= plr and player.Character then
                    local targetHead = player.Character:FindFirstChild("Head")
                    if targetHead then
                        local billboard = targetHead:FindFirstChild("ESP3D")
                        if billboard then billboard:Destroy() end
                    end
                    local highlight = player.Character:FindFirstChild("ESP3DHighlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
        task.wait(0.3)
    end
end)

-- Magic Bullet
local magicBulletActive = false

local function findDamageRemote(tool)
    for _, child in ipairs(tool:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            return child
        end
    end
    return nil
end

task.spawn(function()
    while MistePieMenu and MistePieMenu.Parent do
        if magicBulletEnabled and char and rootPart then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                local remote = findDamageRemote(tool)
                if remote and not magicBulletActive then
                    magicBulletActive = true
                    local oldFireServer = remote.FireServer
                    remote.FireServer = function(self, ...)
                        local args = {...}
                        local closestEnemy = nil
                        local closestDist = math.huge
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player ~= plr and player.Character then
                                local targetHead = player.Character:FindFirstChild("Head")
                                if targetHead then
                                    local dist = (targetHead.Position - rootPart.Position).Magnitude
                                    if dist < closestDist then
                                        closestDist = dist
                                        closestEnemy = targetHead
                                    end
                                end
                            end
                        end

                        if closestEnemy then
                            for i, arg in ipairs(args) do
                                if typeof(arg) == "Vector3" then
                                    args[i] = closestEnemy.Position
                                elseif typeof(arg) == "CFrame" then
                                    args[i] = CFrame.new(closestEnemy.Position)
                                elseif typeof(arg) == "number" and arg > 0 and arg < 1000 then
                                    args[i] = arg * 10
                                end
                            end
                        end

                        return oldFireServer(self, unpack(args))
                    end
                end
            else
                magicBulletActive = false
            end
        end
        task.wait(0.2)
    end
end)

-- FOV Circle
local FOVCircle = nil
if Drawing and Drawing.new then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = false
    FOVCircle.Thickness = 2
    FOVCircle.Radius = 100
    FOVCircle.Color = Color3.fromRGB(60, 120, 255)
    getgenv().MistePieFOV = FOVCircle
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and FOVCircle then
        aimFOV = AimbotFOVSlider.GetValue()
        local camera = workspace.CurrentCamera
        local screenSize = camera.ViewportSize
        local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
        local radius = math.tan(math.rad(aimFOV) / 2) * (screenSize.Y / 2)
        FOVCircle.Visible = true
        FOVCircle.Radius = radius
        FOVCircle.Position = center
    elseif FOVCircle then
        FOVCircle.Visible = false
    end
end)

-- Aimbot
local function getClosestInFOV()
    if not char or not rootPart then return nil end
    local camera = workspace.CurrentCamera
    local cameraPos = camera.CFrame.Position
    local cameraForward = camera.CFrame.LookVector
    local closestTarget = nil
    local closestAngle = math.rad(aimFOV)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and player.Character then
            local targetHum = player.Character:FindFirstChild("Humanoid")
            local targetHead = player.Character:FindFirstChild("Head")
            if targetHum and targetHead and targetHum.Health > 0 then
                local directionToTarget = (targetHead.Position - cameraPos).Unit
                local angle = math.acos(math.clamp(cameraForward:Dot(directionToTarget), -1, 1))
                if angle < closestAngle then
                    closestAngle = angle
                    closestTarget = {Head = targetHead, Player = player}
                end
            end
        end
    end
    return closestTarget
end

-- Trigger Bot
task.spawn(function()
    while MistePieMenu and MistePieMenu.Parent do
        if triggerBotEnabled and aimbotEnabled then
            local target = getClosestInFOV()
            if target then
                VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.03)
                VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                task.wait(math.random(50, 150) / 1000)
            end
        end
        task.wait(0.05)
    end
end)

-- Хитбоксы
local lastHitboxSize = 1

local function applyHitboxSize()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part:IsDescendantOf(workspace) then
                    if hitboxSize > 1 then
                        if not part:GetAttribute("OriginalSize") then
                            part:SetAttribute("OriginalSize", part.Size)
                        end
                        part.Size = part:GetAttribute("OriginalSize") * hitboxSize
                    else
                        local origSize = part:GetAttribute("OriginalSize")
                        if origSize then
                            part.Size = origSize
                            part:SetAttribute("OriginalSize", nil)
                        end
                    end
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function(deltaTime)
    aimSpeed = AimbotSpeedSlider.GetValue()
    aimSmooth = AimbotSmoothSlider.GetValue()
    hitboxSize = HitboxSlider.GetValue()

    if hitboxSize ~= lastHitboxSize then
        lastHitboxSize = hitboxSize
        applyHitboxSize()
    end

    if aimbotEnabled and char and rootPart then
        local target = getClosestInFOV()
        if target then
            local camera = workspace.CurrentCamera

            if aimbotMode == "Rage" then
                camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Head.Position)
            elseif aimbotMode == "Legit" then
                local targetCFrame = CFrame.lookAt(camera.CFrame.Position, target.Head.Position)
                local smoothFactor = aimSmooth / 100
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothFactor)
            elseif aimbotMode == "Human" then
                task.wait(math.random(150, 300) / 1000)
                local targetCFrame = CFrame.lookAt(camera.CFrame.Position, target.Head.Position + Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)))
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.05)
            end
        end
    end
end)

print("MistePieMenu v10 loaded!")
