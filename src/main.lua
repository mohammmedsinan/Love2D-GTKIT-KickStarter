local ECS = require "ECS";
local Physics = require "lib.Physics";
local player = require "entities.player"
local camera = require "lib.camera";
local Contact = require "plugin.ContactManager";

require("entities");
require("utils");

local layers = {};

function love.load()
    -- The Start of the load function
    Camera = camera()
    Physics.worldInitialize(0, 0, true);
    love.window.setFullscreen(true)
    ECS.loadWorld()
    Physics.world:setCallbacks(Contact.beginContact, Contact.endContact, Contact.preSolve, Contact.postSolve)
    -- End of Load Function
end

function love.update(dt)
    -- The Start of the update function
    Physics.update(dt);
    ECS.updateWorld(dt);

    local player_pos = ECS.getComponent(player, "physics");
    Camera:lookAt(player_pos.init:getPosition())
    -- End of Update Function
end

function love.draw()
    -- The Start of the draw function
    Camera:attach()
    ECS.drawWorld()
    for _, obj in ipairs(layers) do
        obj:draw()
    end
    Camera:detach()
    -- End of Draw Function
end

