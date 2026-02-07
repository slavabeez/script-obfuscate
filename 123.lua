if(workspace:FindFirstChild("Part"))then
return 0
end
local detal = Instance.new("Part",workspace)
local cheka = 2


wait(0.5)
local ba=Instance.new("ScreenGui")
local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent=game.CoreGui
ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,370,0,52)
ca.Font=Enum.Font.SourceSansSemibold;ca.Text="Anti Afk"ca.TextColor3=Color3.new(0,1,1)
ca.TextSize=22;da.Parent=ca
da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
da.Size=UDim2.new(0,370,0,107)_b.Parent=da
_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
_b.Size=UDim2.new(0,370,0,21)_b.Font=Enum.Font.Arial;_b.Text="Made by luca#5432"
_b.TextColor3=Color3.new(0,1,1)_b.TextSize=20;ab.Parent=da
ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377,0)
ab.Size=UDim2.new(0,370,0,44)ab.Font=Enum.Font.ArialBold;ab.Text="Status: Active"
ab.TextColor3=Color3.new(0,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
ab.Text="Roblox tried kicking you buy I didnt let them!"wait(2)ab.Text="Status : Active"end)

function raynd()
repeat
if(game:GetService("Players").LocalPlayer.PlayerGui.ReactGameIntermission.Frame.top.timer.time.Text == "00:04")then
local args = {
    [1] = "Voting",
    [2] = "Skip"
}

game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end
wait(1)
until game:GetService("Players").LocalPlayer.PlayerGui.ReactGameIntermission.Frame.top.timer.time.Text == "00:02" or workspace.Music.Value == "Lose"
print(cheka)
cheka+=1
end

local chek1=0

function chek()
wait(1)
local da = tostring(chek1)
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name=da
chek1+=1
end
end

while(true)do
if(workspace.Music.Value == "Lose")then
local args = {
    [1] = "Voting",
    [2] = "Skip"
}

game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
wait(10)
end
local args = {
    [1] = "Voting",
    [2] = "Skip"
}

game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
wait(1)
cheka=2
chek1=0
while(true)do
chek1=0
repeat
wait(0.1)
until game:GetService("Players").LocalPlayer.PlayerGui.ReactGameIntermission.Frame.top.timer.time.Text == "00:01"
cheka=2
print("raynd start")

local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(7.304203510284424, 0.9861031174659729, 26.979137420654297)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="0"
end

local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(4.303591251373291, 0.9595088362693787, 27.339744567871094)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="1"
end

local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(10.159801483154297, 0.999995768070221, 26.00023651123047)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="2"
end

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("0"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("1"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("2"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(9.471574783325195, 0.999995231628418, 29.091808319091797)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="3"
end

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("3"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("0"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("1"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("2"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("3"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("0"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("1"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("2"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("3"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("0"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("1"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("2"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("3"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(7.633903980255127, 0.9999966025352478, 21.004711151123047)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="4"
end

local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(4.666198253631592, 0.9999966621398926, 20.54060935974121)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="5"
end

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("4"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("4"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("4"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("4"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("5"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("5"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("5"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("5"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(10.637295722961426, 0.9999966621398926, 20.67972183227539)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="6"
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(13.629340171813965, 0.9999967217445374, 20.261035919189453)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="7"
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(13.161689758300781, 0.9999958276748657, 25.56149673461914)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="8"
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(12.49782943725586, 0.9999953508377075, 28.51531982421875)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="9"
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("6"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("6"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("6"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("6"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("7"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("7"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("7"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("7"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("8"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("8"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("8"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("8"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("9"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("9"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("9"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("9"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
raynd()
if(workspace.Music.Value == "Lose")then
wait(1)
cheka=2
break
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(15.928657531738281, 0.9999970197677612, 18.331111907958984)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="10"
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(13.551556587219238, 0.9999973773956299, 16.40891456604004)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="11"
end
local args = {
	"Troops",
	"Pl\208\176ce",
	{
		Rotation = CFrame.new(0, 0, 0, 1, -0, 0, 0, 1, -0, 0, 0, 1),
		Position = vector.create(17.942466735839844, 0.9999973773956299, 16.069509506225586)
	},
	"Scout"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
if(workspace.Towers:FindFirstChild("Default"))then
workspace.Towers.Default.Name="12"
end
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("10"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("10"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("10"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("10"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("11"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("11"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("11"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("11"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("12"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("12"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("12"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
local args = {
	"Troops",
	"Upgrade",
	"Set",
	{
		Troop = workspace:WaitForChild("Towers"):WaitForChild("12"),
		Path = 1
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
print("while not lose")
while not(workspace.Music.Value == "Lose")do
local args = {
    [1] = "Voting",
    [2] = "Skip"
}

game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
wait(1)
end
wait(2)
break
end
print("game over")
end
