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

quit=false
GameRunning = false
Menu = 1
-- 
-- Menu number 
-- 0==nomenu 
-- 1==mainmenu 4==options
-- 2==singleplayer 3==multiplayer 5==serverhost 6==serverjoin
--
function playing( ip, name )
	require "playing"
	load ( ip, name )
end

function main()
	if Menu == 1 then		
		mainmenu()
	else
	if Menu == 2 then
		singleplayermenu()
	else
	if GameRunning then
	end
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

function love.quit()
    if quit then
        print("We are not ready to quit yet!")
        quit = not quit
   else
        print("Thanks for playing. Please play again soon!")
        return quit
    end
    return true
end

function love.textinput(t)
suit.textinput(t)
end

function love.keypressed(key, scancode, isRepeat)
suit.keypressed(key)
input.keypressed(key)
end
