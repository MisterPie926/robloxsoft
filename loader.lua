-- Загрузчик MistePieMenu v3 (исправленный)
local parent = (gethui and gethui()) or game:GetService('CoreGui') or game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')

if parent:FindFirstChild("MistePieMenu") then
    parent.MistePieMenu:Destroy()
end

-- ВАЖНО: Объявляем UIS ДО создания слайдеров
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local MistePieMenu = Instance.new("ScreenGui")
MistePieMenu.Name = "MistePieMenu"
MistePieMenu.ResetOnSpawn = true
MistePieMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MistePieMenu.Parent = parent

-- Главный контейнер
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Position = UDim2.new(0.5, -300, 0.5, -250)
Container.Size = UDim2.new(0, 600, 0, 500)
Container.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Container.BorderSizePixel = 0
Container.Visible = false
Container.Parent = MistePieMenu

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 10)
ContainerCorner.Parent = Container

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Color = Color3.fromRGB(100, 100, 255)
ContainerStroke.Thickness = 2
ContainerStroke.Parent = Container

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Container

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "MistePieMenu v3"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- Вкладки
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.Size = UDim2.new(0, 120, 1, -40)
TabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = Container

local function createTab(name, text, yPos)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Position = UDim2.new(0, 5, 0, yPos)
    tab.Size = UDim2.new(1, -10, 0, 35)
    tab.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    tab.BorderSizePixel = 0
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 14
    tab.Font = Enum.Font.Gotham
    tab.Parent = TabFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 5)
    tabCorner.Parent = tab

    return tab
end

local LegitTab = createTab("LegitTab", "Legit", 10)
local RageTab = createTab("RageTab", "Rage", 50)
local VisualTab = createTab("VisualTab", "Visual", 90)
local MiscTab = createTab("MiscTab", "Misc", 130)
local SettingsTab = createTab("SettingsTab", "Settings", 170)

-- Контент вкладок
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Position = UDim2.new(0, 120, 0, 40)
ContentFrame.Size = UDim2.new(1, -120, 1, -40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = Container

-- Функция создания кнопки-переключателя
local function createToggle(name, text, pos, parentObj)
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Position = pos
    toggle.Size = UDim2.new(0, 200, 0, 35)
    toggle.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    toggle.BorderSizePixel = 0
    toggle.Text = text .. ": OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 13
    toggle.Font = Enum.Font.Gotham
    toggle.Parent = parentObj

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 5)
    toggleCorner.Parent = toggle

    return toggle
end

-- Функция создания слайдера
local function createSlider(name, text, pos, minVal, maxVal, defaultVal, parentObj)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Position = pos
    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parentObj

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text .. ": " .. defaultVal
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 12
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.Parent = sliderFrame

    local sliderBg = Instance.new("Frame")
    sliderBg.Position = UDim2.new(0, 0, 0, 25)
    sliderBg.Size = UDim2.new(1, 0, 0, 6)
    sliderBg.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = sliderFrame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 3)
    sliderCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg

    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 3)
    sliderFillCorner.Parent = sliderFill

    local sliderKnob = Instance.new("TextButton")
    sliderKnob.Name = "Knob"
    sliderKnob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0, -7)
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.Text = ""
    sliderKnob.Parent = sliderBg

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = sliderKnob

    -- Логика слайдера
    local dragging = false
    
    local function updateSlider(input)
        local mousePos = input.Position.X
        local sliderAbsPos = sliderBg.AbsolutePosition.X
        local sliderWidth = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderAbsPos) / sliderWidth, 0, 1)
        local value = minVal + (maxVal - minVal) * percent
        
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percent, -8, 0, -7)
        sliderLabel.Text = text .. ": " .. math.floor(value)
        
        return value
    end

    sliderKnob.MouseButton1Down:Connect(function()
        dragging = true
    end)

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

-- === ВКЛАДКА LEGIT ===
local AimbotToggle = createToggle("AimbotToggle", "Aimbot", UDim2.new(0, 10, 0, 10), ContentFrame)
local AimbotFOVSlider = createSlider("AimbotFOV", "FOV", UDim2.new(0, 10, 0, 60), 10, 360, 90, ContentFrame)
local AimbotSpeedSlider = createSlider("AimbotSpeed", "Speed", UDim2.new(0, 10, 0, 120), 1, 20, 10, ContentFrame)

-- === ВКЛАДКА RAGE ===
local RageAimbotToggle = createToggle("RageAimbotToggle", "Rage Aimbot", UDim2.new(0, 10, 0, 10), ContentFrame)

-- === ВКЛАДКА VISUAL ===
local ESPToggle = createToggle("ESPToggle", "ESP", UDim2.new(0, 10, 0, 10), ContentFrame)

