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