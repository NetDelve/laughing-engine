require 'libs/console'
require 'libs/math'

require 'libs/LUBE'
require 'libs/TSerial'

HC = require 'libs/HC'

players = {}
player_bodys = {}

-- NETWORKING --

function onConnect(id)
	-- we use two different tables for the body and coords, the voords one is what is sent back to the client, the player_bodys is for the serverside Collision detection
	player_bodys[id] = Collider:addRectangle(1,1, 32,32)
	players[id] = { x = 1, y = 1, name = "Anon"}
end

function love.draw()
  love.graphics.setBackgroundColor(100, 100, 100)
end

function love.load()
	Collider = HC( 100, on_collision )
	love.graphics.setBackgroundColor( 50, 50, 50 )

	server = lube.server(18025)
	server:setCallback(onReceive, onConnect, onDisconnect)
	server:setHandshake("chillout")
end

function love.keypressed( key )
end

function love.keyreleased( key )
end

function love.mousepressed( x, y, key )
end