ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('th-bilforhandler:fetchCars', function(source, cb)
    local cars = MySQL.query.await('SELECT model, nummerplade, pris FROM th_lager')
    cb(cars)
end)



ESX.RegisterServerCallback('th-bilforhandler:vehicleBuy', function(source, cb, vehicleAmount)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in ipairs(vehicles) do
        if model == v.model then
            modelPrice = v.price
            break
        end
    end
end)

ESX.RegisterServerCallback('th-bilforhandler:getNearestPlayers', function(source, cb, closePlayer)
    print(closePlayer)
    local xPlayer = ESX.GetPlayerFromId(closePlayer)
	local players = {}

    if xPlayer.get('firstName') then
        table.insert(players, {
            source = xPlayer.source,
            identifier = xPlayer.identifier,
            name = xPlayer.name,
            firstname = xPlayer.get('firstName'),
            lastname = xPlayer.get('lastName'),
        })
    end
	cb(players)
end)

RegisterNetEvent('th-bilforhandler:sellVeh', function(playerId)
    local license = GetPlayerIdentifierByType(playerId, 'license')
    print(license)


end)