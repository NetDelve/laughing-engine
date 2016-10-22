local client = {}

function client.start(args)

  client_data = {}

  client_data.name = args.name or "Lover"..math.random(1000,9999)
  client_data.lx,client_data.ly = 0,0
  client_data.users = {}
  client_data.board = {}
  client_data.board_index = 0

  -- Connects to localhost by default
  client_data.lovernet = lovernetlib.new(args)

  -- Just in case google ever hosts a server:
  -- client_data.lovernet = lovernetlib.new{ip="8.8.8.8"}

  -- Configure the lovernet instances the same way the server does
  require("define")(client_data.lovernet)

  -- Get version information
  client_data.lovernet:pushData("version")

  -- Send your name once
  client_data.lovernet:pushData("whoami",{name=client_data.name})

end

function client.stop()
  client_data.lovernet:disconnect()
  client_data = nil
end

