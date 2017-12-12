suit = require "libs/suit"

local creativeChk = {text = ""}
local ipInput = {text = ""}
local mapLengthInput = {text = "100"}
local mapIsFlatInput = {text = ""}
local mapSeedInput = {text = tostring(os.time())}

function mainmenu()
suit.Input(mapLengthInput, 125,250,200,30)
--suit.Label("Map Length", {align="left"}, 50,250,75,30)
--mapgen.length = tonumber(mapLengthInput.text)
--suit.Input(mapSeedInput, 125, 300, 200, 30)
--suit.Label("Map Seed", 50, 300, 75, 30)
--mapgen.seed = tonumber(mapSeedInput.text)
if suit.Button("Host Server", 50,350, 150,30).hit then
-- require "mapgen"
atMMenu = false  
end
end

--function love.draw()
--	love.graphics.setBackgroundColor(100, 100, 100)
--	suit.draw()
--end
