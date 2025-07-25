-- Sound ID que você mandou
local soundId = "rbxassetid://9125557781"
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- 1. TOCAR o som em TODOS os objetos de Sound no jogo (mesmo locais)
for _, obj in ipairs(game:GetDescendants()) do
	if obj:IsA("Sound") then
		pcall(function()
			obj.SoundId = soundId -- força o som ID em qualquer Sound encontrado
			obj.Looped = true
			obj.Volume = 10
			obj:Play()
		end)
	end
end

-- 2. TENTA FORÇAR RemoteEvents suspeitos a executar o som via FireServer
local payloads = {
	soundId,
	{soundId},
	lp,
	{"play"},
	"play",
	"sound",
	"explode",
	{["Sound"] = soundId},
	{["SoundId"] = soundId},
	{["Id"] = soundId},
	123456,
	{123456},
	true,
	nil
}

for _, remote in ipairs(game:GetDescendants()) do
	if remote:IsA("RemoteEvent") then
		local name = remote.Name:lower()
		if name:find("sound") or name:find("audio") or name:find("play") or name:find("effect") then
			warn("🔊 Tentando RemoteEvent:", remote:GetFullName())
			for _, payload in ipairs(payloads) do
				pcall(function()
					remote:FireServer(payload)
				end)
			end
		end
	end
end
