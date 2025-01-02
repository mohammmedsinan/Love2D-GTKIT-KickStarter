local ECS = require("ECS");
local enemy = ECS.createEntity();

ECS.addComponent(enemy, "position", { x = 100, y = 100 })
ECS.addComponent(enemy, "velocity", { x = 50, y = 50 })
ECS.addComponent(enemy, "sprite", { width = 60, height = 120 })
ECS.addComponent(enemy, "tag", { type = "enemy" })

return enemy;
