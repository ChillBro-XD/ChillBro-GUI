-- CRIADO POR CHILLBRO_XD - LIBERADO PARA USO --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeianRussell/Kavo-UI-Library/main/Movable.source.lua"))()
local Window = Library.CreateLib("ChillBro GUI", "BloodTheme")

local feedbackLabel

local function updateFeedback(message)
    if feedbackLabel then
        feedbackLabel:UpdateLabel("Status: " .. message)
    end
end

local function getHumanoid()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        return player.Character.Humanoid
    end
    return nil
end

-- Aba Scripts
local Tab = Window:NewTab("Scripts")
local Section = Tab:NewSection("Humanoid Controls")

Section:NewTextBox("WalkSpeed (0 - 1000)", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 1000 then
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.WalkSpeed = value
                updateFeedback("✔️ WalkSpeed set to " .. value)
            else
                updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
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
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = value
                updateFeedback("✔️ JumpPower set to " .. value)
            else
                updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
            end
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 1000.")
        end
    else
        updateFeedback("✖ Please enter a valid number.")
    end
end)

Section:NewTextBox("Health (1 - MaxHealth)", "Change current Health", function(text)
    local value = tonumber(text)
    local humanoid = getHumanoid()
    if humanoid then
        if value and value >= 1 and value <= humanoid.MaxHealth then
            humanoid.Health = value
            updateFeedback("✔️ Health set to " .. value)
        else
            updateFeedback("✖ Invalid number! Choose between 1 and " .. humanoid.MaxHealth)
        end
    else
        updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
    end
end)

Section:NewTextBox("MaxHealth (1 - 1000)", "Change MaxHealth", function(text)
    local value = tonumber(text)
    local humanoid = getHumanoid()
    if humanoid then
        if value and value >= 1 and value <= 1000 then
            humanoid.MaxHealth = value
            if humanoid.Health > value then
                humanoid.Health = value
            end
            updateFeedback("✔️ MaxHealth set to " .. value)
        else
            updateFeedback("✖ Invalid number! Choose between 1 and 1000.")
        end
    else
        updateFeedback("⁉ Character or Humanoid not found. Please respawn or rejoin.")
    end
end)

Section:NewTextBox("HipHeight (0 - 10)", "Change HipHeight", function(text)
    local value = tonumber(text)
    local humanoid = getHumanoid()
    if humanoid then
        if value and value >= 0 and value <= 10 then
            humanoid.HipHeight = value
            updateFeedback("✔️ HipHeight set to " .. value)
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 10.")
        end
    else
        updateFeedback("⁉ Character or Humanoid not found. Please respawn ou rejoin.")
    end
end)

Section:NewTextBox("JumpHeight (0 - 100)", "Change JumpHeight", function(text)
    local value = tonumber(text)
    local humanoid = getHumanoid()
    if humanoid then
        if value and value >= 0 and value <= 100 then
            humanoid.JumpHeight = value
            updateFeedback("✔️ JumpHeight set to " .. value)
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 100.")
        end
    else
        updateFeedback("⁉ Character or Humanoid not found. Please respawn ou rejoin.")
    end
end)

Section:NewTextBox("Gravity (0 - 500)", "Change workspace gravity (fun to mess with)", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 500 then
            workspace.Gravity = value
            updateFeedback("✔️ Gravity set to " .. value)
        else
            updateFeedback("✖ Invalid number! Choose between 0 and 500.")
        end
    else
        updateFeedback("✖ Please enter a valid number.")
    end
end)

-- Label inicial do feedback
feedbackLabel = Section:NewLabel("Status: Waiting for input...")

-- Nova aba: Special Guis
local SpecialTab = Window:NewTab("Special Guis")
local SpecialSection = SpecialTab:NewSection("Available GUIs")

-- Botão para executar Kill GUI
SpecialSection:NewButton("Kill GUI", "Need: TOOL", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Something478/MyScripts/refs/heads/main/Kill-GUI-V2.lua"))()
    end)
    if success then
        updateFeedback("✔️ Kill GUI loaded successfully!")
    else
        updateFeedback("✖ Failed to load Kill GUI: " .. tostring(err))
    end
end)
