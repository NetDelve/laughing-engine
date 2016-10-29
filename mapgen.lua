curLength = 0
while curLength < mapgen.length do
	foodChance = math.random(0,10)
	if foodChance == 0 then
		curDepth = -1
	else
		curDepth = 0
	end
	while curDepth < mapgen.depth do
		table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, curDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
		map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
		map[table.maxn(map)].fixture:setFriction(1)

		if curDepth == -1 then
			map[table.maxn(map)].sprite = images.berrybush
			map[table.maxn(map)].shape:setSensor(true)
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
