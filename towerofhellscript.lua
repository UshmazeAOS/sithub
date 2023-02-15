if not UILibrary then getgenv().UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))() end

local mt = getrawmetatable(game)
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

local MainUI = UILibrary.Load("Tower of Hell Menu")
local commonCheatsPage = MainUI.AddPage("Common")
local movementPage = MainUI.AddPage("Movement")

local godModeToggle = commonCheatsPage.AddToggle("Godmode", false, function(Value)
	getgenv().godModeEnabled = Value
	spawn(function()
		while wait do
			if not getgenv().godModeEnabled then break end
			game.Players.LocalPlayer.Character.KillScript:Destroy() 
		end
	end)
end)


local teleportToFinishButton = commonCheatsPage.AddButton("TP To Finish", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.tower.finishes:GetChildren()[1].CFrame
end)

local speedSlider = movementPage.AddSlider("speed:", {Min = 1, Max = 250, Def = 16}, function(Value)
	getgenv().speedSliderValue = Value
end)

spawn(function()
	while wait() do
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().speedSliderValue
	end
end)


local openTeleportMenuButton = movementPage.AddButton("open TP menu", function()
	local TPUI = UILibrary.Load("teleport menu")
	local playerTPPage = TPUI.AddPage("players")
	for i,v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer then
			playerTPPage.AddButton(v.Name, function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			end)
		end
	end
end)
