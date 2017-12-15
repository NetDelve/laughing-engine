log = {}
log.log = {}

function log.event(_message, _category, _level) --level 0 = info, level 1 = verbose info, level 2 = warning, level 3 = error
	if not _level then _level = 0 end
	if not _category then _category = "general" end
	table.insert(log.log, {message = _message, category = _category, level = _level})
	if true then --config.debug then  TODO readd debug mode
		print("[".._level.."] ".._category..": ".._message)
	end
end

log.event("Log service started", "general", 0)

return log
