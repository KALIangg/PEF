local remote = game:GetService("ReplicatedStorage"):FindFirstChild("PlayAudio")
local soundId = "rbxassetid://9125557781"
local lp = game:GetService("Players").LocalPlayer

local payloads = {
	nil,
	soundId,
	{soundId},
	{["SoundId"] = soundId},
	{["Sound"] = soundId},
	lp
}

for i, payload in ipairs(payloads) do
	print("🔥 Tentando Payload ["..i.."]")
	pcall(function()
		remote:FireServer(payload)
	end)
	wait(0.3)
end
