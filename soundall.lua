-- ID do som
local soundId = "rbxassetid://9125557781"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:FindFirstChild("PlayAudio")

if not remote then
	warn("⚠️ Remote PlayAudio não encontrado!")
	return
end

-- Criar GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LuaGodSoundControl"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Toggle botão
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 180, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "🔊 TOCAR SOM"
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.Parent = frame

-- X botão
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = frame

-- Lógica do botão toggle
local active = false

toggleButton.MouseButton1Click:Connect(function()
	active = not active
	if active then
		toggleButton.Text = "🛑 PARAR SOM"
		pcall(function()
			remote:FireServer(soundId)
		end)
	else
		toggleButton.Text = "🔊 TOCAR SOM"
		-- Parar todos os sons client-side
		for _, obj in ipairs(game:GetDescendants()) do
			if obj:IsA("Sound") and obj.SoundId == soundId then
				pcall(function()
					obj:Stop()
					obj.Looped = false
					obj.Volume = 0
				end)
			end
		end
	end
end)

-- Lógica do botão X
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)
