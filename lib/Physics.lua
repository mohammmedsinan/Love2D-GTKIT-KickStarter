local physics = {};

physics.worldInitialize = function (horizontal, vertical, sleep)
	physics.world = love.physics.newWorld(horizontal,vertical,sleep);
end

function physics.update(dt)
	physics.world:update(dt);
end

physics.physicsLayers = {
	player = 0,
	enemy = 1,
	objects = 2,
}

return physics;
