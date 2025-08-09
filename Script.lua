-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("Comando's GUI", "BloodTheme")

-- Função para tornar arrastável
local UserInputService = game:GetService("UserInputService")

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

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
            update(input)
        end
    end)
end

-- Tentar encontrar a GUI principal depois que ela for criada
task.wait(0.5) -- pequena espera para garantir que a GUI carregue
local gui = game.CoreGui:FindFirstChild("Comando's GUI") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("Comando's GUI")
if gui then
    local mainFrame = gui:FindFirstChild("Main", true) -- procura dentro de todos os filhos
    if mainFrame then
        makeDraggable(mainFrame)
    end
end

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
