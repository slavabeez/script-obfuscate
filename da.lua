-- LocalScript в StarterPlayerScripts или Script в ServerScriptService
local function CreateInfiniteSprintScript()
    -- Проверяем существование целевой папки
    local targetFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Systems")
    if not targetFolder then
        warn("Папка Systems не найдена в ReplicatedStorage!")
        return
    end
    
    targetFolder = targetFolder:FindFirstChild("Character")
    if not targetFolder then
        warn("Папка Character не найдена!")
        return
    end
    
    targetFolder = targetFolder:FindFirstChild("Game")
    if not targetFolder then
        warn("Папка Game не найдена!")
        return
    end
    
    -- Проверяем, существует ли уже скрипт
    local existingScript = targetFolder:FindFirstChild("Sprinting")
    if existingScript then
        print("Скрипт Sprinting уже существует. Удаляем старую версию...")
        existingScript:Destroy()
        wait(0.1) -- Даем время на удаление
    end
    
    -- Создаем новый ModuleScript
    local sprintModule = Instance.new("ModuleScript")
    sprintModule.Name = "Sprinting"
    
    -- Код модифицированного скрипта спринта
    local sprintCode = [[-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-11-02 05:26:41
-- Luau version 6, Types version 3
-- Time taken: 0.006934 seconds

local module_upvr = {
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
function module_upvr.ChangeStat(arg1, arg2, arg3) -- Line 21
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if module_upvr[arg2] then
		module_upvr[arg2] = arg3
	end
end
local TweenService_upvr = game:GetService("TweenService")
function module_upvr.Toggle(arg1, arg2) -- Line 27
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
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
function module_upvr.Init(arg1) -- Line 44
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Network_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 39 start (CF ANALYSIS FAILED)
	local LocalPlayer = game.Players.LocalPlayer
	local Character_upvr = LocalPlayer.Character
	for i, v in pairs(module_upvr.DefaultConfig) do
		module_upvr[i] = v
	end
	module_upvr.StaminaCap = nil
	module_upvr.StaminaLossDisabled = true -- ИЗМЕНЕНО: Бесконечная стамина
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
	module_upvr.SprintToggled:Connect(function(arg1_2) -- Line 79
		--[[ Upvalues[1]:
			[1]: module_upvr (copied, readonly)
		]]
		module_upvr:Toggle(arg1_2)
	end)
	local IsSprinting_upvw = module_upvr.IsSprinting
	local var20_upvw = 0
	local function _(arg1_3, arg2) -- Line 86, Named "sprint"
		--[[ Upvalues[3]:
			[1]: module_upvr (copied, readonly)
			[2]: IsSprinting_upvw (read and write)
			[3]: var20_upvw (read and write)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var22
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
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
				local function INLINED_4() -- Internal function, doesn't exist in bytecode
					var22 = Enum.UserInputState.End
					return var22
				end
				if not IsSprinting_upvw or not INLINED_4() then
					var22 = Enum.UserInputState.Begin
				end
			end
			var22 = Enum.UserInputState.Begin
			if var22 == var22 then
				-- ИЗМЕНЕНО: Убрана проверка на минимальную стамину
				-- Теперь можно спринтовать даже с 0 стаминой
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
	task.spawn(function() -- Line 118
		--[[ Upvalues[4]:
			[1]: Character_upvr (readonly)
			[2]: module_upvr (copied, readonly)
			[3]: var20_upvw (read and write)
			[4]: IsSprinting_upvw (read and write)
		]]
		-- KONSTANTERROR: [211] 150. Error Block 28 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [211] 150. Error Block 28 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 46 start (CF ANALYSIS FAILED)
		-- КОММЕНТАРИЙ: Закомментирован код расходования стамины при беге
		-- ИЗМЕНЕНО: Убрана логика уменьшения стамины во время спринта
		-- КОММЕНТАРИЙ: Добавлено поддержание стамины на максимуме
		if module_upvr.Stamina < module_upvr.MaxStamina then
			module_upvr.Stamina = module_upvr.MaxStamina
			module_upvr.__staminaChangedEvent:Fire(module_upvr.Stamina)
		end
		-- KONSTANTERROR: [0] 1. Error Block 46 end (CF ANALYSIS FAILED)
	end)
	local Keybinds = LocalPlayer.PlayerData.Settings.Keybinds
	local _, _, _ = pairs({Keybinds.Sprinting.Value, Keybinds["Sprinting~Console"].Value})
	-- KONSTANTERROR: [0] 1. Error Block 39 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [181] 125. Error Block 4 start (CF ANALYSIS FAILED)
	local _, _, _ = pairs(Enum.KeyCode:GetEnumItems())
	-- KONSTANTERROR: [181] 125. Error Block 4 end (CF ANALYSIS FAILED)
end
function module_upvr.Destroy(arg1) -- Line 254
	--[[ Upvalues[2]:
		[1]: Network_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	Network_upvr:RemoveConnection("DisableSprinting", "REMOTE_EVENT")
	Network_upvr:RemoveConnection("DisableSprintingSV", "BINDABLE_EVENT")
	Network_upvr:RemoveConnection("GrantStamina", "REMOTE_EVENT")
	module_upvr.__sprintedEvent:Destroy()
	module_upvr.__staminaChangedEvent:Destroy()
	module_upvr.__speedMultiplier:Destroy()
	module_upvr.__FOVMultiplier:Destroy()
end
return module_upvr]]
    
    sprintModule.Source = sprintCode
    sprintModule.Parent = targetFolder
    
    print("✅ Модифицированный скрипт Sprinting успешно создан!")
    print("📍 Расположение: " .. sprintModule:GetFullName())
    print("⚡ Бесконечная стамина активирована!")
    
    return sprintModule
end

-- Дополнительная функция для проверки и автоматического создания
local function EnsureSprintingScript()
    local targetPath = game:GetService("ReplicatedStorage").Systems.Character.Game
    local sprintScript = targetPath:FindFirstChild("Sprinting")
    
    if not sprintScript then
        print("Скрипт Sprinting не найден. Создаем...")
        CreateInfiniteSprintScript()
    else
        print("Скрипт Sprinting уже существует:")
        print("📍 " .. sprintScript:GetFullName())
        
        -- Проверяем, наш ли это модифицированный скрипт
        if sprintScript:IsA("ModuleScript") then
            local source = sprintScript.Source
            if source:find("StaminaLossDisabled = true") then
                print("✅ Это наш модифицированный скрипт с бесконечной стаминой!")
            else
                print("⚠️ Найден оригинальный скрипт. Заменяем на модифицированный...")
                CreateInfiniteSprintScript()
            end
        end
    end
end

-- Автоматически выполняем при запуске
wait(2) -- Даем время на загрузку игры
EnsureSprintingScript()

-- Создаем кнопку в GUI для ручного создания (опционально)
local function CreateControlGUI()
    local player = game.Players.LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local button = Instance.new("TextButton")
    local label = Instance.new("TextLabel")
    
    screenGui.Name = "SprintInstaller"
    screenGui.Parent = player.PlayerGui
    
    frame.Size = UDim2.new(0, 200, 0, 120)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "Sprint Installer"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = frame
    
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0.5, 0)
    button.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
    button.Text = "Install Infinite Sprint"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Parent = frame
    
    button.MouseButton1Click:Connect(function()
        CreateInfiniteSprintScript()
        button.Text = "✅ Installed!"
        button.BackgroundColor3 = Color3.new(0, 1, 0)
        wait(2)
        screenGui:Destroy()
    end)
end

-- Создаем GUI если это LocalScript
if script:IsA("LocalScript") then
    CreateControlGUI()
end
