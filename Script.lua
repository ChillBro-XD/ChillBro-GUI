-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

-- Create Tab
local Tab = Window:NewTab("Scripts")

-- Create Section
local Section = Tab:NewSection("Scripts")

-- Textbox para o jogador digitar a velocidade
Section:NewTextBox("Enter speed (0 to 500)", "Change character walkspeed", function(text)
    local value = tonumber(text)
    if value then
        if value >= 0 and value <= 500 then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value
                print("WalkSpeed: " .. value)
            end
        else
            print("Invalid number, choose a number between 0 to 500.")
        end
    else
        print("Insert a valid number, please.")
    end
end)
