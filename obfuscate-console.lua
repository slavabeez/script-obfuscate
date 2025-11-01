local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Упрощенная функция для защиты GUI
local function protect_gui(gui)
    gui.Parent = CoreGui
end

-- Функция для генерации случайных строк
local function RandomString(len)
    local s = ""
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, len or 12 do
        local r = math.random(1, #chars)
        s = s .. chars:sub(r, r)
    end
    return s
end

-- Создаем глобальные таблицы если их нет
local _G = _G or getfenv()
local _E = _E or {}
_E.RS = RandomString

-- Создаем GUI консоли
local consoleGUI = Instance.new("ScreenGui")
consoleGUI.Name = "ConsoleGUI_" .. _E.RS(8)
consoleGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
protect_gui(consoleGUI)

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame_" .. _E.RS(8)
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = consoleGUI

-- Стилизация основного фрейма
local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 8)
UICorner1.Parent = mainFrame

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar_" .. _E.RS(7)
titleBar.Size = UDim2.new(1, 0, 0.07, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = titleBar

-- Заголовок консоли
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel_" .. _E.RS(6)
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Roblox Console"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Таймер выполнения
local runtimeLabel = Instance.new("TextLabel")
runtimeLabel.Name = "RuntimeLabel_" .. _E.RS(6)
runtimeLabel.Size = UDim2.new(0.1, 0, 1, 0)
runtimeLabel.Position = UDim2.new(0.75, 0, 0, 0)
runtimeLabel.BackgroundTransparency = 1
runtimeLabel.Text = "00:00"
runtimeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
runtimeLabel.TextScaled = true
runtimeLabel.Font = Enum.Font.Gotham
runtimeLabel.TextXAlignment = Enum.TextXAlignment.Right
runtimeLabel.Parent = titleBar

-- Кнопка сворачивания
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeBtn_" .. _E.RS(9)
minimizeButton.Size = UDim2.new(0.06, 0, 0.6, 0)
minimizeButton.Position = UDim2.new(0.85, 0, 0.2, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseBtn_" .. _E.RS(9)
closeButton.Size = UDim2.new(0.06, 0, 0.6, 0)
closeButton.Position = UDim2.new(0.92, 0, 0.2, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
closeButton.TextScaled = true
closeButton.Parent = titleBar

-- Стилизация кнопок
local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = minimizeButton

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 4)
UICorner4.Parent = closeButton

-- Область вывода текста
local outputFrame = Instance.new("ScrollingFrame")
outputFrame.Name = "OutputFrame_" .. _E.RS(11)
outputFrame.Size = UDim2.new(1, -10, 0.86, -5)
outputFrame.Position = UDim2.new(0, 5, 0.07, 0)
outputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
outputFrame.BorderSizePixel = 0
outputFrame.ScrollBarThickness = 8
outputFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
outputFrame.ScrollingDirection = Enum.ScrollingDirection.Y
outputFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
outputFrame.Parent = mainFrame

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = outputFrame

-- Layout для сообщений
local outputLayout = Instance.new("UIListLayout")
outputLayout.Name = "OutputLayout_" .. _E.RS(12)
outputLayout.Padding = UDim.new(0, 3)
outputLayout.SortOrder = Enum.SortOrder.LayoutOrder
outputLayout.Parent = outputFrame

local outputPadding = Instance.new("UIPadding")
outputPadding.Name = "OutputPadding_" .. _E.RS(13)
outputPadding.PaddingTop = UDim.new(0, 5)
outputPadding.PaddingLeft = UDim.new(0, 8)
outputPadding.PaddingRight = UDim.new(0, 8)
outputPadding.PaddingBottom = UDim.new(0, 8)
outputPadding.Parent = outputFrame

-- Кнопка очистки
local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearBtn_" .. _E.RS(14)
clearButton.Size = UDim2.new(0.12, 0, 0.06, 0)
clearButton.Position = UDim2.new(0.02, 0, 0.92, 0)
clearButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
clearButton.Text = "Clear"
clearButton.TextColor3 = Color3.fromRGB(220, 220, 220)
clearButton.TextSize = 14
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = mainFrame

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 4)
UICorner6.Parent = clearButton

-- Элемент для изменения размера
local resizeHandle = Instance.new("Frame")
resizeHandle.Name = "ResizeHandle_" .. _E.RS(15)
resizeHandle.Size = UDim2.new(0, 16, 0, 16)
resizeHandle.Position = UDim2.new(1, -16, 1, -16)
resizeHandle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
resizeHandle.BorderSizePixel = 1
resizeHandle.BorderColor3 = Color3.fromRGB(120, 120, 120)
resizeHandle.ZIndex = 2
resizeHandle.Parent = mainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 3)
resizeCorner.Parent = resizeHandle

