local VIM = game:GetService("VirtualInputManager")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ControlGuiModern"
gui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 130, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -65, 0, 20)
toggleBtn.BackgroundTransparency = 0.4
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Text = "🔽 Open Control"
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.AutoButtonColor = false
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 2

local controls = {}

local function createBtn(text, pos, key)
    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0, 80, 0, 80)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.8
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextStrokeTransparency = 0.7
    btn.Text = text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Visible = false
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.ZIndex = 2

    btn.MouseButton1Down:Connect(function()
        VIM:SendKeyEvent(true, key, false, game)
    end)
    btn.MouseButton1Up:Connect(function()
        VIM:SendKeyEvent(false, key, false, game)
    end)

    table.insert(controls, btn)
end

createBtn("↩️", UDim2.new(0, 20, 1, -120), Enum.KeyCode.A)
createBtn("↪️", UDim2.new(0, 120, 1, -120), Enum.KeyCode.D)
createBtn("🚗", UDim2.new(1, -200, 1, -220), Enum.KeyCode.W)
createBtn("🛑", UDim2.new(1, -100, 1, -120), Enum.KeyCode.S)

local showing = false
toggleBtn.MouseButton1Click:Connect(function()
    showing = not showing
    toggleBtn.Text = showing and "🔼 Close Control" or "🔽 Open Control"
    for _, b in ipairs(controls) do
        b.Visible = showing
    end
end)

