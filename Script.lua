-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

-- Create Tab
local Tab = Window:NewTab("Scripts")

-- Create Section
local Section = Tab:NewSection("Humanoid Controls")

-- Create feedback label
local feedbackLabel = Section:NewLabel("Status: Waiting for input...")

-- Function to update label
local function updateFeedback(message)
    feedbackLabel:UpdateLabel("Status: " .. message)
end

-- Textbox to change WalkSpeed
Section:NewTextBox("Enter WalkSpeed (0 to 500)", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 500 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value
                updateFeedback("WalkSpeed set to " .. value)
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 500.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Textbox to change JumpPower
Section:NewTextBox("Enter JumpPower (0 to 300)", "Change character JumpPower", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 300 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.UseJumpPower = true
                player.Character.Humanoid.JumpPower = value
                updateFeedback("JumpPower set to " .. value)
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 300.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Button to reset to default values
Section:NewButton("Reset to Default", "Restore WalkSpeed and JumpPower to default", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.UseJumpPower = true
        player.Character.Humanoid.JumpPower = 50
        updateFeedback("Values reset to default (WalkSpeed 16, JumpPower 50)")
    end
end)
