--laughing_engine v.0.0.0 by NetDelve
--

require "libs/console"
require "libs/math"
require "libs/TSerial"
require "libs/LUBE"
require "input"
require "menus"
require "log"

camera = require 'libs/hump/camera'
vector = require 'libs/hump/vector'

atMMenu = true

thread2 = love.thread.newThread("server.lua")
thread2:start()

function playing( ip, name )
	log.event("trying to connect to server \""..ip.."\"", "general", 0)
	require "playing"
	load ( ip, name )
end

function love.load()
end

function love.update(dt)
if atMMenu then
mainmenu()
end
--if thread2:isRunning() == true then
--log.event("Server running", "general", 0)
--end
--local err = thread2:getError() --Server error reporting
--if err ~= nil then
--	log.event("Server error \""..err.."\"", "server", 3)
--end
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
