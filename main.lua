function love.load()
	blockSize = {x = 50, y = 50}

	map = {} --Array containing arrays that contain x and y screen cordinate values for the blocks
	mapgen = {length = 50, depth = 50} --the length and depth of the map in blocks, as required by the map generator

	--map gen
	curLength = 0
	while curLength < mapgen.length do
		curDepth = 0
		while curDepth < mapgen.depth do
			table.insert(map, {x = curLength*blockSize.x, y = curDepth*blockSize.y})
			curDepth = curDepth + 1
		end
		curLength = curLength + 1
	end
	--random variables
	cam = {x = 0, y = 0}
	player = {x = 0, y = 0, moveSpeed = 6}
end

function love.update(dt) --dt = delta time, used for framerate-independent timing
	if love.keyboard.isDown("w") then --move player around in the y direction
		player.y = player.y + player.moveSpeed*(dt*60)
	elseif love.keyboard.isDown("s") then
		player.y = player.y - player.moveSpeed*(dt*60)
	end

	if love.keyboard.isDown("a") then --move player around in the x direction
		player.x = player.x + player.moveSpeed*(dt*60)
	elseif love.keyboard.isDown("d") then
		player.x = player.x - player.moveSpeed*(dt*60)
	end

	cam.x, cam.y = player.x, player.y --set the camera to the player
end

function love.draw()
	for i,v in ipairs(map) do
		love.graphics.rectangle("line", v.x + cam.x, v.y + cam.y, 50, 50) --draw blocks
	end
end