-- === ВКЛАДКА MISC ===
local FlyToggle = createToggle("FlyToggle", "Fly", UDim2.new(0, 10, 0, 10), ContentFrame)
local NoclipToggle = createToggle("NoclipToggle", "Noclip", UDim2.new(0, 10, 0, 55), ContentFrame)
local SpeedToggle = createToggle("SpeedToggle", "Speed Hack", UDim2.new(0, 10, 0, 100), ContentFrame)
local JumpToggle = createToggle("JumpToggle", "Jump Hack", UDim2.new(0, 10, 0, 145), ContentFrame)

-- === ВКЛАДКА SETTINGS ===
local ColorPicker = Instance.new("TextBox")
ColorPicker.Name = "ColorPicker"
ColorPicker.Position = UDim2.new(0, 10, 0, 10)
ColorPicker.Size = UDim2.new(0, 200, 0, 35)
ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ColorPicker.BorderSizePixel = 0
ColorPicker.PlaceholderText = "FOV Color (R,G,B)"
ColorPicker.Text = "255,0,0"
ColorPicker.TextColor3 = Color3.fromRGB(0, 0, 0)
ColorPicker.TextSize = 12
ColorPicker.Font = Enum.Font.Gotham
ColorPicker.Parent = ContentFrame

local ColorCorner = Instance.new("UICorner")
ColorCorner.CornerRadius = UDim.new(0, 5)
ColorCorner.Parent = ColorPicker

-- === ЛОГИКА ===
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

local aimbotEnabled = false
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local jumpEnabled = false
local espEnabled = false
local rageAimbotEnabled = false

local fovColor = Color3.fromRGB(255, 0, 0)
local aimFOV = 90
local aimSpeed = 10
local panelVisible = false

-- Переключение вкладок
LegitTab.MouseButton1Click:Connect(function()
    AimbotToggle.Visible = true
    AimbotFOVSlider.Frame.Visible = true
    AimbotSpeedSlider.Frame.Visible = true
    RageAimbotToggle.Visible = false
    ESPToggle.Visible = false
    FlyToggle.Visible = false
    NoclipToggle.Visible = false
    SpeedToggle.Visible = false
    JumpToggle.Visible = false
    ColorPicker.Visible = false
end)

RageTab.MouseButton1Click:Connect(function()
    AimbotToggle.Visible = false
    AimbotFOVSlider.Frame.Visible = false
    AimbotSpeedSlider.Frame.Visible = false
    RageAimbotToggle.Visible = true
    ESPToggle.Visible = false
    FlyToggle.Visible = false
    NoclipToggle.Visible = false
    SpeedToggle.Visible = false
    JumpToggle.Visible = false
    ColorPicker.Visible = false
end)

VisualTab.MouseButton1Click:Connect(function()
    AimbotToggle.Visible = false
    AimbotFOVSlider.Frame.Visible = false
    AimbotSpeedSlider.Frame.Visible = false
    RageAimbotToggle.Visible = false
    ESPToggle.Visible = true
    FlyToggle.Visible = false
    NoclipToggle.Visible = false
    SpeedToggle.Visible = false
    JumpToggle.Visible = false
    ColorPicker.Visible = false
end)

MiscTab.MouseButton1Click:Connect(function()
    AimbotToggle.Visible = false
    AimbotFOVSlider.Frame.Visible = false
    AimbotSpeedSlider.Frame.Visible = false
    RageAimbotToggle.Visible = false
    ESPToggle.Visible = false
    FlyToggle.Visible = true
    NoclipToggle.Visible = true
    SpeedToggle.Visible = true
    JumpToggle.Visible = true
    ColorPicker.Visible = false
end)

SettingsTab.MouseButton1Click:Connect(function()
    AimbotToggle.Visible = false
    AimbotFOVSlider.Frame.Visible = false
    AimbotSpeedSlider.Frame.Visible = false
    RageAimbotToggle.Visible = false
    ESPToggle.Visible = false
    FlyToggle.Visible = false
    NoclipToggle.Visible = false
    SpeedToggle.Visible = false
    JumpToggle.Visible = false
    ColorPicker.Visible = true
end)

-- Показываем Legit по умолчанию
-- Стало (правильно):
AimbotToggle.Visible = true
AimbotFOVSlider.Frame.Visible = true
AimbotSpeedSlider.Frame.Visible = true
RageAimbotToggle.Visible = false
ESPToggle.Visible = false
FlyToggle.Visible = false
NoclipToggle.Visible = false
SpeedToggle.Visible = false
JumpToggle.Visible = false
ColorPicker.Visible = false

-- Открытие/закрытие по H
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        panelVisible = not panelVisible
        Container.Visible = panelVisible
    end
    if input.KeyCode == Enum.KeyCode.Y then
        aimbotEnabled = not aimbotEnabled
        AimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
        AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    panelVisible = false
    Container.Visible = false
