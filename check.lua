local whitelistecheck = loadstring(game:HttpGet("https://raw.githubusercontent.com/slavabeez/script/refs/heads/main/white%20list.lua", true))()

if whitelistecheck[game:service('Players').LocalPlayer.UserId] then
  print("sucses") -- ÐÐ°Ñ ÑÐºÑÐ¸Ð¿Ñ
else
  game:service('Players').LocalPlayer:Kick('no verif')
end
