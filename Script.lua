-- CRIADO POR CHILLBRO_XD - LIBERADO PARA USO --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeianRussell/Kavo-UI-Library/main/Movable.source.lua"))()
local Window = Library.CreateLib("ChillBro GUI", "BloodTheme")

local feedbackLabel
local buttonCooldowns = {}
local cooldownTime = 3 -- Tempo de espera por botão em segundos

-- Criar som local (apenas no cliente)
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://7545317681"
clickSound.Volume = 2
clickSound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Função para tocar som
local function playClickSound()
    clickSound:Play()
end

-- Função para cooldown
local function canClick(buttonName)
    local lastClick = buttonCooldowns[buttonName]
    if lastClick and tick() - lastClick < cooldownTime then
        local remaining = math.ceil(cooldownTime - (tick() - lastClick))
        feedbackLabel:UpdateLabel("Status: Aguarde " .. remaining .. "s antes de clicar novamente.")
        return false
    end
    buttonCooldowns[buttonName] = tick()
    return true
end

-- Função de feedback
local function updateFeedback(message)
    if feedbackLabel then
        feedbackLabel:UpdateLabel("Status: " .. message)
    end
end

-- Função para pegar humanoide
local function getHumanoid()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        return player.Character.Humanoid
    end
    return nil
end

-- Função para criar botões com som + cooldown
local function newButton(section, name, desc, callback)
    section:NewButton(name, desc, function()
        playClickSound()
        if not canClick(name) then return end
        callback()
    end)
end

-- Função para criar TextBox com som + cooldown
local function newTextBox(section, name, desc, callback)
    section:NewTextBox(name, desc, function(text)
        playClickSound()
        if not canClick(name) then return end
        callback(text)
    end)
end

-- ===============================
-- Aba Scripts
local Tab = Window:NewTab("Scripts")
local Section = Tab:NewSection("Humanoid Controls")

newTextBox(Section, "WalkSpeed (0 - 1000)", "Change character WalkSpeed", function(text)
    local value = tonumber(text)
    if value and value >= 0 and value <= 1000 then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = value
            updateFeedback("✔️ WalkSpeed set to " .. value)
        else
            updateFeedback("⁉ Character or Humanoid not found.")
        end
    else
        updateFeedback("✖ Invalid number! Choose between 0 and 1000.")
    end
end)

newTextBox(Section, "JumpPower (0 - 1000)", "Change character JumpPower", function(text)
    local value = tonumber(text)
    if value and value >= 0 and value <= 1000 then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = value
            updateFeedback("✔️ JumpPower set to " .. value)
        else
            updateFeedback("⁉ Character or Humanoid not found.")
        end
    else
        updateFeedback("✖ Invalid number! Choose between 0 and 1000.")
    end
end)

newTextBox(Section, "HipHeight (0 - 10)", "Change HipHeight", function(text)
    local humanoid = getHumanoid()
    local value = tonumber(text)
    if humanoid and value and value >= 0 and value <= 10 then
        humanoid.HipHeight = value
        updateFeedback("✔️ HipHeight set to " .. value)
    else
        updateFeedback("✖ Invalid number or humanoid not found.")
    end
end)

newTextBox(Section, "JumpHeight (0 - 100)", "Change JumpHeight", function(text)
    local humanoid = getHumanoid()
    local value = tonumber(text)
    if humanoid and value and value >= 0 and value <= 100 then
        humanoid.JumpHeight = value
        updateFeedback("✔️ JumpHeight set to " .. value)
    else
        updateFeedback("✖ Invalid number or humanoid not found.")
    end
end)

newTextBox(Section, "Gravity (0 - 500)", "Change workspace gravity", function(text)
    local value = tonumber(text)
    if value and value >= 0 and value <= 500 then
        workspace.Gravity = value
        updateFeedback("✔️ Gravity set to " .. value)
    else
        updateFeedback("✖ Invalid number! Choose between 0 and 500.")
    end
end)

feedbackLabel = Section:NewLabel("Status: Waiting for input...")

-- ===============================
-- Aba Special Scripts
local SpecialTab = Window:NewTab("Special scripts")
local SpecialSection = SpecialTab:NewSection("Available GUIs")

newButton(SpecialSection, "Infinite Yield", "Credits to Infinite Yield creators", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)
    if success then
        updateFeedback("✔️ Infinite Yield loaded successfully!")
    else
        updateFeedback("✖ Failed: " .. tostring(err))
    end
end)

newButton(SpecialSection, "Mobile keyboard", "Unknown creator", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Something478/MyScripts/refs/heads/main/MobileKeyboard.lua"))()
    end)
    if success then
        updateFeedback("✔️ Mobile keyboard loaded successfully!")
    else
        updateFeedback("✖ Failed: " .. tostring(err))
    end
end)

newButton(SpecialSection, "Quicky CMD", "For games with not secured remotes", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
    end)
    if success then
        updateFeedback("✔️ Quicky CMD loaded successfully!")
    else
        updateFeedback("✖ Failed: " .. tostring(err))
    end
end)

-- ===============================
-- Visual Section
local VisualSection = Tab:NewSection("Visual")
local textureId = "rbxthumb://type=AvatarHeadShot&id=3338200743&w=420&h=420"

local function addDecalToInstance(instance)
    if instance:IsA("Part") or instance:IsA("MeshPart") or instance:IsA("UnionOperation") then
        for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
            local decal = Instance.new("Decal")
            decal.Texture = textureId
            decal.Face = face
            decal.Parent = instance
        end
    elseif instance:IsA("Model") then
        for _, child in ipairs(instance:GetDescendants()) do
            addDecalToInstance(child)
        end
    end
end

local function removeCustomDecals(instance)
    if instance:IsA("Decal") and instance.Texture == textureId then
        instance:Destroy()
    elseif instance:IsA("Model") or instance:IsA("Folder") then
        for _, child in ipairs(instance:GetDescendants()) do
            removeCustomDecals(child)
        end
    end
end

newButton(VisualSection, "Add Decals", "Apply the texture to everything (6 faces)", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        addDecalToInstance(obj)
    end
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character then
            addDecalToInstance(player.Character)
        end
    end
    updateFeedback("✔️ Decals added on all faces!")
end)

newButton(VisualSection, "Remove Decals", "Remove only the decals applied by this script", function()
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
