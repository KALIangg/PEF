local NeonXsx = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CONFIGS
local THEME_COLOR = Color3.fromRGB(180, 0, 0)
local FONT = Enum.Font.GothamBold

-- GUI CONTAINER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonXsxHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- MAIN CONTAINER
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainUI"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 550, 0, 520)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

local mainCorner = Instance.new("UICorner", Main)
mainCorner.CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = THEME_COLOR
mainStroke.Thickness = 2
mainStroke.Transparency = 0.15

-- Layout de elementos
local Layout = Instance.new("UIListLayout", Main)
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- DRAG SYSTEM
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- BACKGROUND PARTICLES
local bgParticles = Instance.new("ParticleEmitter")
bgParticles.Parent = Main
bgParticles.Texture = "rbxassetid://6132524406"
bgParticles.LightEmission = 1
bgParticles.Size = NumberSequence.new(1)
bgParticles.Rate = 60
bgParticles.Lifetime = NumberRange.new(6)
bgParticles.Speed = NumberRange.new(15)
bgParticles.Transparency = NumberSequence.new(0.4)
bgParticles.VelocitySpread = 360
bgParticles.ZOffset = 2
bgParticles.Rotation = NumberRange.new(0, 360)

-- TOGGLE MENU KEY
Main.Visible = true
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		Main.Visible = not Main.Visible
	end
end)


-- UTILS
local function createElement(height)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -20, 0, height)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BorderSizePixel = 0
	frame.Position = UDim2.new(0, 10, 0, 0)

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 8)

	local stroke = Instance.new("UIStroke", frame)
	stroke.Color = THEME_COLOR
	stroke.Thickness = 1

	frame.LayoutOrder = 0

	return frame
end

-- 🟥 TITLE
function NeonXsx:CreateTitle(text)
	local titleFrame = createElement(40)
	titleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	local label = Instance.new("TextLabel", titleFrame)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = THEME_COLOR
	label.Font = FONT
	label.TextScaled = true

	titleFrame.Parent = Main
end

-- 🟨 SECTION
function NeonXsx:CreateSection(name)
	local section = createElement(30)

	local label = Instance.new("TextLabel", section)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.Font = FONT
	label.TextScaled = true

	section.Parent = Main
end

-- 🟦 LABEL
function NeonXsx:CreateLabel(text)
	local labelFrame = createElement(28)
	labelFrame.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", labelFrame)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Font = Enum.Font.Gotham
	label.TextScaled = true

	labelFrame.Parent = Main
end

-- ⚪ DIVIDER
function NeonXsx:CreateDivider()
	local line = Instance.new("Frame", Main)
	line.Size = UDim2.new(1, -20, 0, 2)
	line.Position = UDim2.new(0, 10, 0, 0)
	line.BackgroundColor3 = THEME_COLOR
	line.BorderSizePixel = 0
	line.LayoutOrder = 0
end

-- 🟩 BUTTON
function NeonXsx:CreateButton(name, callback)
	local btnFrame = createElement(35)

	local btn = Instance.new("TextButton", btnFrame)
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = name
	btn.TextColor3 = THEME_COLOR
	btn.Font = FONT
	btn.TextScaled = true

	btn.MouseButton1Click:Connect(callback)

	btnFrame.Parent = Main
end


-- 🟥 TOGGLE
function NeonXsx:CreateToggle(name, callback)
	local toggleFrame = createElement(35)

	local label = Instance.new("TextLabel", toggleFrame)
	label.Size = UDim2.new(0.75, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.Font = FONT
	label.TextScaled = true

	local btn = Instance.new("TextButton", toggleFrame)
	btn.Size = UDim2.new(0.2, 0, 0.6, 0)
	btn.Position = UDim2.new(0.78, 0, 0.2, 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
	btn.Text = "OFF"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = FONT
	btn.TextScaled = true

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	local state = false

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.BackgroundColor3 = state and THEME_COLOR or Color3.fromRGB(50, 0, 0)
		callback(state)
	end)

	toggleFrame.Parent = Main
end

-- 🟦 DROPDOWN
function NeonXsx:CreateDropdown(name, options, default, callback)
	local dropdownFrame = createElement(35)

	local button = Instance.new("TextButton", dropdownFrame)
	button.Size = UDim2.new(1, 0, 1, 0)
	button.BackgroundTransparency = 1
	button.Text = name .. ": " .. default
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = FONT
	button.TextScaled = true

	local current = default

	button.MouseButton1Click:Connect(function()
		local listFrame = Instance.new("Frame", Main)
		listFrame.Size = UDim2.new(1, -20, 0, (#options * 30))
		listFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		listFrame.BorderSizePixel = 0
		listFrame.Position = UDim2.new(0, 10, 0, 0)

		local corner = Instance.new("UICorner", listFrame)
		corner.CornerRadius = UDim.new(0, 8)

		local stroke = Instance.new("UIStroke", listFrame)
		stroke.Color = THEME_COLOR
		stroke.Thickness = 1

		local layout = Instance.new("UIListLayout", listFrame)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 4)

		for _, opt in pairs(options) do
			local optBtn = Instance.new("TextButton", listFrame)
			optBtn.Size = UDim2.new(1, 0, 0, 30)
			optBtn.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
			optBtn.Text = opt
			optBtn.Font = Enum.Font.Gotham
			optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			optBtn.TextScaled = true

			local corner = Instance.new("UICorner", optBtn)
			corner.CornerRadius = UDim.new(0, 8)

			optBtn.MouseButton1Click:Connect(function()
				current = opt
				button.Text = name .. ": " .. current
				callback(current)
				listFrame:Destroy()
			end)
		end
	end)

	dropdownFrame.Parent = Main
end
