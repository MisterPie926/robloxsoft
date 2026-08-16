-- MistePieMenu v8.1 (Fixed Hitboxes + Trigger Bot + Mass Kill)
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
local RS = game:GetService("ReplicatedStorage")

local MistePieMenu = Instance.new("ScreenGui")
MistePieMenu.Name = "MistePieMenu"
MistePieMenu.ResetOnSpawn = true
MistePieMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MistePieMenu.DisplayOrder = 999
MistePieMenu.Parent = parent

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Position = UDim2.new(0.5, -350, 0.5, -280)
Container.Size = UDim2.new(0, 700, 0, 560)
Container.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
Container.BackgroundTransparency = 0.15
Container.BorderSizePixel = 0
Container.Visible = false
Container.ClipsDescendants = true
Container.ZIndex = 999
Container.Parent = MistePieMenu

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 15)
ContainerCorner.Parent = Container

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Color = Color3.fromRGB(130, 80, 255)
ContainerStroke.Thickness = 2
ContainerStroke.Transparency = 0.3
ContainerStroke.Parent = Container

-- Принудительный курсор
UIS.MouseBehavior = Enum.MouseBehavior.Default

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 999
TitleBar.Parent = Container

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "✦ MISTE PIE v8.1 ✦"
TitleText.TextColor3 = Color3.fromRGB(180, 130, 255)
TitleText.TextSize = 22
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 999
CloseBtn.Parent = TitleBar

local TabFrame = Instance.new("Frame")
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.Size = UDim2.new(0, 130, 1, -50)
TabFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 40)
TabFrame.BackgroundTransparency = 0.2
TabFrame.BorderSizePixel = 0
TabFrame.ZIndex = 999
TabFrame.Parent = Container

local function createTab(name, text, yPos)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Position = UDim2.new(0, 5, 0, yPos)
    tab.Size = UDim2.new(1, -10, 0, 40)
    tab.BackgroundColor3 = Color3.fromRGB(50, 35, 90)
    tab.BackgroundTransparency = 0.2
    tab.BorderSizePixel = 0
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(200, 180, 255)
    tab.TextSize = 14
    tab.Font = Enum.Font.Gotham
    tab.ZIndex = 999
    tab.Parent = TabFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab

    return tab
end

local AimbotTab = createTab("AimbotTab", "🎯 Aimbot", 10)
local VisualTab = createTab("VisualTab", "👁 Visual", 55)
local MiscTab = createTab("MiscTab", "⚡ Misc", 100)
local ToolsTab = createTab("ToolsTab", "🔧 Tools", 145)
local KillTab = createTab("KillTab", "💀 Kill", 190)

