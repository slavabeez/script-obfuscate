-- TDS Farmer V2
if not game:IsLoaded() then game.Loaded:Wait() end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local CONFIG_FILE = "TDS_MoneyFarmer_Config.json"
local startTime = tick()

_G._E = {}
local _E = _G._E
getgenv().AutoCollect = false

-- === СИСТЕМА ЦВЕТОВ ===
local function getMessageType(messageType)
    local types = {info = "[INFO]", warning = "[WARN]", error = "[ERROR]", success = "[SUCCESS]", debug = "[DEBUG]", system = "[SYSTEM]"}
    return types[messageType] or "[INFO]"
end

local function getMessageColor(messageType)
    local colors = {info = Color3.fromRGB(220, 220, 220), warning = Color3.fromRGB(255, 200, 0), error = Color3.fromRGB(255, 60, 60), success = Color3.fromRGB(60, 255, 60), debug = Color3.fromRGB(100, 150, 255), system = Color3.fromRGB(150, 100, 255)}
    return colors[messageType] or colors.info
end

-- === ИНТЕРФЕЙС ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TDS_Money_V2_Console"
if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = CoreGui end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 430)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -215)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(139, 0, 255)
MainStroke.Thickness = 2

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TDS Farmer <font color='#8B00FF'>V2</font> | GLOBAL MODE"
TitleText.RichText = true
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local LogFrame = Instance.new("ScrollingFrame", MainFrame)
LogFrame.Size = UDim2.new(1, -20, 1, -200)
LogFrame.Position = UDim2.new(0, 10, 0, 45)
LogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
LogFrame.ScrollBarThickness = 2
LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", LogFrame).Padding = UDim.new(0, 2)

-- ГЛОБАЛЬНЫЙ ПРИНТ
_G.print = function(text, type)
    type = type or "info"
    local l = Instance.new("TextLabel", LogFrame)
    l.Size = UDim2.new(1, -10, 0, 18)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Code
    l.TextSize = 12
    l.TextColor3 = getMessageColor(type)
    l.Text = string.format("[%s] %s %s", os.date("%H:%M:%S"), getMessageType(type), tostring(text))
    l.TextXAlignment = Enum.TextXAlignment.Left
    LogFrame.CanvasPosition = Vector2.new(0, 999999)
end

-- === ГЛОБАЛЬНАЯ ФУНКЦИЯ ВЕБХУКА ===
_G.sendWebhook = function(received, current)
    local webhook = getgenv().Webhook
    if not webhook or webhook == "" or webhook == "Paste Webhook URL here..." then
        warn("Webhook URL is missing!")
        return
    end

    -- Расчет времени сессии
    local runTime = tick() - (startTime or tick())
    local sessionFormatted = string.format("%02d:%02d:%02d", 
        math.floor(runTime/3600), 
        math.floor((runTime%3600)/60), 
        math.floor(runTime%60)
    )
    
    -- Получение локального времени и даты
    local localTime = os.date("%H:%M:%S")
    local localDate = os.date("%d.%m.%Y")
    local footerTime = os.date("%H:%M")

    -- Определение карты
    local mapName = "Game"
    pcall(function() 
        mapName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name 
    end)

    local payload = {
        ["username"] = "TDS Farmer",
        ["avatar_url"] = "https://cdn-icons-png.flaticon.com/512/4708/4708820.png",
        ["embeds"] = {{
            ["title"] = "💰 MONEY UPDATE - TDS",
            ["color"] = 0x8B00FF, -- Фиолетовый цвет как на скрине
            ["fields"] = {
                {
                    ["name"] = "👤 Player",
                    ["value"] = "```" .. game.Players.LocalPlayer.Name .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "💰 Current Coins",
                    ["value"] = "```" .. tostring(current or 0) .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "⭐ Total Received",
                    ["value"] = "```" .. tostring(received or 0) .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🗺️ Map",
                    ["value"] = "```" .. mapName .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "⌚ Session",
                    ["value"] = "```" .. sessionFormatted .. "```",
                    ["inline"] = true
                },
                {
                    ["name"] = "⏰ Local Time",
                    ["value"] = "```" .. localTime .. "```",
                    ["inline"] = true
                }
            },
            ["footer"] = {
                ["text"] = "TDS Farmer V2 • " .. localDate .. " • Сегодня, в " .. footerTime
            }
        }}
    }

    -- Отправка запроса
    task.spawn(function()
        local req = (syn and syn.request) or (http_request) or (fluxus and fluxus.request) or request
        if req then
            local success, res = pcall(function()
                return req({
                    Url = webhook,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payload)
                })
            end)
            if success then _G.print("Webhook sent!", "success") else _G.print("Webhook failed!", "error") end
        else
            _G.print("Executor not supported (request func missing)", "error")
        end
    end)
end

-- === ПАНЕЛЬ УПРАВЛЕНИЯ ===
local ControlPanel = Instance.new("Frame", MainFrame)
ControlPanel.Size = UDim2.new(1, -20, 0, 140)
ControlPanel.Position = UDim2.new(0, 10, 1, -150)
ControlPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", ControlPanel)

