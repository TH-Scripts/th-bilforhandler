function getCars()
    ESX.TriggerServerCallback('th-bilforhandler:fetchCars', function(data) 
        carsStock = {}

        for _,v in pairs(data) do
            bilModel = v.model
            table.insert(carsStock, {
                title = 'Model ' ..v.model,
                description = 'Pris '..v.pris,
                onSelect = function()
                    lib.showContext('biler_valgmuligheder')
                end
            })
        end

        lib.registerContext({
            id = 'biler_valgmuligheder',
            title = 'Biler',
            options = {
                {
                    title = 'Fremvis køretøj',
                    description = 'Fremvis køretøjet '..bilModel,
                    onSelect = function()
                        print('spawn function til køretøjet')
                        spawnCar(bilModel)
                    end
                },
                {
                    title = 'Sælg køretøjet',
                    description = 'Sælg køretøjet tilbage til fabrikken ' ..bilModel,
                    onSelect = function()
                        print('sælg køretøj fabrikken')
                    end
                }
            }
        })

        lib.registerContext({
            id = 'biler',
            title = 'Biler',
            options = carsStock,
        })

        lib.showContext('biler')
    end)
end