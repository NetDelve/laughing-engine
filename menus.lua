--require "libs/binser"
--require "libs/LUBE"
suit = require "libs/suit"
require "input"

mapgen = {length = 100, depth = 50, generator = "normal", seed = os.time()}

-- 
  -- Menu number 
  -- 0==nomenu 
  -- 1==mainmenu 4==options
  -- 2==singleplayer 3==multiplayer 5==serverhost 6==serverjoin
--


function mainmenu()
if suit.Button("Singleplayer", 200,100, 150,30).hit then
Menu=2
end
if suit.Button("Multiplayer", 200,150, 150,30).hit then
Menu=3
end
if suit.Button("Options", 200,200, 150,30).hit then
Menu=4
end
if suit.Button("Exit", 200,250, 150,30).hit then
Menu=0
end
end

function joinservermenu()
 local ipInput = {text = ""}
 local PlayerName = {text = ""}
playername = suit.Input(PlayerName, 125,150,200,30)
suit.Label("Player Name", {align="left"}, 50,150,75,30)
serverip = suit.Input(ipInput, 125,200,200,30)
suit.Label("Server IP", {align="left"}, 50,200,75,30)
if suit.Button("Join Server", 50,250, 150,30).hit then
atMMenu=false
local name = PlayerName.text
local ip = ipInput.text
playing( ip, name )
end
end

function singleplayermenu()
 local creativeChk = {text = ""}
 local mapLengthInput = {text = "100"}
 local mapIsFlatInput = {text = ""}
 local mapSeedInput = {text = tostring(os.time())}
suit.Input(mapLengthInput, 125,275,200,30)
suit.Label("Map Length", {align="left"}, 50,275,75,30)
mapgen.length = tonumber(mapLengthInput.text)
suit.Input(mapSeedInput, 125, 325, 200, 30)
suit.Label("Map Seed", 50, 325, 75, 30)
mapgen.seed = tonumber(mapSeedInput.text)
if suit.Button("Host Server", 50,375, 150,30).hit then
 require "mapgen"
atMMenu = false  
end
end
