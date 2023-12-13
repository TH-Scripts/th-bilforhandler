Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports["es_extended"]:getSharedObject()
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function fetchLagerCars(category)
    local elements = {}
    
    ESX.TriggerServerCallback('th-bilforhandler:carsLager', function(vehicles) 
      for i=1, #vehicles, 1 do
          table.insert(elements, {
              title = 'Køretøj: '..vehicles[i].name,
              description = 'PRIS: '..vehicles[i].price.. ' DKK \nKATEGORI: '..vehicles[i].category.. '\nMODEL: '..vehicles[i].model,
              onSelect = function()
                local vehicleModel = vehicles[i].model
                local vehiclePrice = vehicles[i].price
                local vehicleName = vehicles[i].name
                buyVehicle(vehicleModel, vehiclePrice, vehicleName)
              end 
          })
      end

      lib.registerContext({
          id = 'lager_cars2',
          title = 'Lager',
          menu = 'lager_cars',
          onBack = function()
          end,
          options = elements
      })

      lib.showContext('lager_cars2')
  end, category)
end

function lagerMenu()

  elements = {}

  for category, data in pairs(Config.bilKategorier) do
      table.insert(elements, {
        title = data.title,
        description = data.description,
        icon = data.icon,
        onSelect = function()
          fetchLagerCars(category)
        end
      })
  end 

  lib.registerContext({
    id = 'lager_cars',
    title = 'Bil kategorier',
    menu = 'main_menu',
    onBack = function()
    end,
    options = elements
  })

  lib.showContext('lager_cars')
end

function buyVehicle(model, price, name)
    local alert = lib.alertDialog({
        header = 'Køb bil',
        content = 'KØRETØJ: \n'..name.. '\n\n PRIS: '..price,
        centered = true,
        cancel = true,
        labels = {
          cancel = 'Fortryd',
          confirm = 'Køb bilen'
        }
    })

    if alert == 'confirm' then
      TriggerServerEvent('th-bilforhandler:buyCarsToStock', model, price)
    else
      notifyCanceled()
    end

end

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
                    print('name')
                  end
                })
            end
        end


        lib.registerContext({
            id = 'sellveh_menu',
            title = 'Sælg køretøj',
            options = elements,
        })
        lib.showContext('sellveh_menu')
    end, closePlayer)
end
