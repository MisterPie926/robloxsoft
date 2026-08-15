-- Generated automatically by GUI Dumper
local parent = (gethui and gethui()) or game:GetService('CoreGui') or game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')

local MistePieMenu_7389 = Instance.new("ScreenGui")
MistePieMenu_7389.Name = "MistePieMenu"
MistePieMenu_7389.ResetOnSpawn = true
MistePieMenu_7389.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MistePieMenu_7389.Parent = parent

local LocalScript_7812 = Instance.new("LocalScript")
LocalScript_7812.Name = "LocalScript"
LocalScript_7812.Source = "local gui = script.Parent\nlocal plr = game.Players.LocalPlayer\nlocal UIS = game:GetService(\"UserInputService\")\nlocal RunService = game:GetService(\"RunService\")\nlocal Players = game:GetService(\"Players\")\n\nlocal char = plr.Character or plr.CharacterAdded:Wait()\nlocal hum = char:WaitForChild(\"Humanoid\")\nlocal rootPart = char:WaitForChild(\"HumanoidRootPart\")\n\nlocal mainframe = gui:WaitForChild(\"MainFrame\")\nlocal cheats = mainframe:WaitForChild(\"Cheats\")\n\nlocal fly = cheats:WaitForChild(\"Fly\")\nlocal speed = cheats:WaitForChild(\"Speed\")\nlocal jump = cheats:WaitForChild(\"Jump\")\nlocal noclip = cheats:WaitForChild(\"Noclip\")\nlocal wallhack = cheats:WaitForChild(\"Wallhack\")\nlocal tp = cheats:WaitForChild(\"Teleport\")\nlocal git = mainframe:WaitForChild(\"GitName\")\nlocal url = git:WaitForChild(\"URL\")\nlocal binds = mainframe:WaitForChild(\"TextBox\")\n\nlocal valuespeed = speed:FindFirstChild(\"TextBox\") or speed\nlocal valuejump = jump:FindFirstChild(\"TextBox\") or jump\nlocal valuetp = tp:FindFirstChild(\"TextBox\") or tp\n\n-- Состояния\nlocal flyEnabled = false\nlocal speedEnabled = false\nlocal jumpEnabled = false\nlocal noclipEnabled = false\nlocal wallhackEnabled = false\nlocal panelVisible = false\nmainframe.Visible = false\n-- Список биндов: { {func = \"fly\", key = \"B\"}, {func = \"noclip\", key = \"B\"} }\nlocal bindList = {}\n\n-- Дефолтные значения\nlocal defaultSpeed = 16\nlocal defaultJump = 7.2\n\n-- Функция парсинга биндов (пересобирает весь список из текста)\n-- Функция парсинга биндов (сохраняет старые при неполном вводе)\nlocal function parseBinds()\n	local newBindList = {}\n	local text = binds.Text or \"\"\n\n	for line in text:gmatch(\"[^\\r\\n]+\") do\n		local f, key = line:match(\"%s*(%w+)%s+(%w)%s*\")\n		if f and key then\n			local funcName = f:lower()\n			local keyName = key:upper()\n\n			-- Пропускаем дубликаты пары функция+клавиша\n			local isDuplicate = false\n			for _, bind in ipairs(newBindList) do\n				if bind.func == funcName and bind.key == keyName then\n					isDuplicate = true\n					break\n				end\n			end\n\n			if not isDuplicate then\n				table.insert(newBindList, {func = funcName, key = keyName})\n			end\n		end\n	end\n\n	-- Обновляем bindList только если есть хотя бы одна корректная строка\n	-- или текст пустой (тогда очищаем список)\n	if #newBindList > 0 or text == \"\" then\n		bindList = newBindList\n	end\nend\n\n-- Слушаем изменения текста\nbinds:GetPropertyChangedSignal(\"Text\"):Connect(parseBinds)\n\n-- Парсим сразу при старте\nparseBinds()\n\n-- Парсим только при потере фокуса или нажатии Enter (чтобы не терять при вводе)\nbinds.FocusLost:Connect(function(enterPressed)\n	parseBinds()\nend)\n\n-- Обновление персонажа\nplr.CharacterAdded:Connect(function(newChar)\n	char = newChar\n	hum = char:WaitForChild(\"Humanoid\")\n	rootPart = char:WaitForChild(\"HumanoidRootPart\")\n	defaultSpeed = hum.WalkSpeed\n	defaultJump = hum.JumpPower\n\n	if speedEnabled then\n		hum.WalkSpeed = tonumber(valuespeed.Text) or 50\n	end\n	if jumpEnabled then\n		hum.JumpPower = tonumber(valuejump.Text) or 50\n	end\n	if noclipEnabled then\n		spawn(function()\n			wait(0.5)\n			for _, part in ipairs(char:GetDescendants()) do\n				if part:IsA(\"BasePart\") and part.CanCollide then\n					part.CanCollide = false\n				end\n			end\n		end)\n	end\n	if flyEnabled then\n		hum.PlatformStand = true\n	end\nend)\n\n-- Открытие/закрытие по H\nUIS.InputBegan:Connect(function(input, gameProcessed)\n	if gameProcessed then return end\n	if input.KeyCode == Enum.KeyCode.H then\n		panelVisible = not panelVisible\n		mainframe.Visible = panelVisible\n	end\nend)\n\n-- НОКЛИП\nlocal function toggleNoclip()\n	noclipEnabled = not noclipEnabled\n	noclip.Text = \"Noclip: \" .. (noclipEnabled and \"ON\" or \"OFF\")\nend\n\nnoclip.MouseButton1Click:Connect(toggleNoclip)\n\nRunService.Stepped:Connect(function()\n	if noclipEnabled and char then\n		for _, part in ipairs(char:GetDescendants()) do\n			if part:IsA(\"BasePart\") and part.CanCollide then\n				part.CanCollide = false\n			end\n		end\n	end\nend)\n\n-- ФЛАЙ\nlocal function toggleFly()\n	flyEnabled = not flyEnabled\n	fly.Text = \"Fly: \" .. (flyEnabled and \"ON\" or \"OFF\")\n	if hum then\n		hum.PlatformStand = flyEnabled\n	end\nend\n\nfly.MouseButton1Click:Connect(toggleFly)\n\nRunService.RenderStepped:Connect(function()\n	if flyEnabled and char and hum and rootPart then\n		hum.PlatformStand = true\n		local direction = Vector3.new()\n		local camera = workspace.CurrentCamera\n\n		if UIS:IsKeyDown(Enum.KeyCode.W) then\n			direction = direction + camera.CFrame.LookVector\n		end\n		if UIS:IsKeyDown(Enum.KeyCode.S) then\n			direction = direction - camera.CFrame.LookVector\n		end\n		if UIS:IsKeyDown(Enum.KeyCode.A) then\n			direction = direction - camera.CFrame.RightVector\n		end\n		if UIS:IsKeyDown(Enum.KeyCode.D) then\n			direction = direction + camera.CFrame.RightVector\n		end\n		if UIS:IsKeyDown(Enum.KeyCode.Space) then\n			direction = direction + Vector3.new(0, 1, 0)\n		end\n		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then\n			direction = direction - Vector3.new(0, 1, 0)\n		end\n\n		if direction.Magnitude > 0 then\n			direction = direction.Unit\n		end\n\n		rootPart.Velocity = direction * 50\n	end\nend)\n\n-- СПИД\nlocal function toggleSpeed()\n	speedEnabled = not speedEnabled\n	speed.Text = \"Speed: \" .. (speedEnabled and \"ON\" or \"OFF\")\n	if hum then\n		if speedEnabled then\n			hum.WalkSpeed = tonumber(valuespeed.Text) or 50\n		else\n			hum.WalkSpeed = defaultSpeed\n		end\n	end\nend\n\nspeed.MouseButton1Click:Connect(toggleSpeed)\n\n-- ПРЫЖОК\nlocal function toggleJump()\n	jumpEnabled = not jumpEnabled\n	jump.Text = \"Jump: \" .. (jumpEnabled and \"ON\" or \"OFF\")\n	if hum then\n		if jumpEnabled then\n			hum.JumpPower = tonumber(valuejump.Text) or 50\n		else\n			hum.JumpPower = defaultJump\n		end\n	end\nend\n\njump.MouseButton1Click:Connect(toggleJump)\n\n-- ТЕЛЕПОРТ (исправлен)\nlocal function teleportToPosition(x, y, z)\n	if not char or not hum or not rootPart then return end\n\n	local targetPos = Vector3.new(tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0)\n\n	-- Метод 1: Прямая установка CFrame\n	rootPart.CFrame = CFrame.new(targetPos)\n\n	-- Метод 2: Через MoveTo\n	hum:MoveTo(targetPos)\n\n	-- Метод 3: Через Velocity (обход некоторых античитов)\n	rootPart.Velocity = Vector3.new(0, 0, 0)\n	rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)\n\n	-- Метод 4: Через PivotTo (для новых версий)\n	if rootPart.PivotTo then\n		rootPart:PivotTo(CFrame.new(targetPos))\n	end\nend\n\n-- Телепорт при нажатии Enter в поле\nvaluetp.FocusLost:Connect(function(enterPressed)\n	if enterPressed then\n		local coords = valuetp.Text\n		local x, y, z = coords:match(\"([%d.-]+)%s*,%s*([%d.-]+)%s*,%s*([%d.-]+)\")\n		if x and y and z then\n			teleportToPosition(x, y, z)\n			print(\"Teleported to:\", x, y, z)\n		else\n			print(\"Invalid coordinates format. Use: x, y, z\")\n		end\n	end\nend)\n\n-- WALLHACK\nlocal function toggleWallhack()\n	wallhackEnabled = not wallhackEnabled\n	wallhack.Text = \"Wallhack: \" .. (wallhackEnabled and \"ON\" or \"OFF\")\nend\n\nwallhack.MouseButton1Click:Connect(toggleWallhack)\n\nspawn(function()\n	while true do\n		if wallhackEnabled then\n			for _, player in ipairs(Players:GetPlayers()) do\n				if player ~= plr then\n					local targetChar = player.Character\n					if targetChar then\n						local highlight = targetChar:FindFirstChild(\"WallhackHighlight\")\n						if not highlight then\n							highlight = Instance.new(\"Highlight\")\n							highlight.Name = \"WallhackHighlight\"\n							highlight.FillTransparency = 0.7\n							highlight.OutlineColor = Color3.fromRGB(255, 0, 0)\n							highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop\n							highlight.Parent = targetChar\n						end\n					end\n				end\n			end\n		else\n			for _, player in ipairs(Players:GetPlayers()) do\n				local targetChar = player.Character\n				if targetChar then\n					local highlight = targetChar:FindFirstChild(\"WallhackHighlight\")\n					if highlight then\n						highlight:Destroy()\n					end\n				end\n			end\n		end\n		wait(1)\n	end\nend)\n\n-- Копирование ссылки\nlocal function copyGitLink()\n	local originalText = git.Text\n	local link = url.Value\n\n	if syn and syn.write_clipboard then\n		syn.write_clipboard(link)\n	elseif setclipboard then\n		setclipboard(link)\n	end\n\n	git.Text = \"COPY\"\n\n	spawn(function()\n		wait(3)\n		git.Text = originalText\n	end)\nend\n\ngit.MouseButton1Click:Connect(copyGitLink)\n\n-- Обработка биндов (поддержка нескольких функций на одну клавишу)\nUIS.InputBegan:Connect(function(input, gameProcessed)\n	if gameProcessed then return end\n\n	local keyPressed = input.KeyCode\n\n	for _, bind in ipairs(bindList) do\n		if keyPressed == Enum.KeyCode[bind.key] then\n			if bind.func == \"fly\" then\n				toggleFly()\n			elseif bind.func == \"noclip\" then\n				toggleNoclip()\n			elseif bind.func == \"speed\" then\n				toggleSpeed()\n			elseif bind.func == \"jump\" then\n				toggleJump()\n			end\n		end\n	end\nend)\n\nprint(\"MistePieMenu loaded successfully\")\nprint(\"Binds:\", bindList)"
LocalScript_7812.Parent = MistePieMenu_7389

