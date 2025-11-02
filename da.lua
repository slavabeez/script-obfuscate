local function ModifyExistingSprintScript()
    local targetPath = game:GetService("ReplicatedStorage").Systems.Character.Game
    local sprintingScript = targetPath:FindFirstChild("Sprinting")
    
    if not sprintingScript then
        warn("❌ Скрипт Sprinting не найден по пути: " .. targetPath:GetFullName())
        return
    end
    
    if not sprintingScript:IsA("ModuleScript") then
        warn("❌ Объект Sprinting не является ModuleScript")
        return
    end
    
    -- Сохраняем оригинальный код для резервной копии
    local originalCode = sprintingScript.Source
    
    -- Модифицируем код
    local modifiedCode = originalCode
    
    -- 1. Изменяем StaminaLossDisabled на true
    modifiedCode = modifiedCode:gsub("StaminaLossDisabled = false", "StaminaLossDisabled = true")
    
    -- 2. Добавляем поддержание стамины на максимуме
    if not modifiedCode:find("if module_upvr%.Stamina < module_upvr%.MaxStamina then") then
        -- Находим место где заканчивается основной цикл и вставляем наш код
        local insertPosition = modifiedCode:find("end)")
        if insertPosition then
            local maintenanceCode = [[
		if module_upvr.Stamina < module_upvr.MaxStamina then
			module_upvr.Stamina = module_upvr.MaxStamina
			module_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)
		end
]]
            modifiedCode = modifiedCode:sub(1, insertPosition-1) .. maintenanceCode .. modifiedCode:sub(insertPosition)
        end
    end
    
    -- Применяем изменения
    sprintingScript.Source = modifiedCode
    
    print("✅ Скрипт Sprinting успешно модифицирован!")
    print("📍 Бесконечная стамина активирована")
end

