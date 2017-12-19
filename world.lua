world = {}
world.config = {}
world.objects = {}

function world.init(gravity, drag, bS, cS) --Gravity Acceleration, Atmospheric Drag, Block Size in pixels, Chunk Size in blocks
	world.config.gravity = gravity
	world.config.drag = drag
	world.config.bS = bS
	world.config.cS = cS
end

function world.addObject(_x, _y, _static, _xVel, yVel)
	table.insert(world.objects, {x = _x, y = _y, static = _static, xVel = _xVel, yVel = _yVel})
	return table.maxn(world.objects)
end

function world.removeObject(id)
	table.remove(world.objects[id])
end

function world.pushObject(id, x, y)

end

local function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function world.findObject(x, y)
	for i,v in ipairs(world.objects) do
		if round(v.x, 0) == x and round(v.y, 0) == y then
			return i
		end
	end
end

function world.updatePhysics(dt)
	for i,v in ipairs(world.objects) do
		if not v.static then
			v.yVel = v.yVel + (dt*world.config.gravity) --Apply Gravity Acceleration
			v.xVel, v.yVel = v.xVel - (world.config.drag-v.xVel), v.yVel - (world.config.drag-v.yVel) --Apply Drag
			--Collision
			for o,b in ipairs(world.objects) do
				if v.xVel > 0 or v.xVel < 0 then --Check for X collision
					if b.x == v.x then
						v.xVel = 0 --TODO do something if objects are inside of each other
					end
				end
				if v.yVel > 0 or v.yVel < 0 then --Check for Y collision
					if b.y == v.y then
						v.yVel = 0
					end
				end
			end
			--Move Object
			v.x, v.y = v.x + (dt*v.xVel), v.y + dt*v.yVel)
		end
	end
end

return world