local MainFrame_5702 = Instance.new("Frame")
MainFrame_5702.Name = "MainFrame"
MainFrame_5702.Position = UDim2.new(0.35069161653518677, 0, 0.0914454311132431, 0)
MainFrame_5702.Size = UDim2.new(0, 503, 0, 584)
MainFrame_5702.AnchorPoint = Vector2.new(0, 0)
MainFrame_5702.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
MainFrame_5702.BackgroundTransparency = 0.5
MainFrame_5702.BorderSizePixel = 0
MainFrame_5702.Visible = true
MainFrame_5702.ZIndex = 1
MainFrame_5702.Parent = MistePieMenu_7389

local UICorner_4479 = Instance.new("UICorner")
UICorner_4479.Name = "UICorner"
UICorner_4479.CornerRadius = UDim.new(0, 8)
UICorner_4479.Parent = MainFrame_5702

local UIStroke_8117 = Instance.new("UIStroke")
UIStroke_8117.Name = "UIStroke"
UIStroke_8117.Parent = MainFrame_5702

local Cheats_1212 = Instance.new("Folder")
Cheats_1212.Name = "Cheats"
Cheats_1212.Parent = MainFrame_5702

local Teleport_7374 = Instance.new("TextButton")
Teleport_7374.Name = "Teleport"
Teleport_7374.Position = UDim2.new(0.28827038407325745, 0, 0.48630136251449585, 0)
Teleport_7374.Size = UDim2.new(0, 76, 0, 67)
Teleport_7374.AnchorPoint = Vector2.new(0, 0)
Teleport_7374.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Teleport_7374.BackgroundTransparency = 0
Teleport_7374.BorderSizePixel = 0
Teleport_7374.Visible = true
Teleport_7374.ZIndex = 1
Teleport_7374.Text = "Teleport. Write xyz coord"
Teleport_7374.TextColor3 = Color3.fromRGB(0, 0, 0)
Teleport_7374.TextSize = 14
Teleport_7374.Font = Enum.Font.SourceSans
Teleport_7374.TextScaled = true
Teleport_7374.TextXAlignment = Enum.TextXAlignment.Center
Teleport_7374.TextYAlignment = Enum.TextYAlignment.Center
Teleport_7374.Parent = Cheats_1212

