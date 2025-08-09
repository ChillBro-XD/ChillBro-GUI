-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

local UserInputService = game:GetService("UserInputService")

local function makeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(Window.MainFrame)

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
