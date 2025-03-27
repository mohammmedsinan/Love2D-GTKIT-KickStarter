local EventManager = require "plugin.EventManager"
local Physics = require("lib.Physics");
local ECS = require("ECS");
require("utils")

local player = ECS.createEntity();
local physics_opt = {
    type = "dynamic",
    mass = 10,
    userData = player
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
    tag = "player",
    speed = 400,
    layer = Physics.physicsLayers.player,
    physics = {}
}

EventManager:registerEntity(player)
EventManager:addEventListener("onEnter", function(event)
    if ECS.getComponent(event.entityB, "tag") == "enemy" then
        print("Player collided with enemy")
    end
end)

local RenderSystem = {
    draw = function()
        love.graphics.rectangle("fill", data.physics.init:getX(), data.physics.init:getY(), data.sprite.width,
            data.sprite.height)
    end,

    update = function() -- dt
        local vx, vy = data.physics.init:getLinearVelocity()
        if love.keyboard.isDown("right") then
            data.physics.init:setLinearVelocity(data.speed, vy)
        elseif love.keyboard.isDown("left") then
            data.physics.init:setLinearVelocity(-data.speed, vy)
        elseif love.keyboard.isDown("down") then
            data.physics.init:setLinearVelocity(vx, data.speed)
        elseif love.keyboard.isDown("up") then
            data.physics.init:setLinearVelocity(vx, -data.speed)
        else
            data.physics.init:setLinearVelocity(0, 0);
        end
    end,

    load = function()
        data.physics.init = love.physics.newBody(Physics.world, data.position.x, data.position.y, physics_opt.type);
        data.physics.init:setMass(physics_opt.mass);
        data.physics.physics_shape = love.physics.newRectangleShape(data.sprite.width, data.sprite.height);
        data.physics.fixture = love.physics.newFixture(data.physics.init, data.physics.physics_shape);
        data.physics.fixture:setUserData(player)
    end
}

ECS.addComponent(player, "position", data.position)
ECS.addComponent(player, "velocity", data.velocity)
ECS.addComponent(player, "sprite", data.sprite)
ECS.addComponent(player, "tag", data.tag)
ECS.addComponent(player, "physics", data.physics)
ECS.addComponent(player, "speed", data.speed)
ECS.addSystem(RenderSystem);

return player;

