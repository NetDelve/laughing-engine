players = {}

function onReceive(data)
	players = TSerial.unpack( data )
end

function load( ip, name )
	
	love.graphics.setBackgroundColor( 50, 50, 50 ) --this is temp

	client = lube.client()
	client:setHandshake("chillout")
	client:setCallback(onReceive)
	client:connect(ip, 18025)		

	client:send( "name" .. name)
end

function love.draw()
	
	-- debug
	drawMessages()
	love.graphics.print( love.timer.getFPS(), 10, 10 )
end

function love.update( dt )
	-- Collider:update( dt )
	client:update(dt)

end


function love.quit()
	client:send('quit')
end