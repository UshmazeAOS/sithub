----------------------- UI HANDLER -----------------------
if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end
local StarterGui = game:GetService("StarterGui")
function DisplayMessage(message)
    StarterGui:SetCore("SendNotification", {
    	Title = "SitHub",
    	Text = message,
    	Duration = 3.5
    })
end

----------------------- SET VARIABLES -----------------------
getgenv().speedToggled = false
getgenv().speedDisabled = false
getgenv().godModeEnabled = false	
local mt = getrawmetatable(game)
getgenv().defaultJump = game.Players.LocalPlayer.Character.Humanoid.JumpPower
getgenv().jumpBoostDisabled = false
print("default jump value = "..getgenv().defaultJump)
getgenv().EDEnabled = false

----------------------- ANTICHEAT BYPASS -----------------------
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "Kick" then return end
    return old(self, ...)
end)
setreadonly(mt, true)
game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2:Destroy()
game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript:Destroy()

getgenv().speedSliderValue = 16

local reg = getreg()
for i, Function in next, reg do
    if type(Function) == 'function' then
        local info = getinfo(Function)
        if info.name == 'kick' then
            if (hookfunction(info.func, function(...)end)) then
                print "lol no kick"
            end
        end
    end
end

----------------------- MAKE MAIN UI PAGES -----------------------
local MainUI = UILibrary.Load("Tower of Hell Menu")
local commonCheatsPage = MainUI.AddPage("Common")
local movementPage = MainUI.AddPage("Movement")
local disablePage = MainUI.AddPage("disables")
local miscellaneousPage = MainUI.AddPage("miscellaneous")
----------------------- GODMODE -----------------------
local godModeToggle = commonCheatsPage.AddToggle("Godmode", false, function(Value)
    game.Players.LocalPlayer.Character.KillScript.Disabled = Value
    displayMessage("godmode " .. (Value and "en" or "dis") .. "abled")
end)

----------------------- DISABLE JUMP BOOST EFFECT -----------------------
local DisableJumpBoost = disablePage.AddToggle("Disable jump boost", false, function(Value)
	getgenv().jumpBoostDisabled = Value
end)

spawn(function()
	while wait() do
		if getgenv().jumpBoostDisabled then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
		end
	end
end)

----------------------- FINISH TOWER -----------------------
local teleportToFinishButton = commonCheatsPage.AddButton("TP To Finish", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.finishes:GetChildren()[1].CFrame
	DisplayMessage("Taveling to end...")
end)

----------------------- TOGGLE CUSTOM SPEED -----------------------
local speedToggle = movementPage.AddToggle("enable custom speed", false, function(Value)
	getgenv().speedToggled = Value
	DisplayMessage("custom speed toggled")
end)

----------------------- SET CUSTOM SPEED -----------------------
local speedSlider = movementPage.AddSlider("speed:", {Min = 1, Max = 250, Def = 16}, function(Value)
	getgenv().speedSliderValue = Value
end)

----------------------- APPLY CUSTOM SPEED -----------------------
spawn(function()
	while wait() do
		if getgenv().speedToggled then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().speedSliderValue
		else
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
end)

----------------------- OPEN TELEPORTER MENU -----------------------
local openTeleportMenuButton = movementPage.AddButton("open TP menu", function()
	local TPUI = UILibrary.Load("teleport menu")
	local playerTPPage = TPUI.AddPage("players")
	for i,v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer then
			playerTPPage.AddButton(v.Name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				DisplayMessage("Teleported to ".. v.Name)
			end)
		end
	end
end)

----------------------- DISABLE FOG EFFECT -----------------------
local disableFogToggle = disablePage.AddButton("Disable fog", function()
	local fog = require(game:GetService("ReplicatedStorage").Mutators.fog)
    fog.isEnabled = function() return false end
    fog:revert()
    showToast("Removed fog")
end)
----------------------- ENABLE EXPLOSIVE DEATH EFFECT -----------------------
local EDToggle = miscellaneousPage.AddToggle("Explosive Death", false, function(Value)
	getgenv().EDEnabled = Value
	if getgenv().EDEnabled then
		game.Players.LocalPlayer.Character.ExplosiveDeath.Disabled = false
		DisplayMessage("ED Enabled")
	else
		game.Players.LocalPlayer.Character.ExplosiveDeath.Disabled = true
		DisplayMessage("ED Disabled")
	end
end)