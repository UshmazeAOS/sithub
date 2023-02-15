----------------------- UI HANDLER -----------------------
if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
local MainUI = UILibrary.Load("Hide And Seek Extreme - UShmaze AOS")

----------------------- MAKE UI PAGES -----------------------
local itCheatsPage = MainUI.AddPage("IT section")
local movementPage = MainUI.AddPage("movement")
local gamePage = MainUI.AddPage("game")

----------------------- DISPLAY MESSAGE FUNCTION -----------------------
function displayMessage(message)
    StarterGui:SetCore("SendNotification", {
    	Title = "SitHub",
    	Text = message,
    	Duration = 2
    })
end

----------------------- TAG ALL PLAYERS -----------------------
local tagAllButton = itCheatsPage.AddButton("tag all players", function()
	if game.Players.LocalPlayer.PlayerData.It.Value then
		for i,v in pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer and v.PlayerData.InGame.Value then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end
			wait(0.3)
		end
	else
		displayMessage("you must be it to activate")
	end
end)

----------------------- TELEPORT MENU -----------------------
local teleportMenuButton = movementPage.AddButton("open TP menu", function()
	local teleportUI = UILibrary.Load("Teleport Menu")
	local playersPage = teleportUI.AddPage("players:")
	for i,v in pairs(game.Players:GetChildren()) do
		if v.PlayerData.It.Value and v ~= game.Players.LocalPlayer then
			playersPage.AddButton(v.name.." (IT)", function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		elseif v ~= game.Players.LocalPlayer and v.PlayerData.InGame.Value then
			playersPage.AddButton(v.name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		end
	end
end)

----------------------- FAKE REVIVE (CREDIT: MANGOHUB) -----------------------
local semiRevive = gamePage.AddButton("Fake Respawn", function()
	game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	game.Players.LocalPlayer.PlayerGui.MainGui.ItCamFrame.TopFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.TopFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.BottomFrame.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.Q.Visible = false
	game.Players.LocalPlayer.PlayerGui.MainGui.SpectatingFrame.E.Visible = false
	
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Map.ItSpawn.Position + Vector3.new(0, 5, 0))
	game.Players.LocalPlayer.PlayerData.InGame.Value = true
end)