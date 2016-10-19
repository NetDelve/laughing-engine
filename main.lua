function love.load()
	map = {}
	mapgen = {length = 50, depth = 50}
	cam = {x = 0, y = 0}
	player = {x = 0, y = 0}
end

function love.update(dt)
	cam.x, cam.y = player.x, player.y
end

function love.draw()

end
