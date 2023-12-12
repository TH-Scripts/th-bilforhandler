vehicles, categories = {}, {}

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
      MySQL.ready(function() SQLVehiclesAndCategories() end)
    end
end)

function SQLVehiclesAndCategories()
	MySQL.Async.fetchAll('SELECT * FROM `th_vehiclescategories`', {}, function(_categories)
		categories = _categories

		MySQL.Async.fetchAll('SELECT * FROM `th_vehicles`', {}, function(_vehicles)
			vehicles = _vehicles

			GetVehiclesAndCategories(categories, vehicles)
		end)

	end)
end

function GetVehiclesAndCategories(categories, vehicles)
	for k,v in ipairs(vehicles) do
		for k2,v2 in ipairs(categories) do
			if v2.name == v.category then
				vehicles[k].categoryLabel = v2.label
				break
			end
		end
	end

	TriggerClientEvent('th-bilforhandler:sendCategories', -1, categories)
	TriggerClientEvent('th-bilforhandler:sendVehicles', -1, vehicles)
end