-- Script Base no Chão + Vôo Rápido com Ajuste de Velocidade (Tema WSG Hub)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local basePart = nil
local VELOCIDADE_VOO = 350 -- Velocidade inicial padrão

-- Criando a GUI com visual WSG Hub
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WSG_BaseHub_Speed"
screenGui.ResetOnSpawn = false

if gethui then
    screenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
else
    screenGui.Parent = game:GetService("CoreGui")
end

-- Janela Principal (Main Frame)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 190)
frame.Position = UDim2.new(0.05, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 17, 23) -- Dark Slate (WSG Theme)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = frame

-- Borda Neon (WSG Accent)
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = frame

-- Barra Superior (Header)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
header.BorderSizePixel = 0
header.Parent = frame

local cornerHeader = Instance.new("UICorner")
cornerHeader.CornerRadius = UDim.new(0, 10)
cornerHeader.Parent = header

-- Título WSG
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "WSG HUB | Speed Settings"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

-- 1. Botão: Criar Base no Chão
local btnCriar = Instance.new("TextButton")
btnCriar.Size = UDim2.new(0.9, 0, 0, 30)
btnCriar.Position = UDim2.new(0.05, 0, 0.22, 0)
btnCriar.Text = "Criar Base no Chão"
btnCriar.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
btnCriar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnCriar.Font = Enum.Font.GothamMedium
btnCriar.TextSize = 12
btnCriar.Parent = frame

local btnCriarCorner = Instance.new("UICorner")
btnCriarCorner.CornerRadius = UDim.new(0, 6)
btnCriarCorner.Parent = btnCriar

local btnCriarStroke = Instance.new("UIStroke")
btnCriarStroke.Color = Color3.fromRGB(0, 140, 220)
btnCriarStroke.Thickness = 1
btnCriarStroke.Parent = btnCriar

-- 2. Botão: Voar para Base
local btnVoo = Instance.new("TextButton")
btnVoo.Size = UDim2.new(0.9, 0, 0, 30)
btnVoo.Position = UDim2.new(0.05, 0, 0.41, 0)
btnVoo.Text = "Voar para Base"
btnVoo.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btnVoo.TextColor3 = Color3.fromRGB(255, 255, 255)
btnVoo.Font = Enum.Font.GothamBold
btnVoo.TextSize = 12
btnVoo.Parent = frame

local btnVooCorner = Instance.new("UICorner")
btnVooCorner.CornerRadius = UDim.new(0, 6)
btnVooCorner.Parent = btnVoo

-- PAINEL DE VELOCIDADE
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(0.9, 0, 0, 35)
speedFrame.Position = UDim2.new(0.05, 0, 0.61, 0)
speedFrame.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
speedFrame.Parent = frame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedFrame

local btnLess = Instance.new("TextButton")
btnLess.Size = UDim2.new(0.25, 0, 1, 0)
btnLess.Position = UDim2.new(0, 0, 0, 0)
btnLess.Text = "-50"
btnLess.TextColor3 = Color3.fromRGB(255, 255, 255)
btnLess.Font = Enum.Font.GothamBold
btnLess.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
btnLess.Parent = speedFrame

local btnLessCorner = Instance.new("UICorner")
btnLessCorner.CornerRadius = UDim.new(0, 6)
btnLessCorner.Parent = btnLess

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.Position = UDim2.new(0.25, 0, 0, 0)
speedLabel.Text = "Vel: " .. VELOCIDADE_VOO
speedLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 12
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = speedFrame

local btnMore = Instance.new("TextButton")
btnMore.Size = UDim2.new(0.25, 0, 1, 0)
btnMore.Position = UDim2.new(0.75, 0, 0, 0)
btnMore.Text = "+50"
btnMore.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMore.Font = Enum.Font.GothamBold
btnMore.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
btnMore.Parent = speedFrame

local btnMoreCorner = Instance.new("UICorner")
btnMoreCorner.CornerRadius = UDim.new(0, 6)
btnMoreCorner.Parent = btnMore

-- Status do Auto-Fly
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.85, 0)
statusLabel.Text = "● Auto-Fly Ovo: ATIVO"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = frame

-- CONTROLE DE VELOCIDADE
btnLess.MouseButton1Click:Connect(function()
    VELOCIDADE_VOO = math.max(100, VELOCIDADE_VOO - 50)
    speedLabel.Text = "Vel: " .. VELOCIDADE_VOO
end)

btnMore.MouseButton1Click:Connect(function()
    VELOCIDADE_VOO = math.min(1000, VELOCIDADE_VOO + 50)
    speedLabel.Text = "Vel: " .. VELOCIDADE_VOO
end)

-- FUNÇÃO DE VÔO ULTRA-RÁPIDO
local voando = false

local function voarParaBase()
    if voando then return end
    if not basePart or not basePart.Parent then return end
    
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    voando = true
    
    -- Destino no topo da base criada
    local destino = basePart.Position + Vector3.new(0, 3.5, 0)
    local distancia = (destino - hrp.Position).Magnitude
    local tempoVoo = distancia / VELOCIDADE_VOO
    
    -- Noclip automático durante o trajeto
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    hrp.Velocity = Vector3.new(0, 0, 0)
    
    -- Animação de movimento
    local tweenInfo = TweenInfo.new(tempoVoo, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(destino)})
    
    tween:Play()
    tween.Completed:Connect(function()
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
        hrp.Velocity = Vector3.new(0, 0, 0)
        voando = false
    end)
end

-- Eventos dos Botões
btnCriar.MouseButton1Click:Connect(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        if basePart and basePart.Parent then
            basePart:Destroy()
        end
        
        basePart = Instance.new("Part")
        basePart.Name = "BaseWSG_" .. player.Name
        basePart.Size = Vector3.new(20, 1, 20)
        basePart.Position = hrp.Position - Vector3.new(0, 3, 0)
        basePart.Anchored = true
        basePart.CanCollide = true
        basePart.Material = Enum.Material.Neon
        basePart.Color = Color3.fromRGB(0, 170, 255)
        basePart.Parent = workspace
        
        btnCriar.Text = "Base Criada!"
        task.wait(1.2)
        btnCriar.Text = "Criar Base no Chão"
    end
end)

btnVoo.MouseButton1Click:Connect(function()
    if basePart and basePart.Parent then
        voarParaBase()
    else
        btnVoo.Text = "Crie a base primeiro!"
        task.wait(1.2)
        btnVoo.Text = "Voar para Base"
    end
end)

-- DETECÇÃO AUTOMÁTICA DE OVO / ITEM
local function checarEVoar(item)
    if not basePart or not basePart.Parent then return end
    
    if item:IsA("Tool") or string.find(string.lower(item.Name), "egg") or string.find(string.lower(item.Name), "ovo") then
        voarParaBase()
    end
end

player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(checarEVoar)
end)

if player.Character then
    player.Character.ChildAdded:Connect(checarEVoar)
end

player.Backpack.ChildAdded:Connect(checarEVoar)
