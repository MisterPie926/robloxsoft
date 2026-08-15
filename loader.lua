-- Loader for MistePieMenu with LocalScript inside GUI

local parent = (gethui and gethui()) or game:GetService('CoreGui') or game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')

if parent:FindFirstChild("MistePieMenu") then
    parent.MistePieMenu:Destroy()
end

-- 1. Создание ScreenGui
local MistePieMenu = Instance.new("ScreenGui")
MistePieMenu.Name = "MistePieMenu"
MistePieMenu.ResetOnSpawn = true
MistePieMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MistePieMenu.Parent = parent

-- 2. Создание физического объекта LocalScript внутри ScreenGui
local LocalScript = Instance.new("LocalScript")
LocalScript.Name = "LocalScript"
LocalScript.Parent = MistePieMenu

-- 3. Создание UI элементов
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.3506916, 0, 0.0914454, 0)
MainFrame.Size = UDim2.new(0, 503, 0, 584)
MainFrame.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.ZIndex = 1
MainFrame.Parent = MistePieMenu

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.Parent = MainFrame

local Cheats = Instance.new("Folder")
Cheats.Name = "Cheats"
Cheats.Parent = MainFrame

local function createBtn(name, text, pos, parentObj)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Position = pos
    btn.Size = UDim2.new(0, 76, 0, 67)
    btn.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true
    btn.Parent = parentObj

    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    return btn
end

local function createBox(name, text, pos, parentObj)
    local tb = Instance.new("TextBox")
    tb.Name = name
    tb.Position = pos
    tb.Size = UDim2.new(0, 199, 0, 67)
    tb.BackgroundColor3 = Color3.fromRGB(255, 85, 255)
    tb.BorderSizePixel = 0
    tb.Text = text
    tb.TextColor3 = Color3.fromRGB(0, 0, 0)
    tb.TextSize = 14
    tb.Font = Enum.Font.SourceSans
    tb.TextScaled = true
    tb.Parent = parentObj

    local stroke = Instance.new("UIStroke")
    stroke.Parent = tb

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = tb
    return tb
end

local Teleport = createBtn("Teleport", "Teleport. Write xyz coord", UDim2.new(0.2882703, 0, 0.4863013, 0), Cheats)
local TeleportBox = createBox("TextBox", "HERE WRITE", UDim2.new(1.236842, 0, 0, 0), Teleport)

local Jump = createBtn("Jump", "Speed. Write int for speed and click this but", UDim2.new(0.2882703, 0, 0.2791095, 0), Cheats)
local JumpBox = createBox("TextBox", "HERE WRITE", UDim2.new(1.236842, 0, 0, 0), Jump)

local Speed = createBtn("Speed", "Speed. Write int for speed and click this but", UDim2.new(0.2882703, 0, 0.125, 0), Cheats)
local SpeedBox = createBox("TextBox", "HERE WRITE", UDim2.new(1.236842, 0, 0, 0), Speed)

local Wallhack = createBtn("Wallhack", "Wallhack ", UDim2.new(0.0218687, 0, 0.4863013, 0), Cheats)
local Fly = createBtn("Fly", "FLY", UDim2.new(0.0218687, 0, 0.125, 0), Cheats)
local Noclip = createBtn("Noclip", "Noclip", UDim2.new(0.0218687, 0, 0.2996575, 0), Cheats)

local BindsBox = Instance.new("TextBox")
BindsBox.Name = "TextBox"
BindsBox.Position = UDim2.new(0.0497017, 0, 0.6678082, 0)
BindsBox.Size = UDim2.new(0, 452, 0, 147)
BindsBox.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
BindsBox.BackgroundTransparency = 0.5
BindsBox.Text = "Write funcrion and bind. Primer: Fly B"
BindsBox.TextColor3 = Color3.fromRGB(0, 0, 0)
BindsBox.TextSize = 14
BindsBox.Font = Enum.Font.SourceSans
BindsBox.TextScaled = true
BindsBox.Parent = MainFrame

local BindsCorner = Instance.new("UICorner")
BindsCorner.CornerRadius = UDim.new(0, 8)
BindsCorner.Parent = BindsBox

local GitName = createBtn("GitName", "MENY BY: GITHUB MisterPie926", UDim2.new(0, 0, 0, 0), MainFrame)
GitName.Size = UDim2.new(0, 503, 0, 38)
GitName.BackgroundColor3 = Color3.fromRGB(95, 95, 95)

local URL = Instance.new("StringValue")
URL.Name = "URL"
URL.Value = "https://github.com/MisterPie926"
URL.Parent = GitName

