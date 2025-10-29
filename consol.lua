-- LocalScript в StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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

-- Заголовок консоли (для перемещения)
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
outputLayout.Padding = UDim.new(0, 1) -- Минимальное расстояние между сообщениями
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

-- Функция для вывода текста в консоль (исправленная)
function printToConsole(text, messageType)
    messageType = messageType or "info"
    
    -- Ждем пока UI обновится
    RunService.Heartbeat:Wait()
    
    -- Создаем сообщение
    local messageFrame = Instance.new("Frame")
    messageFrame.Name = "Message_" .. messageCount
    messageFrame.Size = UDim2.new(1, -10, 0, 25) -- Уменьшена высота для плотного расположения
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
    timestampLabel.TextSize = 14 -- Немного уменьшен для плотности
    timestampLabel.TextXAlignment = Enum.TextXAlignment.Left
    timestampLabel.TextYAlignment = Enum.TextYAlignment.Center -- Выравнивание по центру
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
    messageLabel.TextSize = 14 -- Немного уменьшен для плотности
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Center -- Выравнивание по центру
    messageLabel.TextWrapped = false -- Отключен перенос для однострочности
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Parent = messageFrame
    
    -- Автоматическая высота для многострочного текста (минимальная)
    local lineCount = math.ceil(string.len(text) / 60) -- Увеличено количество символов на строку
    local textHeight = math.max(20, lineCount * 18) -- Уменьшена высота строки
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
        local newWidth = math.max(300, resizeStartSize.X.Offset + delta.X) -- Минимальная ширина 300
        local newHeight = math.max(200, resizeStartSize.Y.Offset + delta.Y) -- Минимальная высота 200
        
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
wait(0.5) -- Ждем инициализации
printToConsole("Консоль инициализирована!", "success")
printToConsole("Используйте функции:", "system")
printToConsole("_G.ConsolePrint('текст', 'тип') - вывод текста", "info")
printToConsole("_G.ConsoleInput('текст', 'тип') - вывод текста", "info") 
printToConsole("_G.ConsoleClear() - очистка консоли", "info")
printToConsole("Типы сообщений: info, warning, error, success, debug, system", "system")

-- ===================================================================
-- ФУНКЦИЯ СКРЫТИЯ ПО КЛАВИШЕ K (в самом низу скрипта как requested)
-- ===================================================================

-- Обработка нажатия клавиши K для скрытия/показа консоли
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Игнорируем если игра обрабатывает ввод
    
    if input.KeyCode == Enum.KeyCode.K then
        consoleGUI.Enabled = not consoleGUI.Enabled
        if consoleGUI.Enabled then
            printToConsole("Консоль показана", "system")
        else
            printToConsole("Консоль скрыта", "system")
        end
    end
end)

printToConsole("Консоль можно скрыть/показать клавишей K", "system")