local UIStroke_6288 = Instance.new("UIStroke")
UIStroke_6288.Name = "UIStroke"
UIStroke_6288.Parent = Teleport_7374

local UICorner_8010 = Instance.new("UICorner")
UICorner_8010.Name = "UICorner"
UICorner_8010.CornerRadius = UDim.new(0, 12)
UICorner_8010.Parent = Teleport_7374

local TextBox_5122 = Instance.new("TextBox")
TextBox_5122.Name = "TextBox"
TextBox_5122.Position = UDim2.new(1.236842155456543, 0, 0, 0)
TextBox_5122.Size = UDim2.new(0, 199, 0, 67)
TextBox_5122.AnchorPoint = Vector2.new(0, 0)
TextBox_5122.BackgroundColor3 = Color3.fromRGB(255, 85, 255)
TextBox_5122.BackgroundTransparency = 0
TextBox_5122.BorderSizePixel = 0
TextBox_5122.Visible = true
TextBox_5122.ZIndex = 1
TextBox_5122.Text = "HERE WRITE"
TextBox_5122.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox_5122.TextSize = 14
TextBox_5122.Font = Enum.Font.SourceSans
TextBox_5122.TextScaled = true
TextBox_5122.TextXAlignment = Enum.TextXAlignment.Center
TextBox_5122.TextYAlignment = Enum.TextYAlignment.Center
TextBox_5122.Parent = Teleport_7374

