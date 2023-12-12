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
                lib.showContext('main_menu')
            end
        },
    }
})

lib.registerContext({
    id = 'main_menu',
    title = 'Bilforhandler',
    options = {
      {
        title = Config.Title
      },
      {
        title = 'Sælg et køretøj',
        description = 'Vælg den nærmeste spiller',
        icon = 'user',
        onSelect = function()
            getPlayers()
        end
      }
    }
  })