-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

-- Create Tab
local Tab = Window:NewTab("Scripts")

-- Create Section
local Section = Tab:NewSection("Humanoid Controls")

-- Declare a variável para feedbackLabel (sem valor ainda)
local feedbackLabel

-- Função para atualizar o label (usa a variável que será definida depois)
local function updateFeedback(message)
    if feedbackLabel then
        feedbackLabel:UpdateLabel("Status: " .. message)
    end
end

-- Caixa de texto para mudar WalkSpeed
Section:NewTextBox("Enter WalkSpeed (0 to 500)", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 500 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value
                updateFeedback("WalkSpeed set to " .. value)
            else
                updateFeedback("Humanoid not found.")
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 500.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Caixa de texto para mudar JumpPower
Section:NewTextBox("Enter JumpPower (0 to 300)", "Change character JumpPower", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 300 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.UseJumpPower = true
                player.Character.Humanoid.JumpPower = value
                updateFeedback("JumpPower set to " .. value)
            else
                updateFeedback("Humanoid not found.")
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 300.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Agora, CRIE o feedbackLabel DEPOIS das caixas de texto
feedbackLabel = Section:NewLabel("Status: Waiting for input...")
