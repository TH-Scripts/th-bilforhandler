exports.ox_target:addSphereZone({
    coords = Config.Job.Menu.targetCoords, 
    radius = 1,
    debug = drawZones,
    options = {
        {
            icon = 'fa-solid fa-hashtag',
            label = 'Job menu',
            groups = Config.Job.Profession,
            onSelect = function()
                mainMenu()
            end
        },
    }
})

for _, spawnPoint in ipairs(Config.demoSpawnPoints) do
    exports.ox_target:addSphereZone({
        coords = spawnPoint.coords,
        radius = 1,
        debug = drawZones,
        options = {
            {
                icon = 'fa-solid fa-hashtag',
                label = 'Fjern Køretøjet',
                groups = Config.Job.Profession,
                onSelect = function()
                    local vehicle = ESX.Game.GetVehicleInDirection()

                    if DoesEntityExist(vehicle) then
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end
            },
        }
    })
end