local UIStroke_4501 = Instance.new("UIStroke")
UIStroke_4501.Name = "UIStroke"
UIStroke_4501.Parent = TextBox_5122

local UICorner_4456 = Instance.new("UICorner")
UICorner_4456.Name = "UICorner"
UICorner_4456.CornerRadius = UDim.new(0, 12)
UICorner_4456.Parent = TextBox_5122

local Jump_7303 = Instance.new("TextButton")
Jump_7303.Name = "Jump"
Jump_7303.Position = UDim2.new(0.28827038407325745, 0, 0.2791095972061157, 0)
Jump_7303.Size = UDim2.new(0, 76, 0, 67)
Jump_7303.AnchorPoint = Vector2.new(0, 0)
Jump_7303.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Jump_7303.BackgroundTransparency = 0
Jump_7303.BorderSizePixel = 0
Jump_7303.Visible = true
Jump_7303.ZIndex = 1
Jump_7303.Text = "Speed. Write int for speed and click this but"
Jump_7303.TextColor3 = Color3.fromRGB(0, 0, 0)
Jump_7303.TextSize = 14
Jump_7303.Font = Enum.Font.SourceSans
Jump_7303.TextScaled = true
Jump_7303.TextXAlignment = Enum.TextXAlignment.Center
Jump_7303.TextYAlignment = Enum.TextYAlignment.Center
Jump_7303.Parent = Cheats_1212

