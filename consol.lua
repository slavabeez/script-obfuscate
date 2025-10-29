-- LocalScript в StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ОСНОВНАЯ КОНСОЛЬ
local consoleGUI = Instance.new("ScreenGui")
consoleGUI.Name = "ConsoleGUI"
consoleGUI.Parent = playerGui

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
titleLabel.Size = UDim2.new(0.95, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "TDS auto farm"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Уголок для изменения размера
local resizeHandle = Instance.new("Frame")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.new(0, 15, 0, 15)
resizeHandle.Position = UDim2.new(1, -15, 1, -15)
resizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
resizeHandle.BorderSizePixel = 1
resizeHandle.BorderColor3 = Color3.fromRGB(150, 150, 150)
resizeHandle.ZIndex = 2
resizeHandle.Parent = mainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 3)
resizeCorner.Parent = resizeHandle

-- Область вывода текста
local outputFrame = Instance.new("ScrollingFrame")
outputFrame.Name = "OutputFrame"
outputFrame.Size = UDim2.new(1, -10, 0.95, -5)
outputFrame.Position = UDim2.new(0, 5, 0.05, 5)
outputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
outputFrame.BorderSizePixel = 0
outputFrame.ScrollBarThickness = 8
outputFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
outputFrame.ScrollingDirection = Enum.ScrollingDirection.Y
outputFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
outputFrame.Parent = mainFrame

local outputLayout = Instance.new("UIListLayout")
outputLayout.Name = "OutputLayout"
outputLayout.Padding = UDim.new(0, 1)
outputLayout.SortOrder = Enum.SortOrder.LayoutOrder
outputLayout.Parent = outputFrame

local outputPadding = Instance.new("UIPadding")
outputPadding.Name = "OutputPadding"
outputPadding.PaddingTop = UDim.new(0, 2)
outputPadding.PaddingLeft = UDim.new(0, 2)
outputPadding.PaddingRight = UDim.new(0, 2)
outputPadding.PaddingBottom = UDim.new(0, 2)
outputPadding.Parent = outputFrame

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

-- Переменные для системы
local messageCount = 0
local maxMessages = 100

-- Переменные для перемещения
local dragging = false
local dragInput
local dragStart
local startPos

-- Переменные для изменения размера
local resizing = false
local resizeStart
local resizeStartSize

-- Функция для получения цвета сообщения по типу
function getMessageColor(messageType)
    local colors = {
        info = Color3.fromRGB(255, 255, 255),
        warning = Color3.fromRGB(255, 255, 0),
        error = Color3.fromRGB(255, 50, 50),
        success = Color3.fromRGB(50, 255, 50),
        debug = Color3.fromRGB(100, 100, 255),
        system = Color3.fromRGB(150, 150, 255)
    }
    
    return colors[messageType] or colors.info
end

-- Функция для вывода текста в консоль
function printToConsole(text, messageType)
    messageType = messageType or "info"
    
    -- Ждем пока UI обновится
    RunService.Heartbeat:Wait()
    
    -- Создаем сообщение
    local messageFrame = Instance.new("Frame")
    messageFrame.Name = "Message_" .. messageCount
    messageFrame.Size = UDim2.new(1, -10, 0, 25)
    messageFrame.BackgroundTransparency = 1
    messageFrame.LayoutOrder = messageCount
    messageFrame.Parent = outputFrame
    
    local timestampLabel = Instance.new("TextLabel")
    timestampLabel.Name = "Timestamp"
    timestampLabel.Size = UDim2.new(0.15, 0, 1, 0)
    timestampLabel.Position = UDim2.new(0, 0, 0, 0)
    timestampLabel.BackgroundTransparency = 1
    timestampLabel.Text = "[" .. os.date("%H:%M:%S") .. "]"
    timestampLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    timestampLabel.TextScaled = false
    timestampLabel.TextSize = 14
    timestampLabel.TextXAlignment = Enum.TextXAlignment.Left
    timestampLabel.TextYAlignment = Enum.TextYAlignment.Center
    timestampLabel.Font = Enum.Font.Gotham
    timestampLabel.Parent = messageFrame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(0.85, 0, 1, 0)
    messageLabel.Position = UDim2.new(0.15, 0, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = tostring(text)
    messageLabel.TextColor3 = getMessageColor(messageType)
    messageLabel.TextScaled = false
    messageLabel.TextSize = 14
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Center
    messageLabel.TextWrapped = false
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Parent = messageFrame
    
    -- Автоматическая высота для многострочного текста
    local lineCount = math.ceil(string.len(text) / 60)
    local textHeight = math.max(20, lineCount * 18)
    messageFrame.Size = UDim2.new(1, -10, 0, textHeight)
    messageLabel.Size = UDim2.new(0.85, 0, 1, 0)
    
    messageCount = messageCount + 1
    
    -- Ограничение количества сообщений
    if messageCount > maxMessages then
        local children = outputFrame:GetChildren()
        for i = 1, #children do
            local child = children[i]
            if child:IsA("Frame") and child ~= messageFrame then
                child:Destroy()
                break
            end
        end
    end
    
    -- Авто-скролл вниз
    wait(0.05)
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
    printToConsole("Консоль очищена", "system")
end

-- Функция для программного ввода текста
function inputToConsole(text, messageType)
    messageType = messageType or "info"
    printToConsole(text, messageType)
end

-- Система перемещения консоли
local function updateInput(input)
    if dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

-- Система изменения размера
local function updateResize(input)
    if resizing then
        local delta = input.Position - resizeStart
        local newWidth = math.max(300, resizeStartSize.X.Offset + delta.X)
        local newHeight = math.max(200, resizeStartSize.Y.Offset + delta.Y)
        
        mainFrame.Size = UDim2.new(
            0, newWidth,
            0, newHeight
        )
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        resizeStartSize = mainFrame.Size
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

resizeHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput then
        if dragging then
            updateInput(input)
        elseif resizing then
            updateResize(input)
        end
    end
end)

