require 'libs/console'
require 'libs/math'

require 'libs/LUBE'
require 'libs/TSerial'

function menu()
	require 'menu'
end

function playing( ip, name )
	require 'playing'
	load( ip, name )
end

function love.load()
	menu()
end