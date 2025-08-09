-- Caixa de texto para mudar WalkSpeed
Section:NewTextBox("WalkSpeed", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 1000 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value
                updateFeedback("WalkSpeed: " .. value)
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 1000.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Caixa de texto para mudar JumpPower
Section:NewTextBox("JumpPower", "Change character JumpPower", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 700 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.UseJumpPower = true
                player.Character.Humanoid.JumpPower = value
                updateFeedback("JumpPower: " .. value)
            end
        else
            updateFeedback("Invalid number! Choose between 0 and 700.")
        end
    else
        updateFeedback("Please enter a valid number.")
    end
end)

-- Label de feedback DEPOIS do JumpPower
local feedbackLabel = Section:NewLabel("Status: Waiting for input...")

-- Função para atualizar o label
function updateFeedback(message)
    feedbackLabel:UpdateLabel("Status: " .. message)
end
