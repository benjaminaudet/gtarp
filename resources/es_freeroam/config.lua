-- Change your database credentials.
database = {
          host = "127.0.0.1",
          name = "gta5_gamemode_essential",
          username = "root",
          password = "jujumanu78"
        }

-- Configure the coordinates where the player gets spawned when he joins the server (temporarily disabled untill the next release).
spawnCoords = {x=464.091, y=-997.166, z=24.915}

-- Random skins
skins = {"a_f_y_tourist_02",
    "a_f_y_tourist_01",}

require "resources/essentialmode/lib/MySQL"