-- Функции для работы с сообщениями
local function getMessageType(messageType)
    local types = {
        info = "[INFO]",
        warning = "[WARN]",
        error = "[ERROR]",
        success = "[SUCCESS]",
        debug = "[DEBUG]",
        system = "[SYSTEM]"
    }
    return types[messageType] or "[INFO]"
end

local function getMessageColor(messageType)
    local colors = {
        info = Color3.fromRGB(220, 220, 220),
        warning = Color3.fromRGB(255, 200, 0),
        error = Color3.fromRGB(255, 60, 60),
        success = Color3.fromRGB(60, 255, 60),
        debug = Color3.fromRGB(100, 150, 255),
        system = Color3.fromRGB(150, 100, 255)
    }
    return colors[messageType] or colors.info
end

-- Основная функция вывода в консоль
function _E.printToConsole(text, messageType)
    messageType = messageType or "info"
    
    -- Ждем обновления кадра для стабильности
    RunService.Heartbeat:Wait()
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message_" .. _E.RS(8)
    messageLabel.Size = UDim2.new(1, -16, 0, 0)
    messageLabel.AutomaticSize = Enum.AutomaticSize.Y
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = "[" .. os.date("%H:%M:%S") .. "] " .. getMessageType(messageType) .. " " .. tostring(text)
    messageLabel.TextColor3 = getMessageColor(messageType)
    messageLabel.TextSize = 14
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.LayoutOrder = #outputFrame:GetChildren()
    messageLabel.Parent = outputFrame
    
    -- Авто-скролл вниз
    task.wait(0.05)
    outputFrame.CanvasPosition = Vector2.new(0, outputFrame.AbsoluteCanvasSize.Y)
end

-- Функция очистки консоли
function _E.clearConsole()
    for _, child in ipairs(outputFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    _E.printToConsole("Console cleared", "system")
end

-- Система перетаскивания
local dragging = false
local dragInput
local dragStart
local startPos

local resizing = false
local resizeInput
local resizeStart
local resizeStartSize

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

local function updateResize(input)
    if resizing then
        local delta = input.Position - resizeStart
        local newWidth = math.max(400, resizeStartSize.X.Offset + delta.X)
        local newHeight = math.max(300, resizeStartSize.Y.Offset + delta.Y)
        
        mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end

-- Обработчики событий для перетаскивания
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
        resizeInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    elseif resizing and input == resizeInput then
        updateResize(input)
    end
end)

-- Обработчики кнопок
minimizeButton.MouseButton1Click:Connect(function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end)

closeButton.MouseButton1Click:Connect(function()
    consoleGUI:Destroy()
    _G.print = nil
    _G.clearConsole = nil
    _G.consoleToggle = nil
end)

clearButton.MouseButton1Click:Connect(function()
    _E.clearConsole()
end)

-- Глобальные функции для использования в других скриптах
_G.print = _E.printToConsole
_G.clearConsole = _E.clearConsole
_G.consoleToggle = function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end

-- Горячая клавиша для показа/скрытия консоли
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F8 then
        consoleGUI.Enabled = not consoleGUI.Enabled
    end
end)

-- Таймер выполнения
local startTime = os.time()

local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
   
    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%d:%02d", minutes, secs)
    else
        return string.format("%02d", secs)
    end
end

-- Обновление таймера
task.spawn(function()
    while consoleGUI.Parent do
        local elapsed = os.time() - startTime
        runtimeLabel.Text = formatTime(elapsed)
        task.wait(1)
    end
end)

-- Тестовые сообщения при запуске
task.delay(1, function()
    _E.printToConsole("Console initialized successfully!", "success")
    _E.printToConsole("Use _G.print('message', 'type') to output text", "info")
    _E.printToConsole("Available types: info, warning, error, success, debug, system", "info")
    _E.printToConsole("Press F8 to hide/show console", "system")
end)

-- Убеждаемся что GUI добавлен в правильное место
if not consoleGUI.Parent then
    consoleGUI.Parent = CoreGui
end

return _E
