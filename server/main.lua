ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('th-bilforhandler:buyCarsToStock', function(model, price)
    randomPlate = GenerateUniquePlate()

    MySQL.insert('INSERT INTO th_lager (model, nummerplade, pris) VALUES (?, ?, ?)', {
        model, randomPlate, price
    })

end)

RegisterNetEvent('th-bilforhandler:sellVehicle', function(plate)
    print(plate)
    
    MySQL.Async.execute('DELETE FROM th_lager WHERE nummerplade = @nummerplade', {
        ['@nummerplade'] = plate
    })
end)

ESX.RegisterServerCallback('th-bilforhandler:fetchCars', function(source, cb)
    local cars = MySQL.query.await('SELECT model, nummerplade, pris FROM th_lager')
    cb(cars)
end)

ESX.RegisterServerCallback('th-bilforhandler:carsLager', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM th_vehicles WHERE category = ?', {
        category
    }, function(response)
        if response then    
            for k,v in ipairs(response) do
                cb(response)
                break
            end
        end
    end)
end)

ESX.RegisterServerCallback('th-bilforhandler:getNearestPlayers', function(source, cb, closePlayer)
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

ESX.RegisterServerCallback('th-bilforhandler:isPlateTaken', function(source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
	function(result)
		cb(result ~= nil)
	end)
end)
