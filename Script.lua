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
local SpecialTab = Window:NewTab("Special scripts")
local SpecialSection = SpecialTab:NewSection("Available GUIs")

-- Botão para executar Infinite Yield
SpecialSection:NewButton("Infinite Yield", "Credits to Infinite Yield creators", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)
    if success then
        updateFeedback("✔️ Infinite Yield loaded successfully!")
    else
        updateFeedback("✖ Failed to load Infinite Yield: " .. tostring(err))
    end
end)

-- Botão para executar Mobile keyboard
SpecialSection:NewButton("Mobile keyboard", "Idk the creator so i cant give credits", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Something478/MyScripts/refs/heads/main/MobileKeyboard.lua"))()
    end)
    if success then
        updateFeedback("✔️ Mobile keyboard loaded successfully!")
    else
        updateFeedback("✖ Failed to load Mobile keyboard: " .. tostring(err))
    end
end)

-- Botão para executar Quicky CMD
SpecialSection:NewButton("Quicky CMD", "For games with not secured remotes", function()
    local success, err = pcall(function()
       loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
            end)
    if success then
        updateFeedback("✔️ Quicky CMD loaded successfully!")
    else
        updateFeedback("✖ Failed to load Quicky CMD: " .. tostring(err))
    end
end)

-- Visual Section
local VisualSection = Tab:NewSection("Visual")

-- Profile picture texture URL
local textureId = "rbxthumb://type=AvatarHeadShot&id=3338200743&w=420&h=420"

-- Function to add decal
local function addDecalToInstance(instance)
    if instance:IsA("Part") or instance:IsA("MeshPart") or instance:IsA("UnionOperation") then
        local decalFront = Instance.new("Decal")
        decalFront.Texture = textureId
        decalFront.Face = Enum.NormalId.Front
        decalFront.Parent = instance

        local decalBack = Instance.new("Decal")
        decalBack.Texture = textureId
        decalBack.Face = Enum.NormalId.Back
        decalBack.Parent = instance
    elseif instance:IsA("Model") then
        for _, child in ipairs(instance:GetDescendants()) do
            addDecalToInstance(child)
        end
    end
end

-- Function to remove decal
local function removeCustomDecals(instance)
    if instance:IsA("Decal") and instance.Texture == textureId then
        instance:Destroy()
    elseif instance:IsA("Model") or instance:IsA("Folder") then
        for _, child in ipairs(instance:GetDescendants()) do
            removeCustomDecals(child)
        end
    end
end

-- Button to add decals
VisualSection:NewButton("Add Decals", "Apply the texture to everything", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        addDecalToInstance(obj)
    end
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character then
            addDecalToInstance(player.Character)
        end
    end
    updateFeedback("✔️ Decals added!")
end)

-- Button to remove decals
VisualSection:NewButton("Remove Decals", "Remove only the decals applied by this script", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        removeCustomDecals(obj)
    end
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character then
            removeCustomDecals(player.Character)
        end
    end
    updateFeedback("✔️ Decals removed!")
end)
