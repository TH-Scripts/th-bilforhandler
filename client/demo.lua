function spawnCar(veh)
    local spawnedCar = false

    for _, spawnPoint in ipairs(Config.demoSpawnPoints) do
        local spawnCoords = spawnPoint.coords
        local radius = spawnPoint.radius
        local isSpawnPointClear = ESX.Game.IsSpawnPointClear(spawnCoords, radius)

        if isSpawnPointClear then
            bil = veh
            ESX.Game.SpawnVehicle('' .. bil .. '', spawnCoords, spawnPoint.heading, function(vehicle)
                notifyCarDemo(bil)
            end)
            print(bil)
            SetVehicleNumberPlateText(bil, 'DEMO')
            spawnedCar = true
            break
        end
    end

    if not spawnedCar then
        notifyIngenPlads(veh)
    end
end

function sellVehicle(nummerPlade)
    print(nummerPlade)

    local alert = lib.alertDialog({
        header = 'Sælg',
        content = 'Ønsker du at sælge køretøjet?',
        centered = true,
        cancel = true,
        labels = {
            cancel = 'Fortryd',
            confirm = 'Ja, sælg køretøjet'
        }
    })

    if alert == 'confirm' then
        TriggerServerEvent('th-bilforhandler:sellVehicle', nummerPlade)
    else
        notifyCanceled()
    end

end

function getCars()
  ESX.TriggerServerCallback('th-bilforhandler:fetchCars', function(data) 
      carsStock = {}

      if next(data) == nil then
        notifyIngenBilerLager()
    else
        for _, v in pairs(data) do
            local bilModel = v.model
            local nummerPlade = v.nummerplade
            table.insert(carsStock, {
                title = 'MODEL: ' .. v.model,
                description = 'PRIS: ' .. v.pris.. '\n NUMMERPLADE: '..v.nummerplade,
                icon = 'car-side',
                onSelect = function()
                    carChoose(bilModel, nummerPlade)
                end
            })
        end
        lib.registerContext({
          id = 'biler',
          title = 'Biler',
          menu = 'main_menu',
          onBack = function()
          end,
          options = carsStock,
      })

      lib.showContext('biler')

    end
  end)
end

function carChoose(bilModel, nummerPlade)
    lib.registerContext({
        id = 'køretøj_menu',
        title = 'Køretøj: '..bilModel,
        menu = 'biler',
        onBack = function()
            getCars()
        end,
        options = {
          {
            title = 'Fremvis '..bilModel,
            icon = 'eye',
            
            onSelect = function()
                spawnCar(bilModel)
            end
          },
          {
            title = 'Sælg '..bilModel,
            icon = 'coins',
            onSelect = function()
                sellVehicle(nummerPlade)
            end
          },
        }
      })
      lib.showContext('køretøj_menu')
end