local ContentFrame = Instance.new("Frame")
ContentFrame.Position = UDim2.new(0, 130, 0, 50)
ContentFrame.Size = UDim2.new(1, -130, 1, -50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0
ContentFrame.ZIndex = 999
ContentFrame.Parent = Container

local function createToggle(name, text, pos, parentObj)
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Position = pos
    toggle.Size = UDim2.new(0, 200, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(90, 50, 140)
    toggle.BackgroundTransparency = 0.2
    toggle.BorderSizePixel = 0
    toggle.Text = text .. ": OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 13
    toggle.Font = Enum.Font.Gotham
    toggle.ZIndex = 999
    toggle.Parent = parentObj

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggle

    return toggle
end

local function createSlider(name, text, pos, minVal, maxVal, defaultVal, parentObj)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Position = pos
    sliderFrame.Size = UDim2.new(0, 250, 0, 50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.ZIndex = 999
    sliderFrame.Parent = parentObj

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text .. ": " .. defaultVal
    sliderLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
    sliderLabel.TextSize = 12
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.ZIndex = 999
    sliderLabel.Parent = sliderFrame

    local sliderBg = Instance.new("Frame")
    sliderBg.Position = UDim2.new(0, 0, 0, 25)
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 45, 100)
    sliderBg.BackgroundTransparency = 0.2
    sliderBg.BorderSizePixel = 0
    sliderBg.ZIndex = 999
    sliderBg.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(180, 130, 255)
    sliderFill.BackgroundTransparency = 0.1
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 999
    sliderFill.Parent = sliderBg

    local sliderKnob = Instance.new("TextButton")
    sliderKnob.Name = "Knob"
    sliderKnob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -10, 0, -9)
    sliderKnob.Size = UDim2.new(0, 20, 0, 20)
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
        sliderKnob.Position = UDim2.new(percent, -10, 0, -9)
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

local function createInput(name, labelText, placeholder, pos, parentObj)
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = name .. "Frame"
    inputFrame.Position = pos
    inputFrame.Size = UDim2.new(0, 250, 0, 50)
    inputFrame.BackgroundTransparency = 1
    inputFrame.ZIndex = 999
    inputFrame.Parent = parentObj

    local inputLabel = Instance.new("TextLabel")
    inputLabel.Size = UDim2.new(1, 0, 0, 20)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = labelText
    inputLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
    inputLabel.TextSize = 12
    inputLabel.Font = Enum.Font.Gotham
    inputLabel.ZIndex = 999
    inputLabel.Parent = inputFrame

    local inputBox = Instance.new("TextBox")
    inputBox.Name = name
    inputBox.Position = UDim2.new(0, 0, 0, 22)
    inputBox.Size = UDim2.new(1, 0, 0, 25)
    inputBox.BackgroundColor3 = Color3.fromRGB(60, 45, 100)
    inputBox.BackgroundTransparency = 0.2
    inputBox.BorderSizePixel = 0
    inputBox.PlaceholderText = placeholder
    inputBox.Text = ""
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 12
    inputBox.Font = Enum.Font.Gotham
    inputBox.ZIndex = 999
    inputBox.Parent = inputFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 5)
    inputCorner.Parent = inputBox

    return inputBox
end

-- === AIMBOT ===
local AimbotToggle = createToggle("AimbotToggle", "Aimbot", UDim2.new(0, 20, 0, 15), ContentFrame)
local AimbotFOVSlider = createSlider("AimbotFOV", "FOV", UDim2.new(0, 20, 0, 70), 10, 360, 90, ContentFrame)
local AimbotSpeedSlider = createSlider("AimbotSpeed", "Speed", UDim2.new(0, 20, 0, 130), 1, 20, 10, ContentFrame)
local AimbotSmoothSlider = createSlider("AimbotSmooth", "Smooth", UDim2.new(0, 20, 0, 190), 1, 20, 10, ContentFrame)
local HitboxSlider = createSlider("HitboxSlider", "Hitbox Size", UDim2.new(0, 20, 0, 250), 1, 5, 1, ContentFrame)
local TriggerBotToggle = createToggle("TriggerBotToggle", "Trigger Bot", UDim2.new(0, 20, 0, 310), ContentFrame)

-- === VISUAL ===
local ESPToggle = createToggle("ESPToggle", "ESP (Billboard)", UDim2.new(0, 20, 0, 15), ContentFrame)

-- === MISC ===
local FlyToggle = createToggle("FlyToggle", "Fly", UDim2.new(0, 20, 0, 15), ContentFrame)
local FlySpeedInput = createInput("FlySpeedInput", "Скорость полёта:", "50", UDim2.new(0, 20, 0, 65), ContentFrame)
local NoclipToggle = createToggle("NoclipToggle", "Noclip", UDim2.new(0, 20, 0, 125), ContentFrame)
local SpeedToggle = createToggle("SpeedToggle", "Speed Hack", UDim2.new(0, 20, 0, 175), ContentFrame)
local SpeedValueInput = createInput("SpeedValueInput", "Скорость:", "50", UDim2.new(0, 20, 0, 225), ContentFrame)
local InfJumpToggle = createToggle("InfJumpToggle", "Inf Jump", UDim2.new(0, 20, 0, 285), ContentFrame)

