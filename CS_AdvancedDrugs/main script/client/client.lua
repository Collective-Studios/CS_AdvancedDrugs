--
--░█████╗░██████╗░██╗░░░██╗░█████╗░███╗░░██╗░█████╗░███████╗██████╗░  ██████╗░██████╗░██╗░░░██╗░██████╗░░██████╗
--██╔══██╗██╔══██╗██║░░░██║██╔══██╗████╗░██║██╔══██╗██╔════╝██╔══██╗  ██╔══██╗██╔══██╗██║░░░██║██╔════╝░██╔════╝
--███████║██║░░██║╚██╗░██╔╝███████║██╔██╗██║██║░░╚═╝█████╗░░██║░░██║  ██║░░██║██████╔╝██║░░░██║██║░░██╗░╚█████╗░
--██╔══██║██║░░██║░╚████╔╝░██╔══██║██║╚████║██║░░██╗██╔══╝░░██║░░██║  ██║░░██║██╔══██╗██║░░░██║██║░░╚██╗░╚═══██╗
--██║░░██║██████╔╝░░╚██╔╝░░██║░░██║██║░╚███║╚█████╔╝███████╗██████╔╝  ██████╔╝██║░░██║╚██████╔╝╚██████╔╝██████╔╝
--╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░╚════╝░╚══════╝╚═════╝░  ╚═════╝░╚═╝░░╚═╝░╚═════╝░░╚═════╝░╚═════╝░

--Usage 
--/consume-weed <amount> 
--/consume-coke <amount>
--/consume-lean <amount>
--/consume-percs <amount>
--/consume-N2O <amount>

--The amount of drugs you take will effect the duration
--Config

--Enable overdose
local OD = true

--Enable killhigh command?
local kh = true

--Duration of weed effect 
local WadLWeedDura = 60*1000

--Duration of coke effect 
local WadLCokeDura = 40*1000

--Duration of lean effect 
local WadLLeanDura = 120*1000

--Duration of percs effect 
local WadLMethDura = 80*1000

--Duration of N2O effect 
local WadLN2ODura = 5*1000

--CODE--
prefix = "" -- dont change this 
high = false 
DisabledRun = false

Citizen.CreateThread(function()
		Citizen.Wait(0)
		if DisabledRun == true then
			DisableControlAction(0,21,true)
			
		end
end)


RegisterCommand("consume-weed", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('notify:skeexsNotify', {
			args = {"WadL Drugs", "^2Correct usage of command is ^*/consume-weed <amount>"},
			exports["skeexsNotify"]:TriggerNotification({
				['type'] = "error",
				['message'] = 'Correct usage of command is /consume-weed [ammount]'
			  })
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have smoked ".. amount.." gram(s) of weed"},
			exports["skeexsNotify"]:TriggerNotification({
				['type'] = "success",
				['message'] = 'You have smoked '.. amount..' gram(s) of weed'
			  })
		})
		ShakeGameplayCam('DRUNK_SHAKE', 0.35)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("move_m@muscle@a")
		local FadeTime = (WadLWeedDura/10)
		high = true
		SetTimecycleModifier('BloomMid')
		Citizen.Wait(WadLWeedDura*amount)
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
	else 
	TriggerEvent('notify:skeexsNotify', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"},
		exports["skeexsNotify"]:TriggerNotification({
			['type'] = "error",
			['message'] = 'You are already high'
		  })
	})
	end
end)

RegisterCommand("consume-coke", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('notify:skeexsNotify', {
			args = {"WadL Drugs", "^2Correct usage of command is ^*/consume-coke <amount>"},
			exports["skeexsNotify"]:TriggerNotification({
				['type'] = "error",
				['message'] = 'Correct usage of command is /consume-coke [ammount]'
			  })
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have snorted ".. amount.." gram(s) of coke"},
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "error",
				['message'] = ' You have snorted '.. amount..' gram(s) of coke '
			})
		})
	
		-- Drug Effects
		ShakeGameplayCam('SKY_DIVING_SHAKE', 0.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		--runAnim("move_m@drunk@moderatedrunk")
		local FadeTime = (WadLCokeDura/10)
		--SetPedMoveRateOverride(source, 5.0)
		SetRunSprintMultiplierForPlayer(source, 1.49)
		high = true
		SetTimecycleModifier('Bloom')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLCokeDura*amount)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		--SetPedMoveRateOverride(source, 0)
		runAnim("move_m@drunk@moderatedrunk")
		Citizen.Wait(15000)
		local r = math.random(1,30)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'Your body did not react well with the cocaine and you died'
				})
			})	
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 2 or amount > 2 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'You have died to an overdose'
				})
			})	
		end
	else
	TriggerEvent('notify:skeexsNotify', {
		color = { 255, 0, 0},
		multiline = true,
		exports["skeexsNotify"]:TriggerNotification({ 
			['type'] = "inform",
			['message'] = 'You are already high'
		})
	})	

	end
