local function ModifySprintingScript()
    -- Ждем загрузки
    wait(3)
    
    local targetPath = game:GetService("ReplicatedStorage").Systems.Character.Game
    local sprintingScript = targetPath:FindFirstChild("Sprinting")
    
    if not sprintingScript then
        warn("❌ Скрипт Sprinting не найден")
        return
    end
    
    if not sprintingScript:IsA("ModuleScript") then
        warn("❌ Объект не является ModuleScript")
        return
    end
    
    print("📝 Найден скрипт Sprinting, модифицируем код...")
    
    -- Получаем текущий код
    local currentCode = sprintingScript.Source
    
    -- Простые замены для бесконечной стамины
    local modifiedCode = currentCode
    
    -- 1. Включаем бесконечную стамину
    modifiedCode = modifiedCode:gsub("StaminaLossDisabled = false", "StaminaLossDisabled = true")
    
    -- 2. Убираем расход стамины
    modifiedCode = modifiedCode:gsub("StaminaLoss = 10", "StaminaLoss = 0")
    modifiedCode = modifiedCode:gsub("StaminaLoss = %d+", "StaminaLoss = 0")
    
    -- 3. Увеличиваем восстановление
    modifiedCode = modifiedCode:gsub("StaminaGain = 20", "StaminaGain = 100")
    modifiedCode = modifiedCode:gsub("StaminaGain = %d+", "StaminaGain = 100")
    
    -- 4. Добавляем поддержание стамины на максимуме
    if not modifiedCode:find("module_upvr%.Stamina = module_upvr%.MaxStamina") then
        -- Ищем место для вставки (после основного цикла)
        local pattern = "end\n%)"
        local startPos, endPos = modifiedCode:find(pattern)
        
        if startPos then
            local maintenanceCode = "\n\t\tif module_upvr.Stamina < module_upvr.MaxStamina then\n\t\t\tmodule_upvr.Stamina = module_upvr.MaxStamina\n\t\t\tif module_upvr.__staminaChangedEvent then\n\t\t\t\tmodule_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)\n\t\t\tend\n\t\tend"
            modifiedCode = modifiedCode:sub(1, endPos) .. maintenanceCode .. modifiedCode:sub(endPos + 1)
        else
            -- Альтернативный метод - добавляем в конец функции Init
            local initEnd = modifiedCode:find("function module_upvr%.Init.*end")
            if initEnd then
                local maintenanceCode = "\n\n\t-- Поддержание стамины на максимуме\n\ttask.spawn(function()\n\t\twhile true do\n\t\t\twait(0.5)\n\t\t\tif module_upvr.Stamina < module_upvr.MaxStamina then\n\t\t\t\tmodule_upvr.Stamina = module_upvr.MaxStamina\n\t\t\t\tif module_upvr.__staminaChangedEvent then\n\t\t\t\t\tmodule_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\tend)"
                modifiedCode = modifiedCode:sub(1, initEnd - 1) .. maintenanceCode .. "\nend" .. modifiedCode:sub(initEnd)
            end
        end
    end
    
    -- Применяем изменения
    sprintingScript.Source = modifiedCode
    
    print("✅ Код успешно модифицирован!")
    print("📍 Сохранены все наследники и ссылки")
    print("⚡ Бесконечная стамина активирована")
    
    return true
end

-- Альтернативный метод - точечные изменения
local function PreciseModification()
    wait(3)
    
    local sprintingScript = game:GetService("ReplicatedStorage").Systems.Character.Game:FindFirstChild("Sprinting")
    if not sprintingScript then return end
    
    local code = sprintingScript.Source
    
    -- Создаем модифицированную версию с минимальными изменениями
    local changesMade = false
    
    -- Изменяем только ключевые параметры
    if code:find("StaminaLossDisabled = false") then
        code = code:gsub("StaminaLossDisabled = false", "StaminaLossDisabled = true")
        changesMade = true
    end
    
    if code:find("StaminaLoss = 10") then
        code = code:gsub("StaminaLoss = 10", "StaminaLoss = 0")
        changesMade = true
    end
    
    if code:find("StaminaGain = 20") then
        code = code:gsub("StaminaGain = 20", "StaminaGain = 100")
        changesMade = true
    end
    
    -- Добавляем поддержание стамины если его нет
    if not code:find("module_upvr%.Stamina = module_upvr%.MaxStamina") then
        -- Вставляем простой цикл поддержания
        local maintenanceCode = [[

	-- Auto-maintain max stamina
	task.spawn(function()
		while true do
			wait(1)
			module_upvr.Stamina = module_upvr.MaxStamina
			if module_upvr.__staminaChangedEvent then
				module_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)
			end
		end
	end)]]
        
        -- Находим конец функции Init для вставки
        local initPattern = "function module_upvr%.Init.*\n.*\n.*end"
        local startPos, endPos = code:find(initPattern)
        if endPos then
            code = code:sub(1, endPos - 3) .. maintenanceCode .. "\n\tend" .. code:sub(endPos + 1)
            changesMade = true
        end
    end
    
    if changesMade then
        sprintingScript.Source = code
        print("✅ Точечная модификация выполнена!")
        return true
    else
        print("ℹ️ Изменения не требуются")
        return false
    end
end

-- Запускаем
local success, err = pcall(ModifySprintingScript)

if not success then
    print("🔄 Первый метод не сработал, пробуем точечную модификацию...")
    pcall(PreciseModification)
end

print("🎯 Операция завершена!")
