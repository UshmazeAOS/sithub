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
getgenv().EDEnabled = false
local animateScript = game.Players.LocalPlayer.Character.Animate
getgenv().flightEnabled = false


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
if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("LocalScript2") then
    game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2:Destroy()
    game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript:Destroy()
end

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
local MainUI = UILibrary.Load("Tower Of Hell - UShmaze AOS")
local commonCheatsPage = MainUI.AddPage("Common")
local movementPage = MainUI.AddPage("Movement")
local disablePage = MainUI.AddPage("disables")
local miscellaneousPage = MainUI.AddPage("miscellaneous")

----------------------- GODMODE -----------------------
local godModeToggle = commonCheatsPage.AddToggle("Godmode", false, function(Value)
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    	if Value then
			if v.Name == "hitbox" then
				v.Name = "hitboxInvincible"
				DisplayGodmode("applied invincibility.")
			end
        else
			if v.Name == "hitboxInvincible" then
				v.Name = "hitbox"
				DisplayMessage("removed incibility.")
			end
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
	local MapTPPage = TPUI.AddPage("map")
	local teleportToFinishButtonTPMenu = MapTPPage.AddButton("TP To Finish", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.finishes:GetChildren()[1].CFrame
	DisplayMessage("Taveling to end...")
	end)
	for i,v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer then
			playerTPPage.AddButton(v.Name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				DisplayMessage("Teleported to ".. v.Name)
			end)
		end
	end
end)

----------------------- ENABLE/DISABLE JUMP BOOST EFFECT -----------------------
local enableLowGravityToggle = miscellaneousPage.AddToggle("Low Gravity", false, function(Value)
	if game:GetService("ReplicatedStorage").Mutators:FindFirstChild("gravity") then
		local gravity = require(game:GetService("ReplicatedStorage").Mutators.gravity)
		if Value then
			gravity:mutate()
			gravity.isEnabled = function() return true end
			DisplayMessage("Applied Low Gravity.")
		else
			gravity.isEnabled = function() return false end
			gravity:revert()
			DisplayMessage("remove Low Gravity.")
		end
	else
		DisplayMessage("gravity modulescript not found.")
	end
end)

local disableJumpBoostButton = disablePage.AddButton("disable low gravity", function() 
	local gravity = require(game:GetService("ReplicatedStorage").Mutators.gravity)
	gravity.isEnabled = function() return false end
	gravity:revert()
	DisplayMessage("removed Low Gravity.")
end)

----------------------- ENABLE/DISABLE FOG EFFECT -----------------------
local disableFogToggle = miscellaneousPage.AddToggle("fog",false, function(Value)
	if game:GetService("ReplicatedStorage").Mutators:FindFirstChild("fog") then
		local fog = require(game:GetService("ReplicatedStorage").Mutators.fog)
		if Value then
			fog:mutate()
			fog.isEnabled = function() return true end
			DisplayMessage("Applied fog effect.")
		else
			fog.isEnabled = function() return false end
			fog:revert()
			DisplayMessage("Removed fog.")
		end
	end
end)

local disableFogButton = disablePage.AddButton("disable Fog", function() 
	local fog = require(game:GetService("ReplicatedStorage").Mutators.fog)
	fog.isEnabled = function() return false end
	fog:revert()
	DisplayMessage("removed fog.")
end)

----------------------- ENABLE/DISABLE BUNNY HOP EFFECT -----------------------
local enableBunnyHopToggle = miscellaneousPage.AddToggle("BunnyHop", false, function(Value)
	if game:GetService("ReplicatedStorage").Mutators:FindFirstChild("bunny") then
		local bunnyHop = require(game:GetService("ReplicatedStorage").Mutators.bunny)
		if Value then
			bunnyHop:mutate()
			bunnyHop.isEnabled = function() return true end
			DisplayMessage("Applied BunnyHop.")
		else
			bunnyHop.isEnabled = function() return false end
			bunnyHop:revert()
			DisplayMessage("removed BunnyHop.")
		end
	else
		DisplayMessage("bunny modulescript not found.")
	end
end)

local disableBunnyHopButton = disablePage.AddButton("disable Bunny Hop", function() 
	local bunnyHop = require(game:GetService("ReplicatedStorage").Mutators.bunny)
	bunnyHop.isEnabled = function() return false end
	bunnyHop:revert()
	DisplayMessage("removed bunny hop.")
end)
----------------------- ENABLE/DISABLE EXPLOSIVE DEATH EFFECT -----------------------
local EDToggle = miscellaneousPage.AddToggle("Explosive Death", false, function(Value)
	getgenv().EDEnabled = Value
	if getgenv().EDEnabled then
		game.Players.LocalPlayer.Character.ExplosiveDeath.Disabled = false
		DisplayMessage("applied explosive death.")
	else
		game.Players.LocalPlayer.Character.ExplosiveDeath.Disabled = true
		DisplayMessage("removed explosive death.")
		
		
	end
end)

----------------------- ENABLE/DISABLE ANIMATIONS -----------------------
local disableAnimationsToggle = miscellaneousPage.AddToggle("freeze current animation", false, function(Value)
	if Value then
		animateScript.Parent = nil
		DisplayMessage("applied animation freeze.")
	else
		animateScript.Parent = game.Players.LocalPlayer.Character
		DisplayMessage("removed animation freeze.")
	end
end)

----------------------- ENABLE/DISABLE INVERSE COLOURS -----------------------
local enableNegativeColoursToggle = miscellaneousPage.AddToggle("Inverse Colours", false, function(Value)
	if game:GetService("ReplicatedStorage").Mutators:FindFirstChild("negative") then
		local negative = require(game:GetService("ReplicatedStorage").Mutators.negative)
		if Value then
			negative:mutate()
			negative.isEnabled = function() return true end
			DisplayMessage("applied inverse colours.")
		else
			negative.isEnabled = function() return false end
			negative:revert()
			DisplayMessage("removed inverse colours.")
		end
	else
		DisplayMessage("negative modulescript not found.")
	end
end)

local disableInverseColoursButton = disablePage.AddButton("disable InverseColours", function() 
	local negative = require(game:GetService("ReplicatedStorage").Mutators.negative)
	negative.isEnabled = function() return false end
	negative:revert()
	DisplayMessage("removed inverse colours.")
end)

----------------------- ENABLE/DISABLE FLIGHT -----------------------
local flightToggle = movementPage.AddToggle("Flight", false, function(Value)
	getgenv().flightEnabled = Value
	if Value then DisplayMessage("flight enabled.") else DisplayMessage("flight disabled.") end
end)

function onJumpRequest()
	if getgenv().flightEnabled then
		local oldJP = 50
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 30
		wait(0.05)
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		wait(0.05)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
	end
end

game:GetService("UserInputService").JumpRequest:connect(onJumpRequest)