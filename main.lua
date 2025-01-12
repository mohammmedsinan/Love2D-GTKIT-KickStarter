local ECS = require "ECS";
local Physics = require "lib.Physics";
local camera = require "lib.camera";
local Contact = require "plugin.ContactManager";
local sti = require "lib.sti";

require("entities");
require("utils");

function love.load()
    Camera = camera()
    Physics.worldInitialize(0, 0, true);
    -- love.window.setFullscreen(true)
    ECS.loadWorld()
    Physics.world:setCallbacks(Contact.beginContact, Contact.endContact, Contact.preSolve, Contact.postSolve)
    map = sti("t.lua", {"box2d"})
    map:box2d_init(Physics.world);
end

function love.update(dt)
    Physics.update(dt);
    ECS.updateWorld(dt);
    -- Camera:lookAt(player_pos.init:getPosition())
    map:update(dt)
end

function love.draw()
    Camera:attach()
    ECS.drawWorld()
    map:draw()
    love.graphics.setColor(1, 0, 0)
    map:box2d_draw()
    Camera:detach()
end

