local NeonHub = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ⚙️ SETTINGS
local THEME_COLOR = Color3.fromRGB(200, 20, 20)
local BG_GRADIENT = ColorSequence.new{
   ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 0)),
   ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0))
}

-- 📦 CONTAINER
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NeonHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 500)
MainFrame.Name = "MainFrame"
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = THEME_COLOR
UIStroke.Thickness = 2
UIStroke.Transparency = 0.1

-- ✨ BACKGROUND ANIMADO
local ParticleEmitter = Instance.new("ParticleEmitter")
ParticleEmitter.Parent = MainFrame
ParticleEmitter.Texture = "rbxassetid://6132524406"
ParticleEmitter.Rate = 50
ParticleEmitter.Lifetime = NumberRange.new(5, 7)
ParticleEmitter.Size = NumberSequence.new(1)
ParticleEmitter.Speed = NumberRange.new(10)
ParticleEmitter.VelocitySpread = 360
ParticleEmitter.LightEmission = 1
ParticleEmitter.Transparency = NumberSequence.new(0.5)
ParticleEmitter.ZOffset = 1
ParticleEmitter.Rotation = NumberRange.new(0, 360)

-- 🔻 LAYOUT
local UIListLayout = Instance.new("UIListLayout", MainFrame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createBaseElement(name, height)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.BorderSizePixel = 0
	frame.Size = UDim2.new(1, -20, 0, height or 40)
	frame.Parent = MainFrame
	frame.BackgroundTransparency = 0.1

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 10)

	local stroke = Instance.new("UIStroke", frame)
	stroke.Color = THEME_COLOR
	stroke.Thickness = 1

	return frame
end

function NeonHub:CreateTitle(text)
	local title = createBaseElement("Title", 40)
	local label = Instance.new("TextLabel", title)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = text
	label.TextColor3 = THEME_COLOR
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextSize = 22
end

function NeonHub:CreateSection(name)
	local sec = createBaseElement(name, 30)
	local label = Instance.new("TextLabel", sec)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = name
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 18
end

function NeonHub:CreateLabel(text)
	local lbl = createBaseElement("Label", 30)
	local txt = Instance.new("TextLabel", lbl)
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.Text = text
	txt.TextColor3 = Color3.fromRGB(220, 220, 220)
	txt.BackgroundTransparency = 1
	txt.Font = Enum.Font.Gotham
	txt.TextSize = 16
end

function NeonHub:CreateButton(name, callback)
	local btn = createBaseElement("Button", 35)
	local b = Instance.new("TextButton", btn)
	b.Size = UDim2.new(1, 0, 1, 0)
	b.Text = name
	b.BackgroundTransparency = 1
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = THEME_COLOR
	b.TextSize = 18
	b.MouseButton1Click:Connect(callback)
end

function NeonHub:CreateToggle(name, callback)
	local toggle = createBaseElement("Toggle", 35)
	local text = Instance.new("TextLabel", toggle)
	text.Size = UDim2.new(0.8, 0, 1, 0)
	text.Text = name
	text.TextColor3 = Color3.fromRGB(200, 200, 200)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.Gotham
	text.TextSize = 16

	local btn = Instance.new("TextButton", toggle)
	btn.Position = UDim2.new(0.85, 0, 0.2, 0)
	btn.Size = UDim2.new(0.1, 0, 0.6, 0)
	btn.Text = "OFF"
	btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	local state = false

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.BackgroundColor3 = state and THEME_COLOR or Color3.fromRGB(50, 0, 0)
		callback(state)
	end)
end

function NeonHub:CreateDropdown(name, options, default, callback)
	local drop = createBaseElement("Dropdown", 35)
	local dropdown = Instance.new("TextButton", drop)
	dropdown.Size = UDim2.new(1, 0, 1, 0)
	dropdown.Text = name .. ": " .. default
	dropdown.BackgroundTransparency = 1
	dropdown.Font = Enum.Font.Gotham
	dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
	dropdown.TextSize = 16

	local current = default

	dropdown.MouseButton1Click:Connect(function()
		local choice = options[math.random(1, #options)]
		current = choice
		dropdown.Text = name .. ": " .. choice
		callback(choice)
	end)
end

function NeonHub:CreateDivider()
	local div = Instance.new("Frame", MainFrame)
	div.Size = UDim2.new(1, -20, 0, 2)
	div.BackgroundColor3 = THEME_COLOR
	div.BorderSizePixel = 0
end

return NeonHub
