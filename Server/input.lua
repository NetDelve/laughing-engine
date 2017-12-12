input = {}
input.keyToggles = {}
input.mouseToggles = {}

function input.addKeyToggle(_name, _key, _status)
	if _status ~= true and status ~= false then
		_status = false
	end
	table.insert(input.keyToggles, {name = _name, key = _key, status = _status})
end

function input.getKeyToggle(_name)
	for i,v in ipairs(input.keyToggles) do
		if _name == v.name then
			return v.status, v.key
		end
	end
end

function input.removeKeyToggle(_name)
	for i,v in ipairs(input.keyToggles) do
		if _name == v.name then
			table.remove(input.keyToggles, i)
		end
	end
end

function input.mousepressed(x, y, button)

end

function input.keypressed(_key)
	for i,v in ipairs(input.keyToggles) do
		if _key == v.key then
			if v.status then
				v.status = false
			else
				v.status = true
			end
		end
	end
end

return input