-- === KILL ===
local MassKillToggle = createToggle("MassKillToggle", "Mass Kill (Visual)", UDim2.new(0, 20, 0, 15), ContentFrame)

-- === TOOLS ===
local ToolsList = Instance.new("ScrollingFrame")
ToolsList.Name = "ToolsList"
ToolsList.Position = UDim2.new(0, 20, 0, 15)
ToolsList.Size = UDim2.new(1, -40, 1, -80)
ToolsList.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
ToolsList.BackgroundTransparency = 0.2
ToolsList.BorderSizePixel = 0
ToolsList.ScrollBarThickness = 6
ToolsList.ZIndex = 999
ToolsList.Parent = ContentFrame

local ToolsLayout = Instance.new("UIListLayout")
ToolsLayout.Padding = UDim.new(0, 3)
ToolsLayout.Parent = ToolsList

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Position = UDim2.new(0, 20, 1, -50)
RefreshBtn.Size = UDim2.new(0, 100, 0, 30)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 180)
RefreshBtn.BackgroundTransparency = 0.2
RefreshBtn.BorderSizePixel = 0
RefreshBtn.Text = "🔄 Обновить"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 12
RefreshBtn.Font = Enum.Font.Gotham
RefreshBtn.ZIndex = 999
RefreshBtn.Parent = ContentFrame

