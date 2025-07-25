local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()

library.rank = "developer"
local Wm = library:Watermark("Hype X Dashboard | v" .. library.version .. " | " .. library:GetUsername() .. " | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(0.75) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()

local Notif = library:InitNotifications()

for i = 20, 0, -1 do
    task.wait(0.05)
    Notif:Notify("Loading Hype X Dashboard v2, please be patient.", 3, "information")
end

library.title = "Dashboard - X"
library:Introduction()
wait(1)
local Init = library:Init()
local Tab1 = Init:NewTab("Loader")
local Section1 = Tab1:NewSection("General & Universal Cheats")

-- Variáveis
local localPlayer = game.Players.LocalPlayer
local espElements = {}

-- Função para criar ESP
local function createESP(player)
    if not player or player == localPlayer then return end

    local espBox = Drawing.new("Square")
    espBox.Thickness = 1
    espBox.Filled = false
    espBox.Visible = false
    espBox.Color = Color3.fromRGB(255, 0, 0)

    local traceLine = Drawing.new("Line")
    traceLine.Thickness = 2
    traceLine.Color = Color3.fromRGB(255, 0, 0)
    traceLine.Visible = false

    local nameText = Drawing.new("Text")
    nameText.Size = 16
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Outline = true
    nameText.Center = true
    nameText.Visible = false
    nameText.Font = 3

    local function updateESP()
        if not ESPEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            traceLine.Visible = false
            nameText.Visible = false
            return
        end

        local rootPart = player.Character.HumanoidRootPart
        local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)

        if onScreen then
            local localChar = localPlayer.Character
            if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
            local localRoot = localChar.HumanoidRootPart
            local startPos = workspace.CurrentCamera:WorldToViewportPoint(localRoot.Position)

            local distance = (workspace.CurrentCamera.CFrame.Position - rootPart.Position).Magnitude
            local size = math.clamp(500 / distance, 20, 100)

            espBox.Size = Vector2.new(size, size * 1.5)
            espBox.Position = Vector2.new(screenPos.X - espBox.Size.X / 2, screenPos.Y - espBox.Size.Y / 2)
            espBox.Visible = true

            traceLine.From = Vector2.new(startPos.X, startPos.Y)
            traceLine.To = Vector2.new(screenPos.X, screenPos.Y)
            traceLine.Visible = true

            nameText.Text = string.format("%s [%.1fm]", player.Name, distance)
            nameText.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
            nameText.Visible = true
        else
            espBox.Visible = false
            traceLine.Visible = false
            nameText.Visible = false
        end
    end

    game:GetService("RunService").RenderStepped:Connect(updateESP)

    espElements[player] = {
        box = espBox,
        line = traceLine,
        name = nameText
    }
end

-- Toggle para ativar/desativar ESP
local function toggle_esp(bool)
    ESPEnabled = bool
    if not ESPEnabled then
        for _, elements in pairs(espElements) do
            elements.box.Visible = false
            elements.line.Visible = false
            elements.name.Visible = false
        end
    else
        for _, player in ipairs(game.Players:GetPlayers()) do
            if not espElements[player] then
                createESP(player)
            end
        end
    end
    DiscordLib:Notification("ESP", bool and "Enabled!" or "Disabled!", "OK")
end

-- Adicionar ESP a jogadores atuais
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= localPlayer then
        createESP(player)
    end
end

-- ESP para jogadores novos
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if ESPEnabled then
            createESP(player)
        end
    end)
end)

-- Remover ESP quando o jogador sair
game.Players.PlayerRemoving:Connect(function(player)
    local elements = espElements[player]
    if elements then
        elements.box:Remove()
        elements.line:Remove()
        elements.name:Remove()
        if elements.connection then
            elements.connection:Disconnect()
        end
        espElements[player] = nil
    end
end)

-- UI
Tab1:NewToggle("ESP", false, toggle_esp)

Tab1:NewButton("Start Client Listener🎧", function()
    print("Starting client lua...")
end)

Tab1:NewButton("Start Player Sync👤", function()
    print("Starting Player Sync...")
end)

Tab1:NewTextbox("Teleport Player👤", "", "1", "all", "small", true, false, function(name)
    local player = game.Players.LocalPlayer
    local p = workspace:FindFirstChild(name)
    if p and p:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = p.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    else
        print("PLR NOT FOUND.")
    end
end)

Notif:Notify("Loaded Hype X Dashboard", 4, "success")