end)

RegisterCommand("consume-lean", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('notify:skeexsNotify', {
			exports["skeexsNotify"]:TriggerNotification({
				['type'] = "error",
				['message'] = 'Correct usage of command is /consume-lean [ammount]'
			  })
	})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "error",
				['message'] = ' You have drank '.. amount..' doublecup(s) (500ml each) of lean '
			})
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 4.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@SLIGHTLYDRUNK")
		high = true
		SetTimecycleModifier('BlackOut')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLLeanDura*amount)
		if amount == 0.5 or amount > 0.5 then
			SetPedToRagdoll(GetPlayerPed(-1), 7500, 7500, 0, 0, 0, 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "error",
					['message'] = ' You were very tired from the lean and fell asleep '
				})
			})
			Citizen.Wait(7500)
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 4 or amount > 4 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "error",
					['message'] = ' You have died to an overdose '
				})
			})
		end
	else 
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'You are already high'
			})
		})
	end
end)

RegisterCommand("consume-meth", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'Correct usage of command is ^*/consume-meth [amount]'
			})
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = '^You have injected '.. amount..' syringe(s) of meth'
			})
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 0.65)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP")
		--FOR TESTING
		Citizen.Wait(3)
		--END
		SetEntityHealth(GetPlayerPed(-1), 200)
		high = true
		SetTimecycleModifier('BeastIntro01')
		--Coming Down
		Citizen.Wait(WadLMethDura*amount)
		SetEntityHealth(GetPlayerPed(-1), 110)
		local r = math.random(1,20)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'Your body did not react well with the meth and you died'
				})
			})	
		end
		--ENDING THE HIGH
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 3 or amount > 3 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'You have died to an overdose'
			})
			})
		end
	else 
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'You are already high'
			})
		})
	end
end)

RegisterCommand("consume-n20", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'Correct usage of command is ^*/consume-N2O [amount]'
			})
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'You have sucked in '.. amount..' canister(s) of N2O'
			})
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 90.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@SLIGHTLYDRUNK")
		high = true
		SetTimecycleModifier('BarryFadeOut')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLN2ODura*amount)
		if amount == 1 or amount > 1 then
			SetPedToRagdoll(GetPlayerPed(-1), 7500, 7500, 0, 0, 0, 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'You passed out from the N2O'
				})
			})
			Citizen.Wait(7500)
		end
		local r = math.random(1,50)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'Your body did not react well with the N2O and you died'
				})
			})
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 5 or amount > 5 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('notify:skeexsNotify', {
				color = { 255, 0, 0},
				multiline = true,
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'You have died to an overdose'
				})
			})
		end
	else 
		TriggerEvent('notify:skeexsNotify', {
			color = { 255, 0, 0},
			multiline = true,
			exports["skeexsNotify"]:TriggerNotification({ 
				['type'] = "inform",
				['message'] = 'You are already high',
				exports["skeexsNotify"]:TriggerNotification({ 
					['type'] = "inform",
					['message'] = 'You are already high'
				})
			})
		})
	end
end)

RegisterCommand("stophigh", function(source, args, rawCommand)
	if kh == true then
		StopGameplayCamShaking(true)
		resetAnims()
		SetTransitionTimecycleModifier('default', 0.35)
		--SetPedMoveRateOverride(source, 0)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		SetEntityMaxHealth(GetPlayerPed(-1), 200)
	else
	TriggerEvent('notify:skeexsNotify', {
		color = { 255, 0, 0},
		multiline = true,
		exports["skeexsNotify"]:TriggerNotification({ 
			['type'] = "inform",
			['message'] = 'All effects have been removed'
		})
	})
	end
end)

function runAnim(anim)
	RequestAnimSet(anim)
	SetPedMovementClipset(GetPlayerPed(-1), anim, true)
end

function resetAnims()
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end

