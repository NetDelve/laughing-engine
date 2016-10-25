require "binser"
require "LUBE"
suit = require "suit"

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
 	images = {}
	images.dirt = love.graphics.newImage("dirt.png") --Note: Love2D will give a error if it can't find the image file(s), so if there's an error around here, that's probably why.
	images.grass = love.graphics.newImage("grass.png")
	images.stone = love.graphics.newImage("stone.png")
	images.player = love.graphics.newImage("player.png")
	images.health0 = love.graphics.newImage("health0.png")
	images.health1 = love.graphics.newImage("health1.png")
	images.health2 = love.graphics.newImage("health2.png")
	images.health3 = love.graphics.newImage("health3.png")
	images.health4 = love.graphics.newImage("health4.png")
	images.hunger0 = love.graphics.newImage("hunger0.png")
	images.hunger1 = love.graphics.newImage("hunger1.png")
	images.hunger2 = love.graphics.newImage("hunger2.png")
	images.hunger3 = love.graphics.newImage("hunger3.png")
	images.hunger4 = love.graphics.newImage("hunger4.png")

	blockSize = {x = 50, y = 50}

	--physics
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*100, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

	map = {} --Array containing arrays that contain x and y screen cordinate values for the blocks
	mapgen = {length = 100, depth = 50} --the length and depth of the map in blocks, as required by the map generator

	require "mapgen"

	cam = {x = 0, y = 0}
	player = {} --Setup player physics
	player.body = love.physics.newBody(world, (mapgen.length*blockSize.x)/2, -400, "dynamic")
	player.shape = love.physics.newRectangleShape(45, 140)
	player.fixture = love.physics.newFixture(player.body, player.shape, 1)
	player.fixture:setFriction(0.8)
	player.body:setFixedRotation(true)
	player.health = 100

	jumpCooldown = 0.5 --jump cooldown in seconds
	jumpCountdown = 0 --counter for said jump, don't touch
	atMenu = true

	totalHealth = 100
end

function love.update(dt) --dt = delta time, used for framerate-independent timing
	if not atMenu then
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

		if player.body:getY() > mapgen.depth*blockSize.y or player.health <= 0 then
			player.body:setX((mapgen.length*blockSize.x)/2)
			player.body:setY(-400)
			player.health = totalHealth
		end
	else
		suit.Label("Server IP", {align="left"}, 50,50,200,30)
		local input = {text = ""}
		suit.Input(input, 125,50,150,30)
		serverIP = input.text
		if suit.Button("Join Server", 50,100, 150,30).hit then
			--require "client"
        	atMenu = false
    	end
		if suit.Button("Server/Singleplayer", 50,200, 150,30).hit then
			--require "server"
        	atMenu = false
    	end
	end
end

function love.draw()
	if not atMenu then
		love.graphics.setBackgroundColor(135, 206, 235)
		for i,v in ipairs(map) do
			if v.sprite == images.grass then
				love.graphics.draw(v.sprite, v.body:getX() + cam.x, v.body:getY() + cam.y - 9) --grass block is a bit taller than the rest of the blocks
			else
				love.graphics.draw(v.sprite, v.body:getX() + cam.x, v.body:getY() + cam.y) --draw blocks
			end
		end
		if not playerMirrored then
			love.graphics.draw(images.player, player.body:getX() + cam.x + 25, player.body:getY() + cam.y + 25, player.body:getAngle(), 1, 1, images.player:getWidth()/2, images.player:getHeight()/2)
		else
			love.graphics.draw(images.player, player.body:getX() + cam.x + 25, player.body:getY() + cam.y + 25, player.body:getAngle(), -1, 1, images.player:getWidth()/2, images.player:getHeight()/2)
		end
		if not creativeMode then
			love.graphics.draw(images.health4, 50, love.graphics.getHeight() -50)
			love.graphics.draw(images.hunger4, 125, love.graphics.getHeight() -50)
		end
	else
		suit.draw()
	end
end



function love.mousepressed( x, y, button, istouch )
	x, y = x - 25, y - 25
	xRound, yRound = blockSize.x*round(x/blockSize.x, 0), blockSize.y*round(y/blockSize.y, 0)
	camXRound, camYRound = blockSize.x*round(cam.x/blockSize.x, 0), blockSize.y*round(cam.y/blockSize.y, 0)
	if button == 1  and not atMenu  and not isBlockAtLocation(xRound - camXRound, yRound - camYRound) then
		table.insert(map, {body = love.physics.newBody(world, xRound - camXRound, yRound - camYRound, "static"), shape = love.physics.newRectangleShape(blockSize.x, blockSize.y)})
		map[table.maxn(map)].fixture = love.physics.newFixture(map[table.maxn(map)].body, map[table.maxn(map)].shape)
		map[table.maxn(map)].fixture:setFriction(1)
		map[table.maxn(map)].sprite = images.stone
	elseif button == 2 and not atMenu then
		i, present = isBlockAtLocation(xRound - camXRound, yRound - camYRound)
		if present then
			map[i].body:destroy()
			table.remove(map, i)
		end
	end
end

function love.textinput(t)
    suit.textinput(t)
end

function love.keypressed(key)
    suit.keypressed(key)
end
