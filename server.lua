local server = {}

function server.start()
  server_data = {}
  server_data.lovernet = lovernetlib.new({type=lovernetlib.mode.server})
  if server_data.lovernet then
    require("define")(server_data.lovernet)
  else
    server_data = nil
  end
end

function server.stop()
  server_data.lovernet:disconnect()
  server_data = nil
end

function server.draw()
  love.graphics.setColor(255,255,255,63)
  love.graphics.print(
    "Server hosting on: " ..
      server_data.lovernet:getIp()..":"..server_data.lovernet:getPort())
end