local ECS = require("ECS");
local Physics = require("lib.Physics");
require("utils")

local enemy = ECS.createEntity();
local physics_opt = {
    type = "dynamic",
    mass = 10,
    userData = enemy
}
local data = {
    position = {
        x = 100,
        y = 100
    },
    velocity = {
        x = 50,
        y = 50
    },
    sprite = {
        width = 50,
        height = 50
    },
    tag = {
        type = "enemy"
    },
    speed = 400,
    layer = Physics.physicsLayers.enemy,
    physics = {}
}

local RenderSystem = {
    draw = function()
        love.graphics.push()
        love.graphics.setColor(1, 3, 0)
        love.graphics.rectangle("fill", data.physics.init:getX(), data.physics.init:getY(), data.sprite.width,
            data.sprite.height)
        love.graphics.pop()
    end,

    update = function() -- dt
    end,

    load = function()
        data.physics.init = love.physics.newBody(Physics.world, data.position.x, data.position.y, physics_opt.type);
        data.physics.init:setMass(physics_opt.mass);
        data.physics.physics_shape = love.physics.newRectangleShape(data.sprite.width, data.sprite.height);
        data.physics.fixture = love.physics.newFixture(data.physics.init, data.physics.physics_shape);
        data.physics.fixture:setUserData(enemy)

    end
}

ECS.addComponent(enemy, "position", data.position)
ECS.addComponent(enemy, "velocity", data.velocity)
ECS.addComponent(enemy, "sprite", data.sprite)
ECS.addComponent(enemy, "tag", data.tag)
ECS.addComponent(enemy, "physics", data.physics)
ECS.addComponent(enemy, "speed", data.speed)
ECS.addSystem(RenderSystem);

return enemy;

