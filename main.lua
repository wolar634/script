-- === MoonSec V3 Обфускация ===
local moonsec = loadstring(game:HttpGet("https://raw.githubusercontent.com/MoonSecV3/MoonSec/main/main.lua"))()
moonsec:Obfuscate(function()

    -- === ВАЖНО ===
    -- Укажи свой вебхук Discord
    local webhookURL = "https://discord.com/api/webhooks/1339562627269132298/i-0WV49Q09N4Dj7aCjRkk5FeNoMAlT8_5Fe0d15rwGRl_dLvvgFUumC5_Tmyh2lEn6lX"

    -- Получаем данные об игроке
    local player = game.Players.LocalPlayer
    local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

    -- Функция отправки данных на вебхук
    local function sendWebhook()
        local data = {
            ["username"] = "Injection Logger",
            ["embeds"] = {
                {
                    ["title"] = "Новый инжект!",
                    ["description"] = "Кто-то запустил твой скрипт!",
                    ["fields"] = {
                        { ["name"] = "Игрок", ["value"] = player.Name, ["inline"] = true },
                        { ["name"] = "UserId", ["value"] = tostring(player.UserId), ["inline"] = true },
                        { ["name"] = "Плейс", ["value"] = gameInfo.Name, ["inline"] = true },
                        { ["name"] = "Время", ["value"] = os.date("%Y-%m-%d %H:%M:%S"), ["inline"] = true }
                    },
                    ["color"] = 16711680 -- Красный цвет
                }
            }
        }
        
        local httpService = game:GetService("HttpService")
        local jsonData = httpService:JSONEncode(data)
        httpService:PostAsync(webhookURL, jsonData, Enum.HttpContentType.ApplicationJson)
    end

    -- Вызываем вебхук при инжекте
    sendWebhook()

    -- Загружаем UI с GitHub
    local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/wolar634/script/refs/heads/main/main.lua", true))()

    -- Создаём флаг для состояния меню
    local menuOpen = true 

    -- Функция переключения меню
    local function toggleMenu()
        menuOpen = not menuOpen 
        ui.Enabled = menuOpen 
    end

    -- Подключаем клавишу Insert
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
            toggleMenu()
        end
    end)

    -- Активируем меню сразу после инжекта
    ui.Enabled = true

end)
