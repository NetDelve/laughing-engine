--laughing_engine v.0.0.0 by NetDelve
--

require "libs/console"
require "libs/math"
require "libs/TSerial"
require "libs/LUBE"
require "input"
require "menus"

camera = require 'libs/hump/camera'
vector = require 'libs/hump/vector'

GameRunning = false
atMMenu = true

--thread2 = love.thread.newThread("server.lua")
--thread2:start()

function playing( ip, name )
	require "playing"
	load ( ip, name )
end

function main()
	if atMMenu == true then		
		mainmenu()
	else
	if GameRunning == true then
	end
	end
end

function love.load()
end

function love.update(dt)
--thread2:start()
main()
end

function love.draw()
--if thread2:isRunning() == true then
--love.graphics.print("Server Running", 50, 50)
--end
suit.draw()
end

function love.textinput(t)
suit.textinput(t)
end

function love.keypressed(key, scancode, isRepeat)
suit.keypressed(key)
input.keypressed(key)
end
