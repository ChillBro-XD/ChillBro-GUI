-- Drag.lua - Torna a janela principal da GUI arrastável (Kavo UI)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Função para encontrar a janela principal
local function findMainFrame()
    local containers = {game.CoreGui, player:FindFirstChild("PlayerGui")}
    for _, container in ipairs(containers) do
        if container then
            for _, sg in ipairs(container:GetChildren()) do
                if sg:IsA("ScreenGui") then
                    -- Procura por "Main" (nome padrão da Kavo UI)
                    local main = sg:FindFirstChild("Main", true)
                    if main and main:IsA("Frame") then
                        return main
                    end
                end
            end
        end
    end
    return nil
end

-- Função para arrastar um frame
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

-- Espera a GUI carregar e aplica arraste
task.spawn(function()
    for i = 1, 50 do -- tenta por até ~5 segundos
        local mainFrame = findMainFrame()
        if mainFrame then
            makeDraggable(mainFrame)
            print("[Drag.lua] Arraste ativado em:", mainFrame:GetFullName())
            return
        end
        task.wait(0.1)
    end
    warn("[Drag.lua] Não foi possível encontrar a GUI principal.")
end)