local UIStroke_8897 = Instance.new("UIStroke")
UIStroke_8897.Name = "UIStroke"
UIStroke_8897.Parent = Jump_7303

local UICorner_8450 = Instance.new("UICorner")
UICorner_8450.Name = "UICorner"
UICorner_8450.CornerRadius = UDim.new(0, 12)
UICorner_8450.Parent = Jump_7303

local TextBox_3517 = Instance.new("TextBox")
TextBox_3517.Name = "TextBox"
TextBox_3517.Position = UDim2.new(1.236842155456543, 0, 0, 0)
TextBox_3517.Size = UDim2.new(0, 199, 0, 67)
TextBox_3517.AnchorPoint = Vector2.new(0, 0)
TextBox_3517.BackgroundColor3 = Color3.fromRGB(255, 85, 255)
TextBox_3517.BackgroundTransparency = 0
TextBox_3517.BorderSizePixel = 0
TextBox_3517.Visible = true
TextBox_3517.ZIndex = 1
TextBox_3517.Text = "HERE WRITE"
TextBox_3517.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox_3517.TextSize = 14
TextBox_3517.Font = Enum.Font.SourceSans
TextBox_3517.TextScaled = true
TextBox_3517.TextXAlignment = Enum.TextXAlignment.Center
TextBox_3517.TextYAlignment = Enum.TextYAlignment.Center
TextBox_3517.Parent = Jump_7303

local UIStroke_8813 = Instance.new("UIStroke")
UIStroke_8813.Name = "UIStroke"
UIStroke_8813.Parent = TextBox_3517

local UICorner_6604 = Instance.new("UICorner")
UICorner_6604.Name = "UICorner"
UICorner_6604.CornerRadius = UDim.new(0, 12)
UICorner_6604.Parent = TextBox_3517

local Speed_9185 = Instance.new("TextButton")
Speed_9185.Name = "Speed"
Speed_9185.Position = UDim2.new(0.28827038407325745, 0, 0.125, 0)
Speed_9185.Size = UDim2.new(0, 76, 0, 67)
Speed_9185.AnchorPoint = Vector2.new(0, 0)
Speed_9185.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Speed_9185.BackgroundTransparency = 0
Speed_9185.BorderSizePixel = 0
Speed_9185.Visible = true
Speed_9185.ZIndex = 1
Speed_9185.Text = "Speed. Write int for speed and click this but"
Speed_9185.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed_9185.TextSize = 14
Speed_9185.Font = Enum.Font.SourceSans
Speed_9185.TextScaled = true
Speed_9185.TextXAlignment = Enum.TextXAlignment.Center
Speed_9185.TextYAlignment = Enum.TextYAlignment.Center
Speed_9185.Parent = Cheats_1212

local UIStroke_7967 = Instance.new("UIStroke")
UIStroke_7967.Name = "UIStroke"
UIStroke_7967.Parent = Speed_9185

local UICorner_2117 = Instance.new("UICorner")
UICorner_2117.Name = "UICorner"
UICorner_2117.CornerRadius = UDim.new(0, 12)
UICorner_2117.Parent = Speed_9185

