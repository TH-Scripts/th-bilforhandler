ESX = exports["es_extended"]:getSharedObject()

local Vehciles, Categories = {}, {} 

RegisterNetEvent('th-bilforhandler:sendCategories')
AddEventHandler('th-bilforhandler:sendCategories', function(categories)
	Categories = categories
end)

RegisterNetEvent('th-bilforhandler:sendVehicles')
AddEventHandler('th-bilforhandler:sendVehicles', function(vehicles)
	Vehicles = vehicles
end)

RegisterCommand('bilforhandler', function()
	getPlayers()
end)

function getPlayers()
	local closestplayer = ESX.Game.GetClosestPlayer()
	local closePlayer = GetPlayerServerId(closestplayer)

	ESX.TriggerServerCallback('th-bilforhandler:getNearestPlayers', function(players)
		local elements = {}

		for i=1, #players, 1 do
			if players[i].name ~= GetPlayerName(PlayerId()) then
				local playerId = players[i].source
				table.insert(elements, {
					title = 'Navn: ' .. players[i].firstname,
					description = 'Tryk her for at sælge vedkommende en bil',
					icon = 'hashtag',
					onSelect = function()
						local playerfirstname = players[i].firstname
						local lastNamePlayer = players[i].lastname
						TriggerServerEvent('th-bilforhandler:sellVeh')
					end
				})
			end

			lib.registerContext({
				id = 'sellveh_menu',
				title = 'Sælg køretøj',
				options = elements,
			})
			lib.showContext('sellveh_menu')
		end
	end, closePlayer)
end