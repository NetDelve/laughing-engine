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
main()
end

function love.draw()
suit.draw()
end

function love.textinput(t)
suit.textinput(t)
end

function love.keypressed(key, scancode, isRepeat)
suit.keypressed(key)
input.keypressed(key)
end
