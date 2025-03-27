local ECS = require "ECS";
local Physics = require "lib.Physics";
local camera = require "lib.camera";
local Contact = require "plugin.ContactManager";
local sti = require "lib.sti";

require("entities");
require("utils");

function love.load()
    Camera = camera()
    Physics.worldInitialize(0, 300, true);
    ECS.loadWorld()
    Physics.world:setCallbacks(Contact.beginContact, Contact.endContact, Contact.preSolve, Contact.postSolve)
    map = sti("t.lua", {"box2d"})
    map:box2d_init(Physics.world);
end

function love.update(dt)
    Physics.update(dt);
    ECS.updateWorld(dt);
    map:update(dt)
end

function love.draw()
    Camera:attach()
    ECS.drawWorld()
    map:draw()
    Camera:detach()
end