-- 4. Исходный код LocalScript
local scriptSource = [[
local script = ...
local gui = script.Parent
local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

local mainframe = gui:WaitForChild("MainFrame")
local cheats = mainframe:WaitForChild("Cheats")

local fly = cheats:WaitForChild("Fly")
local speed = cheats:WaitForChild("Speed")
local jump = cheats:WaitForChild("Jump")
local noclip = cheats:WaitForChild("Noclip")
local wallhack = cheats:WaitForChild("Wallhack")
local tp = cheats:WaitForChild("Teleport")
local git = mainframe:WaitForChild("GitName")
local url = git:WaitForChild("URL")
local binds = mainframe:WaitForChild("TextBox")

local valuespeed = speed:FindFirstChild("TextBox") or speed
local valuejump = jump:FindFirstChild("TextBox") or jump
local valuetp = tp:FindFirstChild("TextBox") or tp

local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local wallhackEnabled = false
local panelVisible = false
mainframe.Visible = false

local bindList = {}
local defaultSpeed = 16
local defaultJump = 7.2

local function parseBinds()
	local newBindList = {}
	local text = binds.Text or ""
	for line in text:gmatch("[^\r\n]+") do
		local f, key = line:match("%s*(%w+)%s+(%w)%s*")
		if f and key then
			local funcName = f:lower()
			local keyName = key:upper()
			local isDuplicate = false
			for _, bind in ipairs(newBindList) do
				if bind.func == funcName and bind.key == keyName then
					isDuplicate = true
					break
				end
			end
			if not isDuplicate then
				table.insert(newBindList, {func = funcName, key = keyName})
			end
		end
	end
	if #newBindList > 0 or text == "" then
		bindList = newBindList
	end
end

binds:GetPropertyChangedSignal("Text"):Connect(parseBinds)
parseBinds()

binds.FocusLost:Connect(function(enterPressed)
	parseBinds()
end)

plr.CharacterAdded:Connect(function(newChar)
	char = newChar
	hum = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
	defaultSpeed = hum.WalkSpeed
	defaultJump = hum.JumpPower

	if speedEnabled then hum.WalkSpeed = tonumber(valuespeed.Text) or 50 end
	if jumpEnabled then hum.JumpPower = tonumber(valuejump.Text) or 50 end
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
	if flyEnabled then hum.PlatformStand = true end
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.H then
		panelVisible = not panelVisible
		mainframe.Visible = panelVisible
	end
end)

local function toggleNoclip()
	noclipEnabled = not noclipEnabled
	noclip.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
end
noclip.MouseButton1Click:Connect(toggleNoclip)

RunService.Stepped:Connect(function()
	if noclipEnabled and char then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

local function toggleFly()
	flyEnabled = not flyEnabled
	fly.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
	if hum then hum.PlatformStand = flyEnabled end
end
fly.MouseButton1Click:Connect(toggleFly)

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

local function toggleSpeed()
	speedEnabled = not speedEnabled
	speed.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
	if hum then
		hum.WalkSpeed = speedEnabled and (tonumber(valuespeed.Text) or 50) or defaultSpeed
	end
end
speed.MouseButton1Click:Connect(toggleSpeed)

local function toggleJump()
	jumpEnabled = not jumpEnabled
	jump.Text = "Jump: " .. (jumpEnabled and "ON" or "OFF")
	if hum then
		hum.JumpPower = jumpEnabled and (tonumber(valuejump.Text) or 50) or defaultJump
	end
end
jump.MouseButton1Click:Connect(toggleJump)

local function teleportToPosition(x, y, z)
	if not char or not hum or not rootPart then return end
	local targetPos = Vector3.new(tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0)
	rootPart.CFrame = CFrame.new(targetPos)
end

valuetp.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local coords = valuetp.Text
		local x, y, z = coords:match("([%d.-]+)%s*,%s*([%d.-]+)%s*,%s*([%d.-]+)")
		if x and y and z then
			teleportToPosition(x, y, z)
		end
	end
end)

local function toggleWallhack()
	wallhackEnabled = not wallhackEnabled
	wallhack.Text = "Wallhack: " .. (wallhackEnabled and "ON" or "OFF")
end
wallhack.MouseButton1Click:Connect(toggleWallhack)

task.spawn(function()
	while true do
		if wallhackEnabled then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= plr and player.Character then
					local highlight = player.Character:FindFirstChild("WallhackHighlight") or Instance.new("Highlight")
					highlight.Name = "WallhackHighlight"
					highlight.FillTransparency = 0.7
					highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
					highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					highlight.Parent = player.Character
				end
			end
		else
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Character and player.Character:FindFirstChild("WallhackHighlight") then
					player.Character.WallhackHighlight:Destroy()
				end
			end
		end
		task.wait(1)
	end
end)

git.MouseButton1Click:Connect(function()
	local link = url.Value
	if setclipboard then setclipboard(link) end
	git.Text = "COPIED!"
	task.delay(2, function() git.Text = "MENY BY: GITHUB MisterPie926" end)
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	for _, bind in ipairs(bindList) do
		if input.KeyCode == Enum.KeyCode[bind.key] then
			if bind.func == "fly" then toggleFly()
			elseif bind.func == "noclip" then toggleNoclip()
			elseif bind.func == "speed" then toggleSpeed()
			elseif bind.func == "jump" then toggleJump()
			end
		end
	end
end)

print("MistePieMenu loaded inside LocalScript!")
]]

-- Присваиваем текстам свойство Source и запускаем исполнение с передачей 'LocalScript'
LocalScript.Source = scriptSource
task.spawn(loadstring(scriptSource), LocalScript)
