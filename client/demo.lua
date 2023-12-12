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
      end
    end
  
    if not spawnedCar then
    lib.notify({
        title = 'Fejl',
        description = 'Der er ikke plads til køretøjet',
        type = 'error',
    })
    end
end