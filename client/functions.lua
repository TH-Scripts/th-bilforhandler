function getCars()
    ESX.TriggerServerCallback('th-bilforhandler:fetchCars', function(data) 
        carsStock = {}

        for _,v in pairs(data) do
            bilModel = v.model
            table.insert(carsStock, {
                title = 'Model ' ..v.model,
                description = 'Pris '..v.pris,
                onSelect = function()
                    lib.showContext('biler_valgmuligheder')
                end
            })
        end

        lib.registerContext({
            id = 'biler_valgmuligheder',
            title = 'Biler',
            options = {
                {
                    title = 'Fremvis køretøj',
                    description = 'Fremvis køretøjet '..bilModel,
                    onSelect = function()
                        print('spawn function til køretøjet')
                        spawnCar(bilModel)
                    end
                },
                {
                    title = 'Sælg køretøjet',
                    description = 'Sælg køretøjet tilbage til fabrikken ' ..bilModel,
                    onSelect = function()
                        print('sælg køretøj fabrikken')
                    end
                }
            }
        })

        lib.registerContext({
            id = 'biler',
            title = 'Biler',
            options = carsStock,
        })

        lib.showContext('biler')
    end)
end


function spawnCar(veh)
    local spawnedCar = false
  
    for _, spawnPoint in ipairs(Config.demoSpawnPoints) do
      local spawnCoords = spawnPoint.coords
      local radius = spawnPoint.radius
      local isSpawnPointClear = ESX.Game.IsSpawnPointClear(spawnCoords, radius)
  
      if isSpawnPointClear then
        -- If the spawn point is clear, spawn the car using ESX's spawnVehicle function
        ESX.Game.SpawnVehicle('' .. veh .. '', spawnCoords, spawnPoint.heading, function(vehicle)
          lib.notify({
            title = 'Success',
            description = 'Køretøjet er blevet hentet fra lageret',
            type = 'success',
          })
        end)
        spawnedCar = true
        break
        -- Don't break, let it continue checking other spawn points
      end
    end
  
      if not spawnedCar then
        -- If all spawn points are occupied, handle as needed (e.g., inform the player)
        lib.notify({
          title = 'Fejl',
          description = 'Der er ikke plads til køretøjet',
          type = 'error',
        })
      end
  end