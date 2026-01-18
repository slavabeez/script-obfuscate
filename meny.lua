-- Ждем полной загрузки игры, чтобы PlayerGui был доступен
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 10)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Удаляем старую копию при перезапуске
if PlayerGui:FindFirstChild("TDSFarmMenu") then
    PlayerGui.TDSFarmMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TDSFarmMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui -- Сразу привязываем к интерфейсу

local Frame = Instance.new("Frame")
Frame.Name = "TDSFarmFrame"
Frame.Size = UDim2.new(0, 250, 0, 160)
Frame.Position = UDim2.new(0.5, -125, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.BackgroundTransparency = 0.1 -- Устанавливаем видимость сразу
Frame.Parent = ScreenGui

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})
UIGradient.Rotation = 45
UIGradient.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 50, 200)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.3
UIStroke.Parent = Frame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(80, 40, 180)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚔️ TDS FARM ⚔️"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Кнопки
local function createButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = Frame
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Color = color:Lerp(Color3.new(1,1,1), 0.3)
    
    return btn
end

local GemsButton = createButton("GemsButton", "💎 ЗАПУСТИТЬ GEMS FARM", UDim2.new(0.05, 0, 0, 50), Color3.fromRGB(120, 40, 200))
local MoneyButton = createButton("MoneyButton", "💰 ЗАПУСТИТЬ MONEY FARM", UDim2.new(0.05, 0, 0, 100), Color3.fromRGB(40, 180, 80))

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 1, -25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Готово к работе"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = Frame

-- Перетаскивание
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Функции
local function closeMenu()
    task.spawn(function()
        TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
end

local function loadFarmScript(scriptType)
    local url = (scriptType == "gems") 
        and "https://raw.githubusercontent.com/slavabeez/script-obfuscate/refs/heads/main/obfuscate-gems.lua" 
        or "https://raw.githubusercontent.com/slavabeez/script-obfuscate/refs/heads/main/obfuscate-money.lua"
    
    local btn = (scriptType == "gems") and GemsButton or MoneyButton
    local oldText = btn.Text
    
    btn.Text = "⏳ ЗАГРУЗКА..."
    StatusLabel.Text = "Попытка соединения..."

    task.spawn(function()
        local content = nil
        for i = 1, 10 do -- Увеличено до 10 попыток для надежности
            local s, r = pcall(function() return game:HttpGet(url) end)
            if s and r and #r > 50 then 
                content = r 
                break 
            end
            task.wait(0.5)
        end

        if content then
            StatusLabel.Text = "Запуск кода..."
            local s, func = pcall(function() return loadstring(content) end)
            if s and func then
                btn.Text = "✅ ЗАПУЩЕНО"
                task.spawn(func)
                task.wait(0.5)
                closeMenu()
            else
                btn.Text = "❌ ОШИБКА"
                task.wait(2)
                btn.Text = oldText
            end
        else
            btn.Text = "❌ ОШИБКА СЕТИ"
            StatusLabel.Text = "GitHub не ответил"
            task.wait(2)
            btn.Text = oldText
            StatusLabel.Text = "Готово к работе"
        end
    end)
end

-- Обработчики
local active = false
local function handle(t)
    if active then return end
    active = true
    loadFarmScript(t)
    task.wait(1)
    active = false
end

GemsButton.MouseButton1Click:Connect(function() handle("gems") end)
MoneyButton.MouseButton1Click:Connect(function() handle("money") end)

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "✖️"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.BorderSizePixel = 0
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 15)
CloseButton.MouseButton1Click:Connect(closeMenu)

-- Горячие клавиши
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then handle("gems")
    elseif input.KeyCode == Enum.KeyCode.F2 then handle("money")
    elseif input.KeyCode == Enum.KeyCode.R then Frame.Position = UDim2.new(0.5, -125, 0.5, -80)
    end
end)

-- Анимация появления
Frame.Position = UDim2.new(0.5, -125, 0.4, -80)
TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -125, 0.5, -80)}):Play()
