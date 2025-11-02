local function ModifySprintingScript()
    -- Ждем загрузки игры
    wait(3)
    
    local targetPath = game:GetService("ReplicatedStorage").Systems.Character.Game
    local sprintingScript = targetPath:FindFirstChild("Sprinting")
    
    if not sprintingScript then
        warn("❌ Скрипт Sprinting не найден")
        return false
    end
    
    if not sprintingScript:IsA("ModuleScript") then
        warn("❌ Объект не является ModuleScript")
        return false
    end
    
    print("📝 Найден скрипт Sprinting, модифицируем...")
    
    -- Получаем текущий код
    local currentCode = sprintingScript.Source
    
    -- Делаем основные изменения для бесконечной стамины
    local modifiedCode = currentCode
    
    -- 1. Включаем отключение расхода стамины
    modifiedCode = modifiedCode:gsub("StaminaLossDisabled = false", "StaminaLossDisabled = true")
    
    -- 2. Устанавливаем нулевой расход стамины
    modifiedCode = modifiedCode:gsub("StaminaLoss = 10", "StaminaLoss = 0")
    
    -- 3. Увеличиваем восстановление до максимума
    modifiedCode = modifiedCode:gsub("StaminaGain = 20", "StaminaGain = 100")
    
    -- 4. Находим и модифицируем основной цикл обработки стамины
    -- Ищем участок кода где обрабатывается изменение стамины
    if modifiedCode:find("task%.spawn%(function%(%)") then
        -- Заменяем логику уменьшения стамины на поддержание максимума
        local maintenanceCode = [[
	task.spawn(function()
		while true do
			wait(0.1)
			-- Поддерживаем стамину на максимуме
			if module_upvr.Stamina < module_upvr.MaxStamina then
				module_upvr.Stamina = module_upvr.MaxStamina
				if module_upvr.__staminaChangedEvent then
					module_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)
				end
			end
		end
	end)
]]
        
        -- Заменяем весь цикл на наш код поддержания стамины
        modifiedCode = modifiedCode:gsub("task%.spawn%(function%(%).-end%)", maintenanceCode)
    end
    
    -- 5. Убираем проверку на минимальную стамину для спринта
    modifiedCode = modifiedCode:gsub("if module_upvr%.MinStamina < var22 then", "if true then -- Бесконечная стамина")
    
    -- Применяем изменения
    sprintingScript.Source = modifiedCode
    
    print("✅ Скрипт Sprinting успешно модифицирован!")
    print("⚡ Бесконечная стамина активирована")
    print("📍 Стамина не будет тратиться при спринте")
    
    return true
end

-- Альтернативный метод - минимальные изменения
local function SimpleModification()
    wait(3)
    
    local sprintingScript = game:GetService("ReplicatedStorage").Systems.Character.Game:FindFirstChild("Sprinting")
    if not sprintingScript then return false end
    
    local code = sprintingScript.Source
    
    -- Минимальные изменения для отключения расхода стамины
    local newCode = code
    
    -- Просто меняем ключевые параметры
    newCode = newCode:gsub("StaminaLossDisabled = false", "StaminaLossDisabled = true")
    newCode = newCode:gsub("StaminaLoss = 10", "StaminaLoss = 0")
    newCode = newCode:gsub("StaminaGain = 20", "StaminaGain = 1000")
    
    -- Добавляем простую защиту от уменьшения стамины
    if not newCode:find("module_upvr%.Stamina = module_upvr%.MaxStamina") then
        newCode = newCode:gsub(
            "module_upvr%.Stamina = module_upvr%.MaxStamina", 
            "module_upvr.Stamina = module_upvr.MaxStamina\n\n\t-- Бесконечная стамина\n\ttask.spawn(function()\n\t\twhile true do\n\t\t\twait(0.5)\n\t\t\tmodule_upvr.Stamina = module_upvr.MaxStamina\n\t\t\tif module_upvr.__staminaChangedEvent then\n\t\t\t\tmodule_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)\n\t\t\tend\n\t\tend\n\tend)"
        )
    end
    
    sprintingScript.Source = newCode
    print("✅ Простая модификация выполнена!")
    return true
end

-- Запускаем основной метод
local success, errorMsg = pcall(ModifySprintingScript)

if not success then
    print("🔄 Основной метод не сработал, пробуем простой...")
    warn("Ошибка: " .. tostring(errorMsg))
    pcall(SimpleModification)
end

print("🎯 Модификация Sprinting завершена!")
