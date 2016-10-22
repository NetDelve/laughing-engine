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

	images = {}
	images.dirt = love.graphics.newImage("dirt.png") --Note: Love2D will give a error if it can't find the image file(s), so if there's an error around here, that's probably why.
	images.grass = love.graphics.newImage("grass.png")
	images.stone = love.graphics.newImage("stone.png")
	images.player = love.graphics.newImage("player.png")

	blockSize = {x = 50, y = 50}

	map = {} --Array containing arrays that contain x and y screen cordinate values for the blocks
	mapgen = {length = 100, depth = 50} --the length and depth of the map in blocks, as required by the map generator

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

			if curDepth <= 0 then
				map[table.maxn(map)].sprite = images.grass
			elseif curDepth > 0 and curDepth <=5 then
				map[table.maxn(map)].sprite = images.dirt
			else
				map[table.maxn(map)].sprite = images.stone
			end
			curDepth = curDepth + 1
		end
		curLength = curLength + 1
	end

	cam = {x = 0, y = 0}
	player = {} --Setup player physics
	player.body = love.physics.newBody(world, 0, -400, "dynamic")
	player.shape = love.physics.newRectangleShape(45, 140)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	player.fixture:setFriction(0.8)
	player.body:setFixedRotation(true)

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
			player.body:applyForce(0, -10000)
			jumpCountdown = jumpCooldown
		end
	elseif love.keyboard.isDown("s") then
		--crouch
	end
	if love.keyboard.isDown("a") then
		player.body:applyForce(-1000, 0)
		playerMirrored = false
	elseif love.keyboard.isDown("d") then
		player.body:applyForce(1000, 0)
		playerMirrored = true
    
	end
	cam.x, cam.y = love.graphics.getWidth() /2 - player.body:getX() - 25, love.graphics.getHeight() /2 - player.body:getY() - 25
end

function love.draw()
	love.graphics.setBackgroundColor(135, 206, 235)
	for i,v in ipairs(map) do
		love.graphics.draw(v.sprite, v.body:getX() + cam.x, v.body:getY() + cam.y) --draw blocks
	end
	if not playerMirrored then
		love.graphics.draw(images.player, player.body:getX() + cam.x, player.body:getY() + cam.y, player.body:getAngle(), 1, 1, images.player:getWidth()/2, images.player:getHeight()/2)
	else
		love.graphics.draw(images.player, player.body:getX() + cam.x, player.body:getY() + cam.y, player.body:getAngle(), -1, 1, images.player:getWidth()/2, images.player:getHeight()/2)
	end
end



function love.mousepressed( x, y, button, istouch )
	xRound, yRound = blockSize.x*round(x/blockSize.x, 0), blockSize.y*round(y/blockSize.y, 0)
	camXRound, camYRound = blockSize.x*round(cam.x/blockSize.x, 0), blockSize.y*round(cam.y/blockSize.y, 0)
	print(xRound-camXRound)
	if button == 1 then
		table.insert(map, {body = love.physics.newBody(world, xRound - camXRound, yRound - camYRound, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
		map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
		map[table.maxn(map)].fixture:setFriction(1)
		map[table.maxn(map)].sprite = images.stone
	end
end
