Config = {}

Config.Title = 'TH - Development'

Config.Job = {
    Profession = 'unemployed',

    Menu = {
        targetCoords = vec3(-1253.7, -348.51, 36.91)
    }

}

-- danske nummerplader
Config.DanskeNummerplader = true

Config.Notify = {
    Style = {
        backgroundColor = '#141517',
        color = '#C1C2C5',
        ['.description'] = {
        color = '#909296'
        }
    },
}

Config.bilKategorier = {
    ['sedans'] = {
        title = 'Sedans',
        description = 'Kategori for sedan biler',
        icon = 'car'
    },
    ['super'] = {
        title = 'Super',
        description = 'Kategori for super biler',
        icon = 'gauge-high'
    },
    ['compacts'] = {
        title = 'Kompakte',
        description = 'Kategori for kompakte biler',
        icon = 'magnifying-glass'
    },
    ['offroad'] = {
        title = 'Off Road',
        description = 'Kategori for Off Road biler',
        icon = 'truck-monster'
    },
}


Config.demoSpawnPoints = {
    {coords = vector3(-1256.0411, -366.7564, 37.1699), heading = 81.1138, radius = 6.0},
    --{coords = vector3(1998.5583, 3764.5159, 32.1808), heading = 240.7544, radius = 6.0}
}
