local ECS = require "ECS";
local Physics = require "lib.Physics";
local ldtk = require "lib.ldtk";
local player = require "entities.player"
local camera = require "lib.camera";

require("entities");
require("utils");

local layers = {};

function love.load()
    Camera = camera()
	Physics.worldInitialize(0, 0, true);
    -- love.window.setMode(512, 512)
	love.window.setFullscreen(true)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setLineStyle('rough')

	ldtk:load("ldtk/game.ldtk");

	---@diagnostic disable-next-line: duplicate-set-field
	function ldtk.onEntity(entity)
		table.insert(ECS.ldtk_entities, entity)
	end

    function ldtk.onLayer(layer)
        table.insert(layers, layer)
    end

	function ldtk.onLevelLoaded(level)
		love.graphics.setBackgroundColor(level.backgroundColor)
	end

	function ldtk.onLevelCreated(level)
		if level.props.create then
			load(level.props.create)()
		end
	end

    ldtk:goTo(2)
	ECS.loadWorld()
end

function love.update(dt)
	Physics.update(dt);
	ECS.updateWorld(dt);

	local player_pos = ECS.getComponent(player, "physics");
	Camera:lookAt(player_pos.init:getPosition())
end


function love.draw()
	Camera:attach()
	ECS.drawWorld()
	love.graphics.scale(3, 3)
	for _, obj in ipairs(layers) do
		obj:draw()
	end
	Camera:detach()
end



