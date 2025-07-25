local HttpService = game:GetService("HttpService")

local function generateExecutorId(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = {}

    for i = 1, length do
        local rand = math.random(1, #charset)
        table.insert(result, string.sub(charset, rand, rand))
    end

    return table.concat(result)
end

local executorId = generateExecutorId(4)
print("⚙️ Executor ID gerado: " .. executorId)
local baseUrl = 'https://hypex-executor-default-rtdb.firebaseio.com/commands/' .. executorId .. '.json'
local processed = {}

spawn(function()
    while true do
        local success, raw = pcall(function()
            return game:HttpGet(baseUrl)
        end)

        if success and raw and raw ~= 'null' then
            local data = HttpService:JSONDecode(raw)

            for key, cmd in pairs(data) do
                if cmd.Script and not processed[key] then
                    processed[key] = true

                    print('🔥 Script remoto recebido: ' .. tostring(cmd.Script))

                    local ok, err = pcall(function()
                        loadstring(cmd.Script)()
                    end)

                    if ok then
                        print('✅ Executado com sucesso.')
                    else
                        warn('❌ Erro ao executar: ' .. tostring(err))
                    end
                end
            end
        end

        wait(2)
    end
end)