local TextBox_7831 = Instance.new("TextBox")
TextBox_7831.Name = "TextBox"
TextBox_7831.Position = UDim2.new(1.236842155456543, 0, 0, 0)
TextBox_7831.Size = UDim2.new(0, 199, 0, 67)
TextBox_7831.AnchorPoint = Vector2.new(0, 0)
TextBox_7831.BackgroundColor3 = Color3.fromRGB(255, 85, 255)
TextBox_7831.BackgroundTransparency = 0
TextBox_7831.BorderSizePixel = 0
TextBox_7831.Visible = true
TextBox_7831.ZIndex = 1
TextBox_7831.Text = "HERE WRITE"
TextBox_7831.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox_7831.TextSize = 14
TextBox_7831.Font = Enum.Font.SourceSans
TextBox_7831.TextScaled = true
TextBox_7831.TextXAlignment = Enum.TextXAlignment.Center
TextBox_7831.TextYAlignment = Enum.TextYAlignment.Center
TextBox_7831.Parent = Speed_9185

local UIStroke_1100 = Instance.new("UIStroke")
UIStroke_1100.Name = "UIStroke"
UIStroke_1100.Parent = TextBox_7831

local UICorner_1520 = Instance.new("UICorner")
UICorner_1520.Name = "UICorner"
UICorner_1520.CornerRadius = UDim.new(0, 12)
UICorner_1520.Parent = TextBox_7831

local Wallhack_8692 = Instance.new("TextButton")
Wallhack_8692.Name = "Wallhack"
Wallhack_8692.Position = UDim2.new(0.021868787705898285, 0, 0.48630136251449585, 0)
Wallhack_8692.Size = UDim2.new(0, 76, 0, 67)
Wallhack_8692.AnchorPoint = Vector2.new(0, 0)
Wallhack_8692.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Wallhack_8692.BackgroundTransparency = 0
Wallhack_8692.BorderSizePixel = 0
Wallhack_8692.Visible = true
Wallhack_8692.ZIndex = 1
Wallhack_8692.Text = "Wallhack "
Wallhack_8692.TextColor3 = Color3.fromRGB(0, 0, 0)
Wallhack_8692.TextSize = 14
Wallhack_8692.Font = Enum.Font.SourceSans
Wallhack_8692.TextScaled = true
Wallhack_8692.TextXAlignment = Enum.TextXAlignment.Center
Wallhack_8692.TextYAlignment = Enum.TextYAlignment.Center
Wallhack_8692.Parent = Cheats_1212

local UIStroke_7946 = Instance.new("UIStroke")
UIStroke_7946.Name = "UIStroke"
UIStroke_7946.Parent = Wallhack_8692

local UICorner_6994 = Instance.new("UICorner")
UICorner_6994.Name = "UICorner"
UICorner_6994.CornerRadius = UDim.new(0, 12)
UICorner_6994.Parent = Wallhack_8692

local Fly_7282 = Instance.new("TextButton")
Fly_7282.Name = "Fly"
Fly_7282.Position = UDim2.new(0.021868787705898285, 0, 0.125, 0)
Fly_7282.Size = UDim2.new(0, 76, 0, 67)
Fly_7282.AnchorPoint = Vector2.new(0, 0)
Fly_7282.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Fly_7282.BackgroundTransparency = 0
Fly_7282.BorderSizePixel = 0
Fly_7282.Visible = true
Fly_7282.ZIndex = 1
Fly_7282.Text = "FLY"
Fly_7282.TextColor3 = Color3.fromRGB(0, 0, 0)
Fly_7282.TextSize = 14
Fly_7282.Font = Enum.Font.SourceSans
Fly_7282.TextScaled = true
Fly_7282.TextXAlignment = Enum.TextXAlignment.Center
Fly_7282.TextYAlignment = Enum.TextYAlignment.Center
Fly_7282.Parent = Cheats_1212

local UIStroke_8052 = Instance.new("UIStroke")
UIStroke_8052.Name = "UIStroke"
UIStroke_8052.Parent = Fly_7282

local UICorner_9428 = Instance.new("UICorner")
UICorner_9428.Name = "UICorner"
UICorner_9428.CornerRadius = UDim.new(0, 12)
UICorner_9428.Parent = Fly_7282