-- Альтернативный вариант - более точная замена
local function ReplaceSprintScriptCode()
    local targetPath = game:GetService("ReplicatedStorage").Systems.Character.Game
    local sprintingScript = targetPath:FindFirstChild("Sprinting")
    
    if not sprintingScript or not sprintingScript:IsA("ModuleScript") then
        warn("Скрипт Sprinting не найден")
        return
    end
    
    -- Полностью заменяем код на модифицированную версию
    local newCode = [[local module_upvr = {
	DefaultConfig = {
		IsSprinting = false;
		BindsEnabled = true;
		StaminaLossDisabled = false;
		MinStamina = 0;
		MaxStamina = 100;
		SprintSpeed = 26;
		StaminaLoss = 10;
		StaminaGain = 20;
	};
}
local Network_upvr = require(game.ReplicatedStorage.Modules.Network)
function module_upvr.ChangeStat(arg1, arg2, arg3)
	if module_upvr[arg2] then
		module_upvr[arg2] = arg3
	end
end
local TweenService_upvr = game:GetService("TweenService")
function module_upvr.Toggle(arg1, arg2)
	local var6 = game.Players.LocalPlayer.Character
	if var6 then
		var6 = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	end
	if not var6 then
	else
		if arg2 then
			TweenService_upvr:Create(module_upvr.__FOVMultiplier, TweenInfo.new(0.75), {
				Value = 1.125;
			}):Play()
			TweenService_upvr:Create(module_upvr.__speedMultiplier, TweenInfo.new(0.75), {
				Value = module_upvr.SprintSpeed / (var6:GetAttribute("BaseSpeed") or 16);
			}):Play()
			return
		end
		TweenService_upvr:Create(module_upvr.__FOVMultiplier, TweenInfo.new(0.75), {
			Value = 1;
		}):Play()
		TweenService_upvr:Create(module_upvr.__speedMultiplier, TweenInfo.new(0.75), {
			Value = 1;
		}):Play()
	end
end
function module_upvr.Init(arg1)
	local LocalPlayer = game.Players.LocalPlayer
	local Character_upvr = LocalPlayer.Character
	for i, v in pairs(module_upvr.DefaultConfig) do
		module_upvr[i] = v
	end
	module_upvr.StaminaCap = nil
	module_upvr.StaminaLossDisabled = true
	module_upvr.DefaultsSet = true
	module_upvr.__sprintedEvent = Instance.new("BindableEvent")
	module_upvr.__staminaChangedEvent = Instance.new("BindableEvent")
	module_upvr.__speedMultiplier = Instance.new("NumberValue")
	module_upvr.__speedMultiplier.Value = 1
	module_upvr.__speedMultiplier.Name = "Sprinting"
	module_upvr.__speedMultiplier.Parent = Character_upvr:WaitForChild("SpeedMultipliers", 10)
	module_upvr.__FOVMultiplier = Instance.new("NumberValue")
	module_upvr.__FOVMultiplier.Value = 1
	module_upvr.__FOVMultiplier.Name = "Sprinting"
	module_upvr.__FOVMultiplier.Parent = Character_upvr:WaitForChild("FOVMultipliers", 10)
	module_upvr.CanSprint = true
	module_upvr.SprintToggled = module_upvr.__sprintedEvent.Event
	module_upvr.StaminaChanged = module_upvr.__staminaChangedEvent.Event
	module_upvr.Stamina = module_upvr.MaxStamina
	module_upvr.SprintToggled:Connect(function(arg1_2)
		module_upvr:Toggle(arg1_2)
	end)
	local IsSprinting_upvw = module_upvr.IsSprinting
	local var20_upvw = 0
	local function _(arg1_3, arg2)
		local var22
		local function INLINED_3()
			var22 = module_upvr
			return var22.BindsEnabled
		end
		if not module_upvr.CanSprint or not INLINED_3() then
		else
			var22 = game.ReplicatedStorage.Modules.Device
			var22 = require(var22):GetPlayerDevice()
			if var22 == "Mobile" then
				var22 = Enum.UserInputState.Begin
				if arg2 ~= var22 then return end
				local function INLINED_4()
					var22 = Enum.UserInputState.End
					return var22
				end
				if not IsSprinting_upvw or not INLINED_4() then
					var22 = Enum.UserInputState.Begin
				end
			end
			var22 = Enum.UserInputState.Begin
			if var22 == var22 then
				var22 = module_upvr.Stamina
				if module_upvr.MinStamina < var22 then
					var22 = module_upvr.IsSprinting
					if not var22 then
						var22 = module_upvr
						var22.IsSprinting = true
						var22 = module_upvr.__sprintedEvent:Fire
						var22(true)
						var22 = module_upvr.IsSprinting
						IsSprinting_upvw = var22
						return
					end
				end
			end
			var22 = module_upvr.IsSprinting
			if var22 then
				var22 = module_upvr
				var22.IsSprinting = false
				var22 = module_upvr.__sprintedEvent:Fire
				var22(false)
				var22 = module_upvr.IsSprinting
				IsSprinting_upvw = var22
				var22 = var20_upvw
				if 0.1 < var22 then
					var22 = math.clamp(var20_upvw + 0.1, 0, 3)
					var20_upvw = var22
					return
				end
				var22 = 0.1
				var20_upvw = var22
			end
		end
	end
	task.spawn(function()
		if not nil then
		end
		if not nil then
		end
		if nil then
			if nil < nil then
				if nil < nil then
					if nil and not nil and nil ~= "Spectating" then
						if not nil then
						end
						if nil <= nil then
						end
					end
				end
			end
		end
		if module_upvr.Stamina < module_upvr.MaxStamina then
			module_upvr.Stamina = module_upvr.MaxStamina
			module_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)
		end
	end)
	local Keybinds = LocalPlayer.PlayerData.Settings.Keybinds
	local _, _, _ = pairs({Keybinds.Sprinting.Value, Keybinds["Sprinting~Console"].Value})
	local _, _, _ = pairs(Enum.KeyCode:GetEnumItems())
end
function module_upvr.Destroy(arg1)
	Network_upvr:RemoveConnection("DisableSprinting", "REMOTE_EVENT")
	Network_upvr:RemoveConnection("DisableSprintingSV", "BINDABLE_EVENT")
	Network_upvr:RemoveConnection("GrantStamina", "REMOTE_EVENT")
	module_upvr.__sprintedEvent:Destroy()
	module_upvr.__staminaChangedEvent:Destroy()
	module_upvr.__speedMultiplier:Destroy()
	module_upvr.__FOVMultiplier:Destroy()
end
return module_upvr]]
    
    sprintingScript.Source = newCode
    print("✅ Код скрипта Sprinting полностью заменен!")
end

-- Автоматически выполняем при запуске
wait(2) -- Даем время на загрузку игры

-- Пробуем сначала модифицировать, если не получится - заменяем полностью
local success, error = pcall(ModifyExistingSprintScript)
if not success then
    print("⚠️ Модификация не удалась, пробуем полную замену...")
    pcall(ReplaceSprintScriptCode)
end

print("🎯 Операция завершена!")