-- Функция построения дерева
local function buildToolsTree()
    for _, child in ipairs(ToolsList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local function createTreeNode(item, depth, parentContainer)
        local nodeFrame = Instance.new("Frame")
        nodeFrame.Size = UDim2.new(1, 0, 0, 30)
        nodeFrame.BackgroundTransparency = 1
        nodeFrame.Parent = parentContainer or ToolsList

        local rowFrame = Instance.new("Frame")
        rowFrame.Size = UDim2.new(1, 0, 0, 30)
        rowFrame.BackgroundTransparency = 1
        rowFrame.Parent = nodeFrame

        local itemBtn = Instance.new("TextButton")
        itemBtn.Size = UDim2.new(1, -80, 1, 0)
        itemBtn.Position = UDim2.new(0, depth * 20, 0, 0)
        itemBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
        itemBtn.BackgroundTransparency = 0.2
        itemBtn.BorderSizePixel = 0
        local isFolderLike = item:IsA("Folder") or item:IsA("Model") or item:IsA("Configuration")
        itemBtn.Text = (isFolderLike and "📁 " or "📄 ") .. item.Name
        itemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemBtn.TextSize = 11
        itemBtn.Font = Enum.Font.Gotham
        itemBtn.TextXAlignment = Enum.TextXAlignment.Left
        itemBtn.Parent = rowFrame

        local copyBtn = Instance.new("TextButton")
        copyBtn.Size = UDim2.new(0, 35, 1, 0)
        copyBtn.Position = UDim2.new(1, -70, 0, 0)
        copyBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
        copyBtn.BackgroundTransparency = 0.2
        copyBtn.BorderSizePixel = 0
        copyBtn.Text = "📋"
        copyBtn.Parent = rowFrame

        local viewBtn = Instance.new("TextButton")
        viewBtn.Size = UDim2.new(0, 35, 1, 0)
        viewBtn.Position = UDim2.new(1, -30, 0, 0)
        viewBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
        viewBtn.BackgroundTransparency = 0.2
        viewBtn.BorderSizePixel = 0
        viewBtn.Text = "👁"
        viewBtn.Visible = item:IsA("Script") or item:IsA("LocalScript") or item:IsA("ModuleScript")
        viewBtn.Parent = rowFrame

        local childrenContainer = nil
        local childrenLoaded = false
        local isExpanded = false

        if isFolderLike then
            itemBtn.MouseButton1Click:Connect(function()
                if not childrenLoaded then
                    childrenContainer = Instance.new("Frame")
                    childrenContainer.Size = UDim2.new(1, 0, 0, 0)
                    childrenContainer.BackgroundTransparency = 1
                    childrenContainer.Parent = nodeFrame

                    local childLayout = Instance.new("UIListLayout")
                    childLayout.Padding = UDim.new(0, 2)
                    childLayout.Parent = childrenContainer

                    local totalHeight = 0
                    for _, child in ipairs(item:GetChildren()) do
                        createTreeNode(child, depth + 1, childrenContainer)
                        totalHeight += 32
                    end
                    childrenContainer.Size = UDim2.new(1, 0, 0, totalHeight)
                    nodeFrame.Size = UDim2.new(1, 0, 0, 30 + totalHeight)
                    childrenLoaded = true
                    isExpanded = true
                    itemBtn.Text = "📂 " .. item.Name
                else
                    isExpanded = not isExpanded
                    if childrenContainer then
                        childrenContainer.Visible = isExpanded
                        nodeFrame.Size = UDim2.new(1, 0, 0, isExpanded and (30 + childrenContainer.AbsoluteSize.Y) or 30)
                    end
                    itemBtn.Text = (isExpanded and "📂 " or "📁 ") .. item.Name
                end
            end)
        else
            if item:IsA("Tool") then
                itemBtn.MouseButton1Click:Connect(function()
                    local backpack = plr:FindFirstChild("Backpack")
                    if backpack then
                        local clonedTool = item:Clone()
                        clonedTool.Parent = backpack
                        itemBtn.Text = "✅ " .. item.Name
                        task.delay(2, function()
                            if itemBtn and itemBtn.Parent then
                                itemBtn.Text = "📄 " .. item.Name
                            end
                        end)
                    end
                end)
            end

            copyBtn.MouseButton1Click:Connect(function()
                local backpack = plr:FindFirstChild("Backpack")
                if backpack then
                    local clonedItem = item:Clone()
                    clonedItem.Parent = backpack
                    copyBtn.Text = "✅"
                    task.delay(1, function() copyBtn.Text = "📋" end)
                end
            end)

            if item:IsA("Script") or item:IsA("LocalScript") or item:IsA("ModuleScript") then
                viewBtn.MouseButton1Click:Connect(function()
                    local success, src = pcall(function() return item.Source end)
                    if success and src then
                        if setclipboard then
                            setclipboard(src)
                            viewBtn.Text = "✅"
                            task.delay(1, function() viewBtn.Text = "👁" end)
                        end
                    end
                end)
            end
        end

        return nodeFrame
    end

    for _, child in ipairs(RS:GetChildren()) do
        createTreeNode(child, 0, nil)
    end
end

buildToolsTree()
RefreshBtn.MouseButton1Click:Connect(buildToolsTree)

-- === ЛОГИКА ===
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

local aimbotEnabled = false
local triggerBotEnabled = false
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local infJumpEnabled = false
local espEnabled = false
local massKillEnabled = false

local aimFOV = 90
local aimSpeed = 10
local aimSmooth = 10
local hitboxSize = 1
local panelVisible = false

-- Принудительный курсор
UIS.MouseBehavior = Enum.MouseBehavior.Default

local function animateShow(frame)
    frame.Visible = true
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundTransparency = 1
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 700, 0, 560),
        Position = UDim2.new(0.5, -350, 0.5, -280),
        BackgroundTransparency = 0.15
    }):Play()
end

local function animateHide(frame)
    TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    task.delay(0.2, function() frame.Visible = false end)
end