local Noclip_2903 = Instance.new("TextButton")
Noclip_2903.Name = "Noclip"
Noclip_2903.Position = UDim2.new(0.021868787705898285, 0, 0.29965752363204956, 0)
Noclip_2903.Size = UDim2.new(0, 76, 0, 67)
Noclip_2903.AnchorPoint = Vector2.new(0, 0)
Noclip_2903.BackgroundColor3 = Color3.fromRGB(170, 170, 255)
Noclip_2903.BackgroundTransparency = 0
Noclip_2903.BorderSizePixel = 0
Noclip_2903.Visible = true
Noclip_2903.ZIndex = 1
Noclip_2903.Text = "Noclip"
Noclip_2903.TextColor3 = Color3.fromRGB(0, 0, 0)
Noclip_2903.TextSize = 14
Noclip_2903.Font = Enum.Font.SourceSans
Noclip_2903.TextScaled = true
Noclip_2903.TextXAlignment = Enum.TextXAlignment.Center
Noclip_2903.TextYAlignment = Enum.TextYAlignment.Center
Noclip_2903.Parent = Cheats_1212

local UIStroke_2394 = Instance.new("UIStroke")
UIStroke_2394.Name = "UIStroke"
UIStroke_2394.Parent = Noclip_2903

local UICorner_6607 = Instance.new("UICorner")
UICorner_6607.Name = "UICorner"
UICorner_6607.CornerRadius = UDim.new(0, 12)
UICorner_6607.Parent = Noclip_2903

local TextBox_4877 = Instance.new("TextBox")
TextBox_4877.Name = "TextBox"
TextBox_4877.Position = UDim2.new(0.049701787531375885, 0, 0.6678082346916199, 0)
TextBox_4877.Size = UDim2.new(0, 452, 0, 147)
TextBox_4877.AnchorPoint = Vector2.new(0, 0)
TextBox_4877.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
TextBox_4877.BackgroundTransparency = 0.5
TextBox_4877.BorderSizePixel = 0
TextBox_4877.Visible = true
TextBox_4877.ZIndex = 1
TextBox_4877.Text = "Write funcrion and bind. Primer: Fly B"
TextBox_4877.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox_4877.TextSize = 14
TextBox_4877.Font = Enum.Font.SourceSans
TextBox_4877.TextScaled = true
TextBox_4877.TextXAlignment = Enum.TextXAlignment.Center
TextBox_4877.TextYAlignment = Enum.TextYAlignment.Center
TextBox_4877.Parent = MainFrame_5702

local UICorner_3466 = Instance.new("UICorner")
UICorner_3466.Name = "UICorner"
UICorner_3466.CornerRadius = UDim.new(0, 8)
UICorner_3466.Parent = TextBox_4877

local UIStroke_3133 = Instance.new("UIStroke")
UIStroke_3133.Name = "UIStroke"
UIStroke_3133.Parent = TextBox_4877

local GitName_9994 = Instance.new("TextButton")
GitName_9994.Name = "GitName"
GitName_9994.Position = UDim2.new(0, 0, 0, 0)
GitName_9994.Size = UDim2.new(0, 503, 0, 38)
GitName_9994.AnchorPoint = Vector2.new(0, 0)
GitName_9994.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
GitName_9994.BackgroundTransparency = 0
GitName_9994.BorderSizePixel = 0
GitName_9994.Visible = true
GitName_9994.ZIndex = 1
GitName_9994.Text = "MENY BY: GITHUB MisterPie926"
GitName_9994.TextColor3 = Color3.fromRGB(0, 0, 0)
GitName_9994.TextSize = 14
GitName_9994.Font = Enum.Font.SourceSans
GitName_9994.TextScaled = true
GitName_9994.TextXAlignment = Enum.TextXAlignment.Center
GitName_9994.TextYAlignment = Enum.TextYAlignment.Center
GitName_9994.Parent = MainFrame_5702

local UICorner_3042 = Instance.new("UICorner")
UICorner_3042.Name = "UICorner"
UICorner_3042.CornerRadius = UDim.new(0, 8)
UICorner_3042.Parent = GitName_9994

local URL_9636 = Instance.new("StringValue")
URL_9636.Name = "URL"
URL_9636.Parent = GitName_9994