-- Обработчики событий UI
closeButton.MouseButton1Click:Connect(function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end)

-- Глобальные функции для использования в других скриптах
_G.ConsolePrint = printToConsole
_G.ConsoleInput = inputToConsole
_G.ConsoleClear = clearConsole

-- Инициализация консоли
wait(0.5) 
printToConsole("Консоль инициализирована!", "success")
printToConsole("Консоль можно скрыть/показать клавишей K", "system")

-- Обработка нажатия клавиши K для скрытия/показа консоли
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        consoleGUI.Enabled = not consoleGUI.Enabled
    end
end)

-- КНОПКА ОЧИСТКИ КОНСОЛИ (в том же скрипте)
local clearButtonGUI = Instance.new("ScreenGui")
clearButtonGUI.Name = "ClearConsoleButtonGUI"
clearButtonGUI.Parent = playerGui

local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearConsoleButton"
clearButton.Size = UDim2.new(0, 150, 0, 40)
clearButton.Position = UDim2.new(0, 10, 0, 60) -- Подвинем ниже чтобы не перекрывать
clearButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
clearButton.BorderSizePixel = 2
clearButton.BorderColor3 = Color3.fromRGB(100, 30, 30)
clearButton.Text = "Очистить консоль"
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.TextScaled = true
clearButton.Font = Enum.Font.GothamBold
clearButton.ZIndex = 10
clearButton.Parent = clearButtonGUI

-- Переменные для перетаскивания кнопки
local buttonDragging = false
local buttonDragInput
local buttonDragStart
local buttonStartPos

-- Функция обновления позиции кнопки при перетаскивании
local function updateButtonInput(input)
    if buttonDragging then
        local delta = input.Position - buttonDragStart
        clearButton.Position = UDim2.new(
            buttonStartPos.X.Scale, 
            buttonStartPos.X.Offset + delta.X,
            buttonStartPos.Y.Scale, 
            buttonStartPos.Y.Offset + delta.Y
        )
    end
end

-- Обработчики для перетаскивания кнопки
clearButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        buttonDragging = true
        buttonDragStart = input.Position
        buttonStartPos = clearButton.Position
        
        -- Меняем внешний вид при захвате для перетаскивания
        clearButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        clearButton.Text = "Перетаскивается..."
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                buttonDragging = false
                -- Возвращаем нормальный вид
                clearButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
                clearButton.Text = "Очистить консоль"
            end
        end)
    end
end)

clearButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        buttonDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == buttonDragInput and buttonDragging then
        updateButtonInput(input)
    end
end)

-- Обработчик нажатия кнопки (очистка консоли)
clearButton.MouseButton1Click:Connect(function()
    -- Если не перетаскивали (короткое нажатие)
    if not buttonDragging then
        local success = clearConsole()
        
        if success then
            -- Визуальная обратная связь при успешной очистке
            clearButton.Text = "Очищено!"
            clearButton.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
            
            -- Возвращаем исходный вид через 1 секунду
            wait(1)
            clearButton.Text = "Очистить консоль"
            clearButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        else
            -- Визуальная обратная связь при ошибке
            clearButton.Text = "Ошибка!"
            clearButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            
            wait(1)
            clearButton.Text = "Очистить консоль"
            clearButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        end
    end
end)

-- Анимации для кнопки
clearButton.MouseEnter:Connect(function()
    if not buttonDragging then
        clearButton.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    end
end)

clearButton.MouseLeave:Connect(function()
    if not buttonDragging then
        clearButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    end
end)

-- Обработка клавиши K для скрытия/показа кнопки вместе с консолью
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        -- Переключаем видимость кнопки вместе с консолью
        clearButtonGUI.Enabled = consoleGUI.Enabled
    end
end)

-- Функции для управления кнопкой
_G.HideClearButton = function()
    clearButtonGUI.Enabled = false
end

_G.ShowClearButton = function()
    clearButtonGUI.Enabled = true
end

_G.ToggleClearButton = function()
    clearButtonGUI.Enabled = not clearButtonGUI.Enabled
end

-- Синхронизация видимости кнопки с консолью
spawn(function()
    while true do
        wait(0.1)
        -- Синхронизируем видимость кнопки с консолью
        if clearButtonGUI.Enabled ~= consoleGUI.Enabled then
            clearButtonGUI.Enabled = consoleGUI.Enabled
        end
    end
end)

-- Инициализация кнопки
wait(1)
printToConsole("Зажимайте кнопку для перетаскивания", "info")
printToConsole("Нажимайте K для скрытия/показа", "info")
