print("da")
-- LocalScript в StarterPlayerScripts
local function CreateInfiniteSprintScript()
    -- Проверяем существование целевой папки
    local replicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Постепенно проверяем путь к папке
    local systemsFolder = replicatedStorage:FindFirstChild("Systems")
    if not systemsFolder then
        warn("❌ Папка 'Systems' не найдена в ReplicatedStorage!")
        return nil
    end
    
    local characterFolder = systemsFolder:FindFirstChild("Character")
    if not characterFolder then
        warn("❌ Папка 'Character' не найдена!")
        return nil
    end
    
    local gameFolder = characterFolder:FindFirstChild("Game")
    if not gameFolder then
        warn("❌ Папка 'Game' не найдена!")
        return nil
    end
    
    print("✅ Целевая папка найдена:", gameFolder:GetFullName())
    
    -- Проверяем, существует ли уже скрипт
    local existingScript = gameFolder:FindFirstChild("Sprinting")
    if existingScript then
        print("📝 Скрипт Sprinting уже существует. Удаляем старую версию...")
        existingScript:Destroy()
        wait(0.5) -- Даем больше времени на удаление
    end
    
    -- Создаем новый ModuleScript
    local sprintModule = Instance.new("ModuleScript")
    sprintModule.Name = "Sprinting"
    
    -- Упрощенный код модифицированного скрипта спринта
    local sprintCode = [[
local module = {
	DefaultConfig = {
		IsSprinting = false;
		BindsEnabled = true;
		StaminaLossDisabled = true; -- БЕСКОНЕЧНАЯ СТАМИНА
		MinStamina = 0;
		MaxStamina = 100;
		SprintSpeed = 26;
		StaminaLoss = 0; -- НЕТ РАСХОДА
		StaminaGain = 100; -- МГНОВЕННОЕ ВОССТАНОВЛЕНИЕ
	};
}

local Network = require(game.ReplicatedStorage.Modules.Network)
local TweenService = game:GetService("TweenService")

function module.ChangeStat(arg1, arg2, arg3)
	if module[arg2] then
		module[arg2] = arg3
	end
end

function module.Toggle(arg1, arg2)
	local character = game.Players.LocalPlayer.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	
	if not humanoid then
		return
	end
	
	if arg2 then
		-- Включение спринта
		TweenService:Create(module.__FOVMultiplier, TweenInfo.new(0.75), {
			Value = 1.125;
		}):Play()
		TweenService:Create(module.__speedMultiplier, TweenInfo.new(0.75), {
			Value = module.SprintSpeed / (humanoid:GetAttribute("BaseSpeed") or 16);
		}):Play()
	else
		-- Выключение спринта
		TweenService:Create(module.__FOVMultiplier, TweenInfo.new(0.75), {
			Value = 1;
		}):Play()
		TweenService:Create(module.__speedMultiplier, TweenInfo.new(0.75), {
			Value = 1;
		}):Play()
	end
end

function module.Init(arg1)
	local LocalPlayer = game.Players.LocalPlayer
	local Character = LocalPlayer.Character
	
	-- Инициализация настроек
	for i, v in pairs(module.DefaultConfig) do
		module[i] = v
	end
	
	module.StaminaCap = nil
	module.DefaultsSet = true
	
	-- Создание событий
	module.__sprintedEvent = Instance.new("BindableEvent")
	module.__staminaChangedEvent = Instance.new("BindableEvent")
	
	-- Создание множителей
	module.__speedMultiplier = Instance.new("NumberValue")
	module.__speedMultiplier.Value = 1
	module.__speedMultiplier.Name = "Sprinting"
	
	module.__FOVMultiplier = Instance.new("NumberValue")
	module.__FOVMultiplier.Value = 1
	module.__FOVMultiplier.Name = "Sprinting"
	
	-- Ждем создания папок
	local speedMultipliers = Character:WaitForChild("SpeedMultipliers", 10)
	local fovMultipliers = Character:WaitForChild("FOVMultipliers", 10)
	
	if speedMultipliers then
		module.__speedMultiplier.Parent = speedMultipliers
	end
	
	if fovMultipliers then
		module.__FOVMultiplier.Parent = fovMultipliers
	end
	
	module.CanSprint = true
	module.SprintToggled = module.__sprintedEvent.Event
	module.StaminaChanged = module.__staminaChangedEvent.Event
	module.Stamina = module.MaxStamina -- ВСЕГДА МАКСИМУМ
	
	-- Обработчик включения/выключения спринта
	module.SprintToggled:Connect(function(isSprinting)
		module:Toggle(isSprinting)
	end)
	
	-- Упрощенная логика спринта без проверок стамины
	task.spawn(function()
		while true do
			wait(1)
			-- Поддерживаем стамину на максимуме
			if module.Stamina < module.MaxStamina then
				module.Stamina = module.MaxStamina
				module.__staminaChangedEvent:Fire(module.Stamina)
			end
		end
	end)
	
	print("✅ Модифицированный спринт активирован! Бесконечная стамина.")
end

function module.Destroy(arg1)
	if module.__sprintedEvent then
		module.__sprintedEvent:Destroy()
	end
	if module.__staminaChangedEvent then
		module.__staminaChangedEvent:Destroy()
	end
	if module.__speedMultiplier then
		module.__speedMultiplier:Destroy()
	end
	if module.__FOVMultiplier then
		module.__FOVMultiplier:Destroy()
	end
end

return module
]]
    
    sprintModule.Source = sprintCode
    sprintModule.Parent = gameFolder
    
    print("✅ Модифицированный скрипт Sprinting успешно создан!")
    print("📍 Расположение: " .. sprintModule:GetFullName())
    
    return sprintModule
end

-- Основная функция запуска
local function Main()
    print("🚀 Запуск установщика бесконечного спринта...")
    
    -- Даем время на загрузку игры
    wait(3)
    
    local success, errorMessage = pcall(function()
        local script = CreateInfiniteSprintScript()
        if script then
            print("🎉 Установка завершена успешно!")
        else
            print("❌ Не удалось создать скрипт")
        end
    end)
    
    if not success then
        warn("❌ Ошибка при установке: " .. tostring(errorMessage))
    end
end

-- Запускаем основную функцию
Main()
