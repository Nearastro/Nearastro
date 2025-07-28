local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ComingSoonGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Updated... coming soon"
textLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
textLabel.TextStrokeColor3 = Color3.new(1, 1, 1)
textLabel.TextStrokeTransparency = 0.8
textLabel.TextScaled = true
textLabel.Font = Enum.Font.GothamBold
textLabel.TextTransparency = 1
textLabel.Parent = screenGui

local tweenTime = 1.5
local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local blurIn = TweenService:Create(blur, tweenInfo, {Size = 20})
local blurOut = TweenService:Create(blur, tweenInfo, {Size = 0})
local textFadeIn = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0})
local textFadeOut = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1})

blurIn:Play()
textFadeIn:Play()

task.wait(2.5)

textFadeOut:Play()
blurOut:Play()

task.wait(tweenTime + 0.2)
screenGui:Destroy()
blur:Destroy()
