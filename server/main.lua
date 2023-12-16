ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx_society:registerSociety', Config.Job.Profession, Config.Job.Profession, Config.Job.Society, Config.Job.Society, Config.Job.Society, {type = 'public'})


ESX.RegisterServerCallback('th-bilforhandler:buyCarsToStock', function(source, cb, model, price)
    randomPlate = GenerateUniquePlate()
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function(account)
        if account.money > price then
            MySQL.insert('INSERT INTO th_lager (model, nummerplade, pris) VALUES (?, ?, ?)', {
                model, randomPlate, price
            })
            account.removeMoney(price)
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent('th-bilforhandler:sellVehicle', function(plate, price)
    
    MySQL.Async.execute('DELETE FROM th_lager WHERE nummerplade = @nummerplade', {
        ['@nummerplade'] = plate
    })

    local sellPrice = Config.SellVehicleProcent * price
    local finalPrice = price - sellPrice 

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function(account)
        account.addMoney(finalPrice)
    end)
end)

ESX.RegisterServerCallback('th-bilforhandler:fetchCars', function(source, cb)
    local cars = MySQL.query.await('SELECT model, nummerplade, pris FROM th_lager')
    cb(cars)
end)

ESX.RegisterServerCallback('th-bilforhandler:fetchDatabase', function(source, cb)
    local db = MySQL.query.await('SELECT id, bil, medarbejder, buyer, pris FROM th_sold')
    cb(db)
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

ESX.RegisterServerCallback('th-bilforhandler:sellVeh', function(source, cb, vehPrice, playerId, plate, model)
    xTarget = ESX.GetPlayerFromId(playerId)

    playerMoney = xTarget.getAccount('bank')

    if playerMoney.money >= vehPrice then
        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent('th-bilforhandler:removePlayerMoney', function(playerId, vehiclePrice, firstName ,lastName, model, seller)
    local xTarget = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(seller)
    local sellProcent = Config.Job.SellProcent
    local moneyToSeller = vehiclePrice * sellProcent
    local moneyToCompany = vehiclePrice - moneyToSeller
    moneyToSeller = ESX.Math.Round(moneyToSeller)
    print('money to seller '..moneyToSeller)

    xPlayer.addAccountMoney('bank', moneyToSeller)
    xTarget.removeAccountMoney('bank', vehiclePrice)

    TriggerEvent('esx_addonaccount:getSharedAccount', Config.Job.Society, function(account)
        account.addMoney(moneyToCompany)
        print('money to company '..moneyToCompany)
    end)
    TriggerClientEvent('th-bilforhandler:sellerCommission', seller, model, firstName, lastName, moneyToSeller)
end)

ESX.RegisterServerCallback('th-bilforhandler:isPlateTaken', function(source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
	function(result)
		cb(result ~= nil)
	end)
end)

RegisterNetEvent('th-bilforhandler:targetId', function(model, plate, firstName, lastName, playerId, vehiclePrice, seller)
    TriggerClientEvent('th-bilforhandler:targetIdClient', playerId, model, plate, firstName, lastName, playerId, vehiclePrice, seller)
end)

RegisterNetEvent('th-bilforhandler:giveVehToPlayer', function(plate, playerId, props)
    local xTarget = ESX.GetPlayerFromId(playerId)

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
         xTarget.identifier,
         plate,
         json.encode(props)
    })

    MySQL.Async.execute('DELETE FROM th_lager WHERE nummerplade = @nummerplade', {
         ['@nummerplade'] = plate
    })

end)

RegisterNetEvent('th-bilforhandler:removeIdFromDatabase', function(id)
    MySQL.Async.execute('DELETE FROM th_sold WHERE id = @id', {
        ['@id'] = id
   })
end)

RegisterNetEvent('th-bilforhandler:addDataToDatabase', function(playerId, model, vehiclePrice, seller)
    local xPlayer = ESX.GetPlayerFromId(seller)
    local xTarget = ESX.GetPlayerFromId(playerId)
    local buyerName = xTarget.getName()
    local sellerName = xPlayer.getName()
    MySQL.insert('INSERT INTO th_sold (bil, medarbejder, buyer, pris) VALUES (?, ?, ?, ?)', {
        model,
        sellerName,
        buyerName,
        vehiclePrice
    })
end)