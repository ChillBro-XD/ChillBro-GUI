-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

-- Centralizar a janela na tela
wait(1)  -- aguarda a janela ser criada

local mainFrame = game.CoreGui:FindFirstChild("Comando's GUI")
if mainFrame then
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
else
    warn("Janela principal não encontrada para centralizar.")
end

-- Create Tab
local Tab = Window:NewTab("Scripts")

-- Create Section
local Section = Tab:NewSection("Humanoid Controls")

local feedbackLabel

local function updateFeedback(message)
    if feedbackLabel then
        feedbackLabel:UpdateLabel("Status: " .. message)
    end
end

Section:NewTextBox("WalkSpeed (0 - 1000)", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 1000 then
            local player = game.Players.LocalPlayer
            if player then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = value
                    updateFeedback("✔️ WalkSpeed set to " .. value)
                else
                    updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
                end
            else
                updateFeedback("⁉ Player not found.")
            end
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 1000.")
        end
    else
        updateFeedback("✖ Please enter a valid number.")
    end
end)

Section:NewTextBox("JumpPower (0 - 1000)", "Change character JumpPower", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 1000 then
            local player = game.Players.LocalPlayer
            if player then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.UseJumpPower = true
                    player.Character.Humanoid.JumpPower = value
                    updateFeedback("✔️ JumpPower set to " .. value)
                else
                    updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
                end
            else
                updateFeedback("⁉ Player not found.")
            end
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 1000.")
        end
    else
        updateFeedback("✖ Please enter a valid number.")
    end
end)

feedbackLabel = Section:NewLabel("Status: Waiting for input...")
