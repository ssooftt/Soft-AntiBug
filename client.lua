local bugeandopared = false
local cerca = 1

Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId(), true)
		for i = 1, #Config.zonas do
			dist = Vdist(coords, Config.zonas[i].x, Config.zonas[i].y, Config.zonas[i].z)
			if dist <= 0.5 then
				bugeandopared = true
				cerca = i
			end
		end
		Citizen.Wait(3000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId(), true)
		local dist = Vdist(coords, Config.zonas[cerca].x, Config.zonas[cerca].y, Config.zonas[cerca].z)
		if bugeandopared == true then
			if IsPedInCover(PlayerPedId(), true) then
				DisablePlayerFiring(PlayerPedId(), true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 106, true)
				if IsDisabledControlJustPressed(0, 25) or IsDisabledControlJustPressed(0, 106) then
					exports['mythic_notify']:DoHudText(Config.mythic_type, Config.notif)
				end
			end
		end
	end
end)