local function showTab(tabName)
    local tabs = {
        Aimbot = {AimbotToggle, AimbotFOVSlider.Frame, AimbotSpeedSlider.Frame, AimbotSmoothSlider.Frame, HitboxSlider.Frame, TriggerBotToggle},
        Visual = {ESPToggle},
        Misc = {FlyToggle, FlySpeedInput.Parent, NoclipToggle, SpeedToggle, SpeedValueInput.Parent, InfJumpToggle},
        Tools = {ToolsList, RefreshBtn},
        Kill = {MassKillToggle}
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
ToolsTab.MouseButton1Click:Connect(function() showTab("Tools") end)
KillTab.MouseButton1Click:Connect(function() showTab("Kill") end)

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
        AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
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
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

TriggerBotToggle.MouseButton1Click:Connect(function()
    triggerBotEnabled = not triggerBotEnabled
    TriggerBotToggle.Text = "Trigger Bot: " .. (triggerBotEnabled and "ON" or "OFF")
    TriggerBotToggle.BackgroundColor3 = triggerBotEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

NoclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipToggle.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggle.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
    SpeedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

InfJumpToggle.MouseButton1Click:Connect(function()
    infJumpEnabled = not infJumpEnabled
    InfJumpToggle.Text = "Inf Jump: " .. (infJumpEnabled and "ON" or "OFF")
    InfJumpToggle.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

MassKillToggle.MouseButton1Click:Connect(function()
    massKillEnabled = not massKillEnabled
    MassKillToggle.Text = "Mass Kill: " .. (massKillEnabled and "ON" or "OFF")
    MassKillToggle.BackgroundColor3 = massKillEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(90, 50, 140)
end)

plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    if noclipEnabled then
        task.spawn(function()
            task.wait(0.5)
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
            end
        end)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if noclipEnabled and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end
end)

-- Бесконечные прыжки
UIS.JumpRequest:Connect(function()
    if infJumpEnabled and char and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Speed + Fly
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
    end
end)

-- ESP через BillboardGui
task.spawn(function()
    while MistePieMenu and MistePieMenu.Parent do
        if espEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= plr and player.Character then
                    local targetChar = player.Character
                    local targetHum = targetChar:FindFirstChild("Humanoid")
                    local targetHead = targetChar:FindFirstChild("Head")

                    if targetHum and targetHead and targetHum.Health > 0 then
                        local billboard = targetHead:FindFirstChild("ESPBillboard")
                        if not billboard then
                            billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESPBillboard"
                            billboard.Size = UDim2.new(0, 200, 0, 45)
                            billboard.StudsOffset = Vector3.new(0, 3, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = targetHead

                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            frame.BackgroundTransparency = 0.5
                            frame.Parent = billboard

                            local nameLabel = Instance.new("TextLabel")
                            nameLabel.Name = "NameLabel"
                            nameLabel.Size = UDim2.new(1, 0, 0, 22)
                            nameLabel.BackgroundTransparency = 1
                            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            nameLabel.TextSize = 14
                            nameLabel.Font = Enum.Font.GothamBold
                            nameLabel.Parent = frame

                            local infoLabel = Instance.new("TextLabel")
                            infoLabel.Name = "InfoLabel"
                            infoLabel.Position = UDim2.new(0, 0, 0, 22)
                            infoLabel.Size = UDim2.new(1, 0, 0, 20)
                            infoLabel.BackgroundTransparency = 1
                            infoLabel.TextColor3 = Color3.fromRGB(180, 130, 255)
                            infoLabel.TextSize = 12
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
                            frame.InfoLabel.Text = "HP: " .. math.floor(targetHum.Health) .. " | " .. weaponName
                        end

                        local highlight = targetChar:FindFirstChild("ESPHighlight")
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "ESPHighlight"
                            highlight.FillTransparency = 0.7
                            highlight.OutlineColor = Color3.fromRGB(180, 130, 255)
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
                        local billboard = targetHead:FindFirstChild("ESPBillboard")
                        if billboard then billboard:Destroy() end
                    end
                    local highlight = player.Character:FindFirstChild("ESPHighlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- Mass Kill (визуальный эффект — парты и заморозка только визуально)
task.spawn(function()
    while MistePieMenu and MistePieMenu.Parent do
        if massKillEnabled and char and rootPart then
            local players = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= plr and player.Character then
                    table.insert(players, player)
                end
            end

            -- Создаём 10 партов перед собой
            for i = 1, 10 do
                local part = Instance.new("Part")
                part.Size = Vector3.new(3, 3, 3)
                part.Position = rootPart.Position + rootPart.CFrame.LookVector * (5 + i * 3) + Vector3.new(0, 3, 0)
                part.Anchored = true
                part.CanCollide = false
                part.Transparency = 0.5
                part.Color = Color3.fromRGB(150, 100, 255)
                part.Parent = workspace
                task.delay(3, function() part:Destroy() end)
            end

            -- Распределяем игроков по партам (клиентская визуализация)
            local index = 0
            for _, player in ipairs(players) do
                index += 1
                if index > 10 then break end
                local targetChar = player.Character
                local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    -- Визуальная заморозка (клиентская)
                    targetRoot.Anchored = true
                    local pos = rootPart.Position + rootPart.CFrame.LookVector * (5 + index * 3) + Vector3.new(0, 3, 0)
                    targetRoot.CFrame = CFrame.lookAt(pos, rootPart.Position)
                end
            end
        end
        task.wait(1)
    end
end)

-- FOV Circle
local FOVCircle = nil
if Drawing and Drawing.new then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = false
    FOVCircle.Thickness = 2
    FOVCircle.Radius = 100
    FOVCircle.Color = Color3.fromRGB(180, 130, 255)
    getgenv().MistePieFOV = FOVCircle
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and FOVCircle then
        local camera = workspace.CurrentCamera
        aimFOV = AimbotFOVSlider.GetValue()
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

-- Улучшенный Aimbot
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

-- Увеличенные хитбоксы (вызываются в цикле)
local function expandHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and player.Character then
            local targetChar = player.Character
            for _, part in ipairs(targetChar:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    if not part:GetAttribute("OriginalSize") then
                        part:SetAttribute("OriginalSize", part.Size)
                    end
                    part.Size = part:GetAttribute("OriginalSize") * hitboxSize
                    part.Transparency = 0.3
                end
            end
        end
    end
end

local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and player.Character then
            local targetChar = player.Character
            for _, part in ipairs(targetChar:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    local origSize = part:GetAttribute("OriginalSize")
                    if origSize then
                        part.Size = origSize
                        part:SetAttribute("OriginalSize", nil)
                    end
                    part.Transparency = 0
                end
            end
        end
    end
end

-- Aimbot + Trigger Bot + Hitboxes
local lastHitboxSize = 1

RunService.RenderStepped:Connect(function(deltaTime)
    aimSpeed = AimbotSpeedSlider.GetValue()
    aimSmooth = AimbotSmoothSlider.GetValue()
    hitboxSize = HitboxSlider.GetValue()

    -- Применяем хитбоксы если размер изменился
    if hitboxSize ~= lastHitboxSize then
        resetHitboxes()
        lastHitboxSize = hitboxSize
        if hitboxSize > 1 then
            expandHitboxes()
        end
    end

    if aimbotEnabled and char and rootPart then
        local target = getClosestInFOV()
        if target then
            local camera = workspace.CurrentCamera
            local targetCFrame = CFrame.lookAt(camera.CFrame.Position, target.Head.Position)

            if aimSpeed >= 20 then
                camera.CFrame = targetCFrame
            else
                local smoothFactor = aimSmooth / 10
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, math.clamp(smoothFactor * deltaTime * 10, 0, 1))
            end

            -- Trigger Bot через VirtualInputManager
            if triggerBotEnabled then
                VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.05)
                VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end
        end
    else
        -- Сбрасываем хитбоксы если аимбот выключен
        if lastHitboxSize > 1 then
            resetHitboxes()
            lastHitboxSize = 1
        end
    end
end)

print("MistePieMenu v8.1 loaded!")
