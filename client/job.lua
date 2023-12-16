isBoss = true

function mainMenu()
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
            title = 'Bossmenu',
            description = 'Åben bossmenuen',
            icon = 'star',
            disabled = isBoss,
            onSelect = function()
                bossMenu()
            end
        },
        }
    })
    lib.showContext('main_menu')
end

function bossMenu()
    lib.registerContext({
        id = 'boss_menu',
        title = 'Boss menu',
        menu = 'main_menu',
        onBack = function()
        end,
        options = {
        {
            title = 'Køb biler',
            description = 'Køb en bil fra lageret',
            icon = 'clipboard',
            disabled = isBoss,
            onSelect = function()
                lagerMenu()
            end
        },
        {
            title = 'Database',
            description = 'Liste over solgte køretøjer',
            icon = 'database',
            disabled = isBoss,
            onSelect = function()
                dataBase()
            end
        },
        {
            title = 'Bossmenu',
            description = 'Åben bossmenuen',
            icon = 'star',
            disabled = isBoss,
            onSelect = function()
                TriggerEvent('esx_society:openBossMenu', Config.Job.Profession, function (data, menu)
                end) 
                -- indsæt evt. eget society 
            end
        },
        }
    })
    lib.showContext('boss_menu')
end 