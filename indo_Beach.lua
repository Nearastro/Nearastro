local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()
local Window = MacLib:Window({
 Title = "Near.CC",
 Subtitle = "supp bby boy",
 Size = UDim2.fromOffset(600, 320),
 DragStyle = 1,
 ShowUserInfo = true,
 Keybind = Enum.KeyCode.RightControl,
 AcrylicBlur = true,
})

local vim = game:GetService("VirtualInputManager")
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui", playerGui)
gui.ResetOnSpawn = false

local ctrlBtn = Instance.new("TextButton")
ctrlBtn.Size = UDim2.new(0, 80, 0, 32)
ctrlBtn.Position = UDim2.new(0, 10, 1, -50)
ctrlBtn.Text = "Open"
ctrlBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ctrlBtn.TextColor3 = Color3.new(1, 1, 1)
ctrlBtn.TextSize = 14
ctrlBtn.Font = Enum.Font.SourceSansBold
ctrlBtn.BorderSizePixel = 0
ctrlBtn.Parent = gui
ctrlBtn.Draggable = true
Instance.new("UICorner", ctrlBtn).CornerRadius = UDim.new(0, 8)

local toggled = true
ctrlBtn.MouseButton1Click:Connect(function()
 toggled = not toggled
 vim:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
 task.wait(0.1)
 vim:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
 ctrlBtn.Text = toggled and "Open" or "Close"
end)

local tabs = {
 Main = Window:TabGroup():Tab({ Name = "Main", Image = "rbxassetid://18821914323" }),
 Troll = Window:TabGroup():Tab({ Name = "Troll", Image = "rbxassetid://13750928677" }),
}
local sections = {
 MainLeft = tabs.Main:Section({ Side = "Left", Size = 600 }),
 TrollLeft = tabs.Troll:Section({ Side = "Left", Size = 600 })
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local autoSell = false
local autoCrystal = false
local autoFish = false
local sellPos = Vector3.new(41.74, 73.68, 173.44)

local function teleportTo(pos)
 Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
 HRP = Character:WaitForChild("HumanoidRootPart")
 HRP.CFrame = CFrame.new(pos)
end

local function getSellableItems()
 local Backpack = LocalPlayer:WaitForChild("Backpack")
 local items = {}
 for _, tool in ipairs(Backpack:GetChildren()) do
  if tool:IsA("Tool") then
   local name = tool.Name:lower()
   if name:find("diamond") or name:find("iron") or name:find("gold") then
    table.insert(items, tool)
   end
  end
 end
 return items
end

local function autoSellLoop()
 teleportTo(sellPos)
 task.wait(0.5)
 local sellPrompt = workspace:WaitForChild("SteamPunk"):WaitForChild("Sell"):FindFirstChildOfClass("ProximityPrompt", true)
 if not sellPrompt then return end
 while autoSell do
  local items = getSellableItems()
  if #items == 0 then break end
  for _, item in ipairs(items) do
   if not autoSell then return end
   item.Parent = Character
   task.wait(0.15)
   pcall(function()
    fireproximityprompt(sellPrompt)
   end)
   task.wait(0.3)
  end
  task.wait(0.5)
 end
end

local function autoCrystalLoop()
 while autoCrystal do
  pcall(function()
   local args = { 5.3518859569958295 }
   game:GetService("ReplicatedStorage"):WaitForChild("GiveCrystal"):InvokeServer(unpack(args))
  end)
  task.wait(0.1)
 end
end

local function autoFishLoop()
 while autoFish do
  pcall(function()
   game:GetService("ReplicatedStorage"):WaitForChild("GiveFishFunction"):InvokeServer()
  end)
  task.wait(0.1)
 end
end

sections.MainLeft:Toggle({
 Name = "Auto Sell (Teleport)",
 Default = false,
 Callback = function(state)
  autoSell = state
  if state then autoSellLoop() end
 end
})

sections.MainLeft:Toggle({
 Name = "Auto Get Crystal",
 Default = false,
 Callback = function(state)
  autoCrystal = state
  if state then autoCrystalLoop() end
 end
})

sections.MainLeft:Button({
 Name = "Sell All Fish",
 Callback = function()
  local args = { "Pickaxe" }
  game:GetService("ReplicatedStorage"):WaitForChild("SellAllFish"):FireServer(unpack(args))
 end
})

sections.MainLeft:Toggle({
 Name = "Auto Instant Fish",
 Default = false,
 Callback = function(state)
  autoFish = state
  if state then autoFishLoop() end
 end
})

sections.TrollLeft:Button({
 Name = "Auto Carry All Player",
 Callback = function()
  for _, p in ipairs(Players:GetPlayers()) do
   if p ~= LocalPlayer then
    local args = { p.Name }
    game:GetService("ReplicatedStorage"):WaitForChild("CarryPlayerEvent"):FireServer(unpack(args))
    task.wait(0.1)
   end
  end
 end
})
