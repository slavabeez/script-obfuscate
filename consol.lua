-- LocalScript в StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем GUI
local consoleGUI = Instance.new("ScreenGui")
consoleGUI.Name = "ConsoleGUI"
consoleGUI.Parent = playerGui

-- Основной фрейм консоли
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Parent = consoleGUI

-- Заголовок консоли
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0.05, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Консоль Roblox"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Область вывода текста
local outputFrame = Instance.new("ScrollingFrame")
outputFrame.Name = "OutputFrame"
outputFrame.Size = UDim2.new(1, -10, 0.85, -10)
outputFrame.Position = UDim2.new(0, 5, 0.05, 5)
outputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
outputFrame.BorderSizePixel = 0
outputFrame.ScrollBarThickness = 8
outputFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
outputFrame.Parent = mainFrame

local outputLayout = Instance.new("UIListLayout")
outputLayout.Name = "OutputLayout"
outputLayout.Padding = UDim.new(0, 5)
outputLayout.Parent = outputFrame

-- Панель ввода
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(1, -10, 0.1, -5)
inputFrame.Position = UDim2.new(0, 5, 0.9, 0)
inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

local textBox = Instance.new("TextBox")
textBox.Name = "InputBox"
textBox.Size = UDim2.new(0.8, 0, 1, 0)
textBox.Position = UDim2.new(0, 0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Введите команду..."
textBox.TextScaled = true
textBox.ClearTextOnFocus = false
textBox.Parent = inputFrame

local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Size = UDim2.new(0.2, 0, 1, 0)
sendButton.Position = UDim2.new(0.8, 0, 0, 0)
sendButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
sendButton.Text = "Отправить"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextScaled = true
sendButton.Parent = inputFrame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0.05, 0, 1, 0)
closeButton.Position = UDim2.new(0.95, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Parent = titleBar

-- Переменные для системы ввода
local messageCount = 0
local maxMessages = 100
local commandHistory = {}
local historyIndex = 0

-- Функция для получения цвета сообщения по типу
function getMessageColor(messageType)
    local colors = {
        info = Color3.fromRGB(255, 255, 255),
        warning = Color3.fromRGB(255, 255, 0),
        error = Color3.fromRGB(255, 50, 50),
        success = Color3.fromRGB(50, 255, 50),
        debug = Color3.fromRGB(100, 100, 255)
    }
    
    return colors[messageType] or colors.info
end

-- Функция для вывода текста в консоль
function printToConsole(text, messageType)
    messageType = messageType or "info"
    
    -- Создаем сообщение
    local messageFrame = Instance.new("Frame")
    messageFrame.Name = "Message_" .. messageCount
    messageFrame.Size = UDim2.new(1, 0, 0, 30)
    messageFrame.BackgroundTransparency = 1
    messageFrame.Parent = outputFrame
    
    local timestampLabel = Instance.new("TextLabel")
    timestampLabel.Name = "Timestamp"
    timestampLabel.Size = UDim2.new(0.15, 0, 1, 0)
    timestampLabel.Position = UDim2.new(0, 0, 0, 0)
    timestampLabel.BackgroundTransparency = 1
    timestampLabel.Text = "[" .. os.date("%H:%M:%S") .. "]"
    timestampLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    timestampLabel.TextScaled = true
    timestampLabel.TextXAlignment = Enum.TextXAlignment.Left
    timestampLabel.Font = Enum.Font.Gotham
    timestampLabel.Parent = messageFrame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(0.85, 0, 1, 0)
    messageLabel.Position = UDim2.new(0.15, 0, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = tostring(text)
    messageLabel.TextColor3 = getMessageColor(messageType)
    messageLabel.TextScaled = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Parent = messageFrame
    
    messageCount = messageCount + 1
    
    -- Ограничение количества сообщений
    if messageCount > maxMessages then
        local oldestMessage = outputFrame:FindFirstChild("Message_0")
        if oldestMessage then
            oldestMessage:Destroy()
        end
    end
    
    -- Авто-скролл вниз
    wait()
    outputFrame.CanvasPosition = Vector2.new(0, outputFrame.AbsoluteCanvasSize.Y)
end

-- Функция очистки консоли
function clearConsole()
    for _, child in ipairs(outputFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    messageCount = 0
    printToConsole("Консоль очищена", "info")
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

closeButton.MouseButton1Click:Connect(function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end)

-- Глобальные функции для использования в других скриптах
_G.ConsolePrint = printToConsole
_G.ConsoleInput = inputToConsole
_G.ConsoleClear = clearConsole

-- Инициализация консоли
printToConsole("Консоль инициализирована!", "success")
printToConsole("Введите 'help' для списка команд", "info")
