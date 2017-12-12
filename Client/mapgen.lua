math.randomseed(mapgen.seed)
if mapgen.generator == "flat" then
	curLength = 0
	while curLength < mapgen.length do
		foodChance = math.random(0,15)
		if foodChance == 0 then
			curDepth = -1
		else
			curDepth = 0
		end
		while curDepth < mapgen.depth do
			if curDepth > -1 then 
				table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, curDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
				map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
				map[table.maxn(map)].fixture:setFriction(1)
			else
				table.insert(map, {noPhysics = true, x = curLength*blockSize.x, y = curDepth*blockSize.y, addSizeX = 50, addSizeY = 0})
			end
	
			if curDepth == -1 then
				map[table.maxn(map)].sprite = images.berrybush
				--map[table.maxn(map)].shape:setSensor(true)
			elseif curDepth <= 0 then
				map[table.maxn(map)].sprite = images.grass
			elseif curDepth > 0 and curDepth <= math.random(4,7) then
				map[table.maxn(map)].sprite = images.dirt
			else
				map[table.maxn(map)].sprite = images.stone
			end
			curDepth = curDepth + 1
		end
		curLength = curLength + 1
	end
elseif mapgen.generator == "normal" then
	curLength = 0
	curDepth = 0
	while curLength < mapgen.length do
		if curDepth > -1 then 
			table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, curDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
			map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
			map[table.maxn(map)].fixture:setFriction(1)
		else
			table.insert(map, {noPhysics = true, x = curLength*blockSize.x, y = curDepth*blockSize.y, addSizeX = 50, addSizeY = 0})
		end
		map[table.maxn(map)].sprite = images.grass

		fillDepth = curDepth + 1
		while fillDepth < mapgen.depth do
			if fillDepth > -1 then 
				table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, fillDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
				map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
				map[table.maxn(map)].fixture:setFriction(1)
			else
				table.insert(map, {noPhysics = true, x = curLength*blockSize.x, y = fillDepth*blockSize.y, addSizeX = 50, addSizeY = 0})
			end
			if fillDepth == -1 then
				map[table.maxn(map)].sprite = images.berrybush
				--map[table.maxn(map)].shape:setSensor(true)
			elseif fillDepth <= 0 then
				map[table.maxn(map)].sprite = images.grass
			elseif fillDepth > 0 and fillDepth <= math.random(4,7) then
				map[table.maxn(map)].sprite = images.dirt
			else
				map[table.maxn(map)].sprite = images.stone
			end
			fillDepth = fillDepth + 1
		end
		curLength = curLength + 1
		noise = love.math.noise(math.random(), math.random())
		if noise > 0.8 and curDepth > 0 then
			curDepth = curDepth - 1
		elseif noise < 0.2 and curDepth < 4 then
			curDepth = curDepth + 1
		end
	end
end