local WebInput = Instance.new("TextBox", ControlPanel)
WebInput.Size = UDim2.new(1, -100, 0, 30)
WebInput.Position = UDim2.new(0, 10, 0, 10)
WebInput.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
WebInput.TextColor3 = Color3.new(1,1,1)
WebInput.PlaceholderText = "Paste Webhook URL here..."
WebInput.Text = getgenv().Webhook or ""
Instance.new("UICorner", WebInput)
Instance.new("UIPadding", WebInput).PaddingLeft = UDim.new(0, 8)

local SaveBtn = Instance.new("TextButton", ControlPanel)
SaveBtn.Size = UDim2.new(0, 80, 0, 30)
SaveBtn.Position = UDim2.new(1, -90, 0, 10)
SaveBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 80)
SaveBtn.Text = "SAVE"
SaveBtn.TextColor3 = Color3.new(1,1,1)
SaveBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SaveBtn)

local CollectToggleBtn = Instance.new("TextButton", ControlPanel)
CollectToggleBtn.Size = UDim2.new(1, -20, 0, 35)
CollectToggleBtn.Position = UDim2.new(0, 10, 0, 50)
CollectToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
CollectToggleBtn.Text = "AUTO CHARACTER FLY-COLLECT: OFF"
CollectToggleBtn.TextColor3 = Color3.new(1,1,1)
CollectToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CollectToggleBtn)

local ManualSendBtn = Instance.new("TextButton", ControlPanel)
ManualSendBtn.Size = UDim2.new(0.65, -10, 0, 35)
ManualSendBtn.Position = UDim2.new(0, 10, 0, 95)
ManualSendBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
ManualSendBtn.Text = "TEST WEBHOOK"
ManualSendBtn.TextColor3 = Color3.new(1,1,1)
ManualSendBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ManualSendBtn)

local ClearBtn = Instance.new("TextButton", ControlPanel)
ClearBtn.Size = UDim2.new(0.35, -10, 0, 35)
ClearBtn.Position = UDim2.new(0.65, 5, 0, 95)
ClearBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ClearBtn.Text = "CLEAR"
ClearBtn.TextColor3 = Color3.new(1,1,1)
ClearBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ClearBtn)

-- === ЛОГИКА ПОЛЕТА ПЕРСОНАЖА (CHARACTER FLY) ===
local function updateCollectButton()
    if getgenv().AutoCollect then
        CollectToggleBtn.Text = "AUTO CHARACTER FLY-COLLECT: ON"
        CollectToggleBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
    else
        CollectToggleBtn.Text = "AUTO CHARACTER FLY-COLLECT: OFF"
        CollectToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)
        if getgenv().AutoCollect then
            pcall(function()
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local pickups = workspace:FindFirstChild("Pickups")
                
                if hrp and pickups then
                    local target = nil
                    local shortestDistance = 500

                    for _, item in ipairs(pickups:GetChildren()) do
                        if item.Name == "SnowCharm" and item:IsA("BasePart") then
                            local distance = (hrp.Position - item.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                target = item
                            end
                        end
                    end

                    if target then
                        local travelTime = shortestDistance / 120 
                        local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
                        
                        hrp.Anchored = true 
                        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = target.CFrame * CFrame.new(0, 2, 0)})
                        tween:Play()
                        tween.Completed:Wait()
                        hrp.Anchored = false
                        task.wait(0.3)
                    end
                end
            end)
        end
    end
end)

-- === ОБРАБОТЧИКИ UI ===
CollectToggleBtn.MouseButton1Click:Connect(function()
    getgenv().AutoCollect = not getgenv().AutoCollect
    updateCollectButton()
    _G.print("Fly-Collect is now " .. (getgenv().AutoCollect and "ENABLED" or "DISABLED"), "info")
end)

SaveBtn.MouseButton1Click:Connect(function()
    getgenv().Webhook = WebInput.Text
    local configData = {
        Webhook = getgenv().Webhook,
        AutoCollect = getgenv().AutoCollect
    }
    pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(configData)) end)
    _G.print("Config saved to " .. CONFIG_FILE, "success")
end)

ManualSendBtn.MouseButton1Click:Connect(function()
    local c = player:FindFirstChild("Coins") and player.Coins.Value or 0
    local r = getgenv().RewarmA or 0
    _G.sendWebhook(r, c)
end)

ClearBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(LogFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
end)

-- Драг окна
local dragging = false
local dragStart, startPos
TitleBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = MainFrame.Position end end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

-- Загрузка конфига
if isfile(CONFIG_FILE) then
    pcall(function()
        local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
        getgenv().Webhook = data.Webhook
        getgenv().AutoCollect = data.AutoCollect or false
        WebInput.Text = data.Webhook or ""
        updateCollectButton()
    end)
end

_G.print("TDS Farmer V2 Loaded", "system")
return _E
