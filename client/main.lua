ESX = exports["es_extended"]:getSharedObject()

local Vehciles, Categories = {}, {} 

RegisterNetEvent('th-bilforhandler:sendCategories')
AddEventHandler('th-bilforhandler:sendCategories', function(categories)
	Categories = categories
end)

RegisterNetEvent('th-bilforhandler:sendVehicles')
AddEventHandler('th-bilforhandler:sendVehicles', function(vehicles)
	Vehicles = vehicles
end)