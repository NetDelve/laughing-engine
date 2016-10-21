function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function isBlockAtLocation(x, y)
	for i,v in ipairs(map) do
		if v.body:getX() == x and v.body:getY() == y then
			return i, true
		end
	end
	return false
end

function love.load()

lovernetlib = require("lovernet")

	blockSize = {x = 50, y = 50}

	map = {} --Array containing arrays that contain x and y screen cordinate values for the blocks
	mapgen = {length = 50, depth = 50} --the length and depth of the map in blocks, as required by the map generator

	--physics
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*100, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

	--map gen
	curLength = 0
	while curLength < mapgen.length do
		curDepth = 0
		while curDepth < mapgen.depth do
			table.insert(map, {body = love.physics.newBody(world, curLength*blockSize.x, curDepth*blockSize.y, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
			map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
			map[table.maxn(map)].fixture:setFriction(1)
			curDepth = curDepth + 1
		end
		curLength = curLength + 1
	end

	cam = {x = 0, y = 0}
	--player = {x = 0, y = (mapgen.depth*blockSize.y)/2, moveSpeed = 6}
	player = {} --Setup player physics
	player.body = love.physics.newBody(world, 0, -400, "dynamic")
	player.shape = love.physics.newCircleShape(45)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	player.fixture:setFriction(1)
	player.body:setFixedRotation(false)

	jumpCooldown = 0.5 --jump cooldown in seconds
	jumpCountdown = 0 --counter for said jump, don't touch
end

function love.update(dt) --dt = delta time, used for framerate-independent timing
	world:update(dt)
	if jumpCountdown > 0 then
		jumpCountdown = jumpCountdown - dt
	end
	if love.keyboard.isDown("w") or love.keyboard.isDown(" ") then
		--jump
		if jumpCountdown <= 0 then
			player.body:applyForce(0, -15000)
			jumpCountdown = jumpCooldown
		end
	elseif love.keyboard.isDown("s") then
		--crouch
	end
	if love.keyboard.isDown("a") then
		player.body:applyForce(-250, 0)
		playerMirrored = false
	elseif love.keyboard.isDown("d") then
		player.body:applyForce(250, 0)
		playerMirrored = true
    
	end
	cam.x, cam.y = love.graphics.getWidth() /2 - player.body:getX() - 25, love.graphics.getHeight() /2 - player.body:getY() - 25
	
	--[[if love.keyboard.isDown("w") then --move player around in the y direction
		player.y = player.y + player.moveSpeed*(dt*60)
	elseif love.keyboard.isDown("s") then
		player.y = player.y - player.moveSpeed*(dt*60)
	end

	if love.keyboard.isDown("a") then --move player around in the x direction
		player.x = player.x + player.moveSpeed*(dt*60)
	elseif love.keyboard.isDown("d") then
		player.x = player.x - player.moveSpeed*(dt*60)
	end

	cam.x, cam.y = player.x, player.y --set the camera to the player]]
end

function love.draw()
	for i,v in ipairs(map) do
		love.graphics.rectangle("line", v.body:getX() + cam.x, v.body:getY() + cam.y, blockSize.x, blockSize.y)
		--love.graphics.rectangle("line", v.x + cam.x, v.y + cam.y, 50, 50) --draw blocks
	end
	love.graphics.circle("line", player.body:getX() + cam.x, player.body:getY() + cam.y, player.shape:getRadius())
	--love.graphics.print(player.x..player.y)
end



function love.mousepressed( x, y, button, istouch )
	xRound, yRound = blockSize.x*round(x/blockSize.x, 0), blockSize.y*round(y/blockSize.y, 0)
	camXRound, camYRound = blockSize.x*round(cam.x/blockSize.x, 0), blockSize.y*round(cam.y/blockSize.y, 0)
	print(xRound-camXRound)
	if button == 1 then
		table.insert(map, {body = love.physics.newBody(world, xRound - camXRound, yRound - camYRound, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
		map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
		map[table.maxn(map)].fixture:setFriction(1)
	end
end
