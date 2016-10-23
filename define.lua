return function (l)
  local version = "1.0"
  
  -- Add version info
  l:addOp('version')
  -- Get version info to client when it requests it
  l:addProcessOnServer('version',function(self,peer,arg,storage)
    return version
  end)
  -- Process version information on client side
  l:addProcessOnClient('version',function(self,peer,arg,storage)
    if version == arg then
      return true
    else
      return "Version mismatch!\n\nClient: "..tostring(arg).."\nServer: "..tostring(version)
    end
  end)
  -- What to do while it waits for version information
  l:addDefaultOnClient('version',function(self,peer,arg,storage)
    return "Waiting for version information"
  end)

  local isValidString = function(input)
    local utf8 = require("utf8")
    local success = utf8.len(input)
    return success
  end
  
  end
