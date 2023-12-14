function notifyIngenBilerLager()
    lib.notify({
        id = 'biler',
        title = 'Lager tomt',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'list',
        iconColor = '#C53030'
    })
end

function notifyCanceled()
    lib.notify({
        id = 'biler1',
        title = 'Du fortrød',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'circle-xmark',
        iconColor = '#C53030'
    })
end

function notifyCarRemoved()
    lib.notify({
        id = 'biler2',
        title = 'Demo fjernet',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'circle-xmark',
        iconColor = '#C53030'
    })
end

function notifyCarDemo(veh)
    lib.notify({
        id = 'biler3',
        title = 'Fremviste '..veh,
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'car',
        iconColor = '#0afc12'
    })
end

function notifyIngenPlads(veh)
    lib.notify({
        id = 'biler4',
        title = 'Der ikke plads til '..veh,
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'car',
        iconColor = '#C53030'
    })
end

function notifyNoPlayers()
    lib.notify({
        id = 'biler5',
        title = 'Ingen i nærheden',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'circle-xmark',
        iconColor = '#C53030'
    })
end

function notifyVehicleBought(name)
    lib.notify({
        id = 'biler6',
        title = name..' er blevet købt',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'car',
        iconColor = '#0afc12'
    })
end

function notifyNoVehicleBought()
    lib.notify({
        id = 'biler7',
        title = 'Ikke nok penge',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'circle-xmark',
        iconColor = '#C53030'
    })
end

function notifyVehicleSoldToFactory(plate, finalPrice)
    lib.notify({
        id = 'biler8',
        title = plate..' solgt til '..ESX.Math.Round(finalPrice)..' DKK',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'circle-check',
        iconColor = '#0afc12'
    })
end

function notifyPlayerHasNoMoney()
    lib.notify({
        id = 'biler9',
        title = 'Har ikke nok penge',
        position = 'right-top',
        style = Config.Notify.Style,
        icon = 'money-bill',
        iconColor = '#0afc12'
    })
end