end)

-- Обновление цвета FOV
ColorPicker.FocusLost:Connect(function()
    local r, g, b = ColorPicker.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
    if r and g and b then
        fovColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
    end
end)

-- Aimbot переключатель
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
end)

-- Fly
FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    if hum then hum.PlatformStand = flyEnabled end
end)

-- Noclip
NoclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipToggle.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
end)

-- Speed
SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggle.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
    SpeedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    if hum then
        hum.WalkSpeed = speedEnabled and 50 or 16
    end
end)

-- Jump
JumpToggle.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    JumpToggle.Text = "Jump: " .. (jumpEnabled and "ON" or "OFF")
    JumpToggle.BackgroundColor3 = jumpEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    if hum then
        hum.JumpPower = jumpEnabled and 50 or 7.2
    end
end)

-- ESP
ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
end)

-- Rage Aimbot
RageAimbotToggle.MouseButton1Click:Connect(function()
    rageAimbotEnabled = not rageAimbotEnabled
    RageAimbotToggle.Text = "Rage Aimbot: " .. (rageAimbotEnabled and "ON" or "OFF")
    RageAimbotToggle.BackgroundColor3 = rageAimbotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
end)

-- Обновление персонажа
plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    
    if flyEnabled then hum.PlatformStand = true end
    if speedEnabled then hum.WalkSpeed = 50 end
    if jumpEnabled then hum.JumpPower = 50 end
    if noclipEnabled then
        task.spawn(function()
            task.wait(0.5)
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

-- Noclip цикл
RunService.Stepped:Connect(function()
    if noclipEnabled and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Fly цикл
RunService.RenderStepped:Connect(function()
    if flyEnabled and char and hum and rootPart then
        hum.PlatformStand = true
        local direction = Vector3.new()
        local camera = workspace.CurrentCamera

        if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end

        if direction.Magnitude > 0 then direction = direction.Unit end
        rootPart.Velocity = direction * 50
    end
end)

-- ESP цикл
task.spawn(function()
    while true do
        if espEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= plr and player.Character then
                    local highlight = player.Character:FindFirstChild("ESPHighlight") or Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = fovColor
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = player.Character
                end
            end
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("ESPHighlight") then
                    player.Character.ESPHighlight:Destroy()
                end
            end
        end
        task.wait(1)
    end
end)

-- Рисование FOV круга
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2
FOVCircle.Radius = 100
FOVCircle.Color = fovColor
FOVCircle.Position = workspace.CurrentCamera.ViewportSize / 2

-- Обновление FOV круга
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local camera = workspace.CurrentCamera
        aimFOV = AimbotFOVSlider.GetValue()
        aimSpeed = AimbotSpeedSlider.GetValue()
        
        local screenSize = camera.ViewportSize
        local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
        local radius = math.tan(math.rad(aimFOV) / 2) * (screenSize.Y / 2)
        
        FOVCircle.Visible = true
        FOVCircle.Radius = radius
        FOVCircle.Position = center
        FOVCircle.Color = fovColor
    else
        FOVCircle.Visible = false
    end
end)

-- Aimbot функция
local function getClosestInFOV()
    if not char or not rootPart then return nil end
    local camera = workspace.CurrentCamera
    local cameraPos = camera.CFrame.Position
    local cameraForward = camera.CFrame.LookVector

    local closestTarget = nil
    local closestAngle = math.rad(aimFOV)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and player.Character then
            local targetChar = player.Character
            local targetHum = targetChar:FindFirstChild("Humanoid")
            local targetHead = targetChar:FindFirstChild("Head")
            
            if targetHum and targetHead and targetHum.Health > 0 then
                local directionToTarget = (targetHead.Position - cameraPos).Unit
                local angle = math.acos(math.clamp(cameraForward:Dot(directionToTarget), -1, 1))

                if angle < closestAngle then
                    closestAngle = angle
                    closestTarget = targetHead
                end
            end
        end
    end

    return closestTarget
end

-- Aimbot цикл (плавная наводка)
RunService.RenderStepped:Connect(function(deltaTime)
    if aimbotEnabled and char and rootPart then
        local target = getClosestInFOV()
        if target then
            local camera = workspace.CurrentCamera
            local targetCFrame = CFrame.lookAt(camera.CFrame.Position, target.Position)
            
            local speedMultiplier = aimSpeed / 10
            camera.CFrame = camera.CFrame:Lerp(targetCFrame, math.clamp(speedMultiplier * deltaTime * 10, 0, 1))
        end
    end
    
    if rageAimbotEnabled and char and rootPart then
        local target = getClosestInFOV()
        if target then
            local camera = workspace.CurrentCamera
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Position)
        end
    end
end)

print("MistePieMenu v3 loaded!")
