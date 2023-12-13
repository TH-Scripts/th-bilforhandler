lib.registerContext({
    id = 'main_menu',
    title = 'Bilforhandler menu',
    options = {
      {
        title = Config.Title
      },
      {
        title = 'Sælg et køretøj',
        description = 'Vælg den nærmeste spiller',
        icon = 'user',
        onSelect = function()
          local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
          if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            notifyNoPlayers()
          else
            getPlayers()
          end
        end
      },
      {
        title = 'Lager',
        description = 'Lageret af nuværende biler',
        icon = 'list',
        onSelect = function()
          getCars()
        end
      },
      {
        title = 'Køb biler',
        description = 'Køb en bil fra lageret',
        icon = 'clipboard',
        onSelect = function()
          lagerMenu()
        end
      },
    }
  })