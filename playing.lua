players = {}

connected = false
serverport = 18025
serverip = "127.0.0.1"

function onReceive(data)
	if connected == true then
		players = TSerial.unpack( data )
	else
	if data == 'you connected' then
		log.event("Connected to \""..serverip.."\" on port \""..serverport.."\"", "general", 0)
		connected = true
	end
	end
end

function load( ip, name )
--serverport = 18025
serverip = ip
	cam = camera(vector(256, 208), 1)
	love.graphics.setBackgroundColor( 50, 50, 50 )

	client = lube.client()
	client:setHandshake("chillout")
	client:setCallback(onReceive)
	if client:connect(ip, serverport) then
		log.event("Connecting to \""..ip.."\" on port \""..serverport.."\"", "general", 0)
		client:send( "name" .. name)
		client:send('Test Connect')
	end 
end

function love.draw()
	cam:attach()
	
	for k, v in pairs(players) do
	if v.name == name then -- tried to make clients player square diffrent from the other players
		love.graphics.setColor(0,200,75)
		love.graphics.rectangle('fill', v.x, v.y, 32, 32)
		love.graphics.print(v.name, v.x-10, v.y-20)
		log.event("found your client \""..name.."\"", "general", 0)
	else
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle('fill', v.x, v.y, 32, 32)
	love.graphics.print(v.name, v.x-10, v.y-20)
	end
	love.graphics.setColor(255,255,255)
	end
	
	cam:detach()

	-- debug
	-- drawMessages()
	love.graphics.print( love.timer.getFPS(), 10, 10 )
end

function love.update( dt )
	client:update(dt)

	if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
		client:send('left')
	elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
		client:send('right')
	end

	if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
		client:send('up')
	elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
		client:send('down')
	end
end

function love.keypressed( key )
end

function love.keyreleased( key )
end

function love.mousepressed( x, y, key )
end

function love.quit()
	client:send('quit')
end
