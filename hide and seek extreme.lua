if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
local MainUI = UILibrary.Load("hide and seek cheats")
local itCheatsPage = MainUI.AddPage("IT section")
local movementPage = MainUI.AddPage("movement")

function displayMessage(message)
    StarterGui:SetCore("SendNotification", {
    	Title = "Menu says:",
    	Text = message,
    	Duration = 2
    })
end

local tagAllButton = itCheatsPage.AddButton("tag all players", function()
	if game.Players.LocalPlayer.PlayerData.It.Value then
		for i,v in pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer and v.PlayerData.InGame then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end
			wait(0.3)
		end
	else
		displayMessage("you must be it to activate")
	end
end)

local teleportMenuButton = movementPage.AddButton("open TP menu", function()
	local teleportUI = UILibrary.Load("Teleport Menu")
	local playersPage = teleportUI.AddPage("players:")
	for i,v in pairs(game.Players:GetChildren()) do
		if v.PlayerData.It.Value and v ~= game.Players.LocalPlayer then
			playersPage.AddButton(v.name.." (IT)", function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		elseif v ~= game.Players.LocalPlayer and v.PlayerData.InGame then
			playersPage.AddButton(v.name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		end
	end
end)