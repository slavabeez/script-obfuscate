-- LocalScript в StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем GUI (код из предыдущего примера)
local consoleGUI = Instance.new("ScreenGui")
consoleGUI.Name = "ConsoleGUI"
consoleGUI.Parent = playerGui

-- ... (остальной код создания интерфейса такой же как в предыдущем примере)

-- Переменные для системы ввода
local messageCount = 0
local maxMessages = 100
local commandHistory = {}
local historyIndex = 0

-- Функция для вывода текста в консоль (остается без изменений)
function printToConsole(text, messageType)
    -- ... (код из предыдущего примера)
end

-- Функция обработки введенных команд
function processCommand(inputText)
    if inputText == "" then
        return
    end
    
    -- Добавляем команду в историю
    table.insert(commandHistory, inputText)
    historyIndex = #commandHistory + 1
    
    -- Выводим команду в консоль
    printToConsole("> " .. inputText, "debug")
    
    -- Обрабатываем команды
    local command = string.lower(inputText)
    local args = {}
    
    -- Разбиваем команду на аргументы
    for arg in string.gmatch(inputText, "%S+") do
        table.insert(args, arg)
    end
    
    -- Обработка конкретных команд
    if command == "clear" or command == "cls" then
        clearConsole()
        
    elseif command == "help" then
        printToConsole("Доступные команды:", "info")
        printToConsole("help - показать справку", "info")
        printToConsole("clear/cls - очистить консоль", "info")
        printToConsole("time - текущее игровое время", "info")
        printToConsole("players - список игроков", "info")
        printToConsole("fps - показать FPS", "info")
        printToConsole("echo [текст] - повторить текст", "info")
        printToConsole("calc [выражение] - простой калькулятор", "info")
        
    elseif command == "time" then
        local currentTime = os.date("%H:%M:%S")
        printToConsole("Текущее время: " .. currentTime, "info")
        
    elseif command == "players" then
        printToConsole("Список игроков онлайн:", "info")
        for _, player in ipairs(Players:GetPlayers()) do
            printToConsole("  " .. player.Name, "info")
        end
        
    elseif command == "fps" then
        -- Простой способ получить FPS (примерно)
        local fps = 1 / wait()
        printToConsole("Текущий FPS: " .. math.floor(fps), "info")
        
    elseif args[1] and string.lower(args[1]) == "echo" then
        local echoText = string.sub(inputText, 6) -- Убираем "echo "
        printToConsole(echoText, "info")
        
    elseif args[1] and string.lower(args[1]) == "calc" then
        local expression = string.sub(inputText, 6) -- Убираем "calc "
        local success, result = pcall(function()
            -- Безопасное выполнение математического выражения
            return loadstring("return " .. expression)()
        end)
        
        if success then
            printToConsole(expression .. " = " .. tostring(result), "success")
        else
            printToConsole("Ошибка в выражении: " .. expression, "error")
        end
        
    else
        printToConsole("Неизвестная команда: '" .. inputText .. "'", "error")
        printToConsole("Введите 'help' для списка команд", "warning")
    end
end

-- Функция для программного ввода текста
function inputToConsole(text, commandType)
    commandType = commandType or "user"
    
    if commandType == "user" then
        -- Эмулируем ввод пользователя
        processCommand(text)
    elseif commandType == "system" then
        -- Системное сообщение (без обработки как команда)
        printToConsole(text, "info")
    elseif commandType == "warning" then
        printToConsole(text, "warning")
    elseif commandType == "error" then
        printToConsole(text, "error")
    end
end

-- Обработчики событий UI
sendButton.MouseButton1Click:Connect(function()
    local command = textBox.Text
    if command ~= "" then
        processCommand(command)
        textBox.Text = ""
    end
end)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendButton.MouseButton1Click:Fire()
    end
end)

-- Навигация по истории команд
textBox:GetPropertyChangedSignal("Text"):Connect(function()
    historyIndex = #commandHistory + 1
end)

textBox.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Up then
        -- Стрелка вверх - предыдущая команда
        if #commandHistory > 0 then
            historyIndex = math.max(1, historyIndex - 1)
            textBox.Text = commandHistory[historyIndex] or ""
        end
    elseif input.KeyCode == Enum.KeyCode.Down then
        -- Стрелка вниз - следующая команда
        if #commandHistory > 0 then
            historyIndex = math.min(#commandHistory + 1, historyIndex + 1)
            textBox.Text = commandHistory[historyIndex] or ""
        end
    end
end)

-- Глобальные функции для использования в других скриптах
_G.ConsolePrint = printToConsole
_G.ConsoleInput = inputToConsole
_G.ConsoleClear = clearConsole

-- Инициализация консоли
printToConsole("Консоль инициализирована!", "success")
printToConsole("Введите 'help' для списка команд", "info")
