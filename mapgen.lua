curLength = 0
while curLength < mapgen.length do
	curDepth = 0
	while curDepth < mapgen.depth do
		table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, curDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
		map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
		map[table.maxn(map)].fixture:setFriction(1)

		if curDepth <= 0 then
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
