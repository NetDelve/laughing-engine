--laughing_engine v.0.0.0 by NetDelve
--

require "libs/binser"
require "libs/LUBE"
suit = require "libs/suit"
require "input"
require "menus"

GameRunning = false
atMMenu = true

player = {}
player.hp = 100
player.hunger = 100
player.name = "Greg"

function main()
	if atMMenu == true then
	mainmenu()	
		
	else
	if GameRunning == true then
		end
	end

end

function love.update(dt)
main()
end

function love.draw()
suit.draw()
end
