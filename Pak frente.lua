--[[
    ██████╗  █████╗ ██╗  ██╗    ██╗  ██╗██╗   ██╗██████╗ 
    ██╔══██╗██╔══██╗██║ ██╔╝    ██║  ██║██║   ██║██╔══██╗
    ██████╔╝███████║█████╔╝     ███████║██║   ██║██████╔╝
    ██╔═══╝ ██╔══██║██╔═██╗     ██╔══██║██║   ██║██╔══██╗
    ██║     ██║  ██║██║  ██╗    ██║  ██║╚██████╔╝██████╔╝
    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
                PAK HUB - FRENTE PERDIDA EDITION
                         KEY: PakTop1
]]

--// SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

--// CONFIGURAÇÕES
local CONFIG = {
    KEY_CORRETA = "PakTop1",
    CRIADOR = "PAKDJDIHR",
    COR_PRIMARIA = Color3.fromRGB(138, 43, 226),
    COR_SECUNDARIA = Color3.fromRGB(180, 80, 255),
    COR_FUNDO = Color3.fromRGB(20, 15, 30),
    COR_PAINEL = Color3.fromRGB(30, 22, 45),
    COR_SIDEBAR = Color3.fromRGB(25, 18, 38),
    COR_TEXTO = Color3.fromRGB(240, 240, 255),
    COR_SUBTEXTO = Color3.fromRGB(160, 150, 180),
    COR_ALVO_OK = Color3.fromRGB(138, 43, 226),
    COR_ALVO_BLOQ = Color3.fromRGB(255, 50, 50),
    FONTE = Enum.Font.GothamMedium,
    FONTE_BOLD = Enum.Font.GothamBold,
}

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

--// ESTADOS
local State = {
    Aimbot = false, AimbotFOV = 120, AimbotSuave = 0.5,
    VerificarParedes = false, IgnorarTimeECorpos = false,
    ESP = false, Box = false, Lines = false, Name = false,
    Distance = false, Health = false,
    Speed = false, SpeedValue = 25, Noclip = false,
    Spinbot = false, SpinSpeed = 10, AntiAFK = true,
}

--// LIMPAR GUI ANTERIOR
for _, name in pairs({"PAK_HUB", "PAK_HUB_V2"}) do
    pcall(function()
        if CoreGui:FindFirstChild(name) then CoreGui:FindFirstChild(name):Destroy() end
    end)
    pcall(function()
        if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild(name) then
            LocalPlayer.PlayerGui:FindFirstChild(name):Destroy()
        end
    end)
end

--// CRIAR GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PAK_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = (RunService:IsStudio() and LocalPlayer:WaitForChild("PlayerGui")) or CoreGui
local function criar(c, p) local i = Instance.new(c); for k,v in pairs(p) do i[k]=v end; return i end
local function arredondar(i,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 8); c.Parent=i end
local function gradiente(i,c1,c2,r) local g=Instance.new("UIGradient"); g.Color=ColorSequence.new(c1,c2); g.Rotation=r or 90; g.Parent=i end
local function sombra(i) local s=Instance.new("UIStroke"); s.Color=CONFIG.COR_PRIMARIA; s.Thickness=1; s.Transparency=0.5; s.Parent=i end

local KeyScreen = criar("Frame", {Size=UDim2.new(0,340,0,260),Position=UDim2.new(0.5,-170,0.5,-130),BackgroundColor3=CONFIG.COR_PAINEL,BorderSizePixel=0,Parent=ScreenGui})
arredondar(KeyScreen,14); gradiente(KeyScreen,CONFIG.COR_PAINEL,CONFIG.COR_FUNDO,135); sombra(KeyScreen)

criar("TextLabel", {Size=UDim2.new(1,0,0,50),Position=UDim2.new(0,0,0,25),BackgroundTransparency=1,Text="PAK HUB",TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=28,Parent=KeyScreen})

local keyBox = criar("TextBox", {Size=UDim2.new(0,260,0,46),Position=UDim2.new(0.5,-130,0,110),BackgroundColor3=CONFIG.COR_FUNDO,BorderSizePixel=0,PlaceholderText="Digite sua Key...",PlaceholderColor3=CONFIG.COR_SUBTEXTO,TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE,TextSize=15,Parent=KeyScreen,ClearTextOnFocus=false})
arredondar(keyBox,10)

local confirmBtn = criar("TextButton", {Size=UDim2.new(0,260,0,46),Position=UDim2.new(0.5,-130,0,175),BackgroundColor3=CONFIG.COR_PRIMARIA,BorderSizePixel=0,Text="CONFIRMAR",TextColor3=Color3.fromRGB(255,255,255),Font=CONFIG.FONTE_BOLD,TextSize=15,Parent=KeyScreen,AutoButtonColor=false})
arredondar(confirmBtn,10); gradiente(confirmBtn,CONFIG.COR_PRIMARIA,CONFIG.COR_SECUNDARIA,0)

local errorLabel = criar("TextLabel", {Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,1,-22),BackgroundTransparency=1,Text="",TextColor3=Color3.fromRGB(255,80,80),Font=CONFIG.FONTE,TextSize=12,Parent=KeyScreen})
local Hub = criar("Frame", {Size=UDim2.new(0,520,0,360),Position=UDim2.new(0.5,-260,0.5,-180),BackgroundColor3=CONFIG.COR_PAINEL,BorderSizePixel=0,Parent=ScreenGui,Visible=false,ClipsDescendants=true,Active=true,BackgroundTransparency=0.15})
arredondar(Hub,14); sombra(Hub)

local hubTopBar = criar("Frame", {Size=UDim2.new(1,0,0,42),BackgroundColor3=CONFIG.COR_FUNDO,BackgroundTransparency=0.2,BorderSizePixel=0,Parent=Hub,ZIndex=5})
arredondar(hubTopBar,14)

local hubTitle = criar("TextLabel", {Size=UDim2.new(0,200,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="PAK HUB",TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=16,TextXAlignment=Enum.TextXAlignment.Left,Parent=hubTopBar,ZIndex=6})

local minimBtn = criar("TextButton", {Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-74,0.5,-15),BackgroundColor3=CONFIG.COR_PAINEL,BorderSizePixel=0,Text="−",TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=20,Parent=hubTopBar,Parent=hubTopBar,AutoButtonColor=false,ZIndex=6})
arredondar(minimBtn,8)

local closeBtn = criar("TextButton", {Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-38,0.5,-15),BackgroundColor3=CONFIG.COR_PAINEL,BorderSizePixel=0,Text="×",TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=20,Parent=hubTopBar,AutoButtonColor=false,ZIndex=6})
arredondar(closeBtn,8)

local Sidebar = criar("Frame", {Size=UDim2.new(0,130,1,-52),Position=UDim2.new(0,10,0,48),BackgroundColor3=CONFIG.COR_SIDEBAR,BackgroundTransparency=0.15,BorderSizePixel=0,Parent=Hub,ZIndex=5})
arredondar(Sidebar,10)
criar("UIListLayout", {Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=Sidebar})

local ContentArea = criar("Frame", {Size=UDim2.new(1,-150,1,-52),Position=UDim2.new(0,148,0,48),BackgroundColor3=CONFIG.COR_FUNDO,BackgroundTransparency=0.25,BorderSizePixel=0,Parent=Hub,ClipsDescendants=true,ZIndex=5})
arredondar(ContentArea,10)

local pageTitle = criar("TextLabel", {Size=UDim2.new(1,-20,0,30),Position=UDim2.new(0,10,0,8),BackgroundTransparency=1,Text="",TextColor3=CONFIG.COR_PRIMARIA,Font=CONFIG.FONTE_BOLD,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left,Parent=ContentArea,ZIndex=6})

local ContentScroll = criar("ScrollingFrame", {Size=UDim2.new(1,-16,1,-48),Position=UDim2.new(0,8,0,42),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=CONFIG.COR_PRIMARIA,CanvasSize=UDim2.new(0,0,0,0),Parent=ContentArea,ZIndex=6})
criar("UIListLayout", {Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ContentScroll})

local FloatingBall = criar("TextButton", {Size=UDim2.new(0,50,0,50),Position=UDim2.new(0,20,0.5,-25),BackgroundColor3=CONFIG.COR_PRIMARIA,BorderSizePixel=0,Text="P",TextColor3=Color3.fromRGB(255,255,255),Font=CONFIG.FONTE_BOLD,TextSize=20,Parent=ScreenGui,Visible=false,AutoButtonColor=false})
arredondar(FloatingBall,25)
local Pages, CurrentPage, SidebarButtons = {}, nil, {}

local function criarCategoria(nome, icone)
    local btn = criar("TextButton", {Size=UDim2.new(1,0,0,32),BackgroundColor3=CONFIG.COR_PAINEL,BackgroundTransparency=0.15,BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=Sidebar,ZIndex=6})
    arredondar(btn,6)
    local iconLabel = criar("TextLabel", {Size=UDim2.new(0,24,1,0),Position=UDim2.new(0,6,0,0),BackgroundTransparency=1,Text=icone or "▸",TextColor3=CONFIG.COR_PRIMARIA,Font=CONFIG.FONTE_BOLD,TextSize=14,Parent=btn,ZIndex=7})
    local nameLabel = criar("TextLabel", {Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,30,0,0),BackgroundTransparency=1,Text=nome,TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=btn,ZIndex=7})
    local page = criar("Frame", {Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=1,Visible=false,Parent=ContentScroll,ZIndex=7})
    criar("UIListLayout", {Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=page})
    Pages[nome] = page
    SidebarButtons[nome] = {btn=btn, icon=iconLabel, label=nameLabel}
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible=false end
        for _, b in pairs(SidebarButtons) do
            TweenService:Create(b.btn,TweenInfo.new(0.15),{BackgroundColor3=CONFIG.COR_PAINEL}):Play()
            b.icon.TextColor3 = CONFIG.COR_PRIMARIA
            b.label.TextColor3 = CONFIG.COR_TEXTO
        end
        Pages[nome].Visible = true
        TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=CONFIG.COR_PRIMARIA}):Play()
        iconLabel.TextColor3 = Color3.fromRGB(255,255,255)
        nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
        pageTitle.Text = nome
        CurrentPage = nome
    end)
    return page
end

local function criarToggle(parent, nome, descricao, callback)
    local container = criar("Frame", {Size=UDim2.new(1,-6,0,46),BackgroundColor3=CONFIG.COR_PAINEL,BackgroundTransparency=0.1,BorderSizePixel=0,LayoutOrder=#parent:GetChildren(),Parent=parent,ZIndex=7})
    arredondar(container,8)
    criar("TextLabel", {Size=UDim2.new(0.7,0,0,20),Position=UDim2.new(0,12,0,6),BackgroundTransparency=1,Text=nome,TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=container,ZIndex=8})
    criar("TextLabel", {Size=UDim2.new(0.7,0,0,16),Position=UDim2.new(0,12,0,24),BackgroundTransparency=1,Text=descricao or "",TextColor3=CONFIG.COR_SUBTEXTO,Font=CONFIG.FONTE,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,Parent=container,ZIndex=8})
    local toggleBg = criar("Frame", {Size=UDim2.new(0,40,0,20),Position=UDim2.new(1,-52,0.5,-10),BackgroundColor3=Color3.fromRGB(60,55,75),BorderSizePixel=0,Parent=container,ZIndex=8})
    arredondar(toggleBg,10)
    local circle = criar("Frame", {Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,2,0.5,-8),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=toggleBg,ZIndex=9})
    arredondar(circle,8)
    local ativo = false
    local btn = criar("TextButton", {Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=container,ZIndex=9})
    btn.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            TweenService:Create(toggleBg,TweenInfo.new(0.2),{BackgroundColor3=CONFIG.COR_PRIMARIA}):Play()
            TweenService:Create(circle,TweenInfo.new(0.2),{Position=UDim2.new(1,-18,0.5,-8)}):Play()
        else
            TweenService:Create(toggleBg,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,55,75)}):Play()
            TweenService:Create(circle,TweenInfo.new(0.2),{Position=UDim2.new(0,2,0.5,-8)}):Play()
        end
        if callback then callback(ativo) end
    end)
end

local function criarSlider(parent, nome, min, max, padrao, callback)
    local container = criar("Frame", {Size=UDim2.new(1,-6,0,50),BackgroundColor3=CONFIG.COR_PAINEL,BackgroundTransparency=0.1,BorderSizePixel=0,LayoutOrder=#parent:GetChildren(),Parent=parent,ZIndex=7})
    arredondar(container,8)
    criar("TextLabel", {Size=UDim2.new(0.7,0,0,18),Position=UDim2.new(0,12,0,4),BackgroundTransparency=1,Text=nome,TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=container,ZIndex=8})
    local valorLabel = criar("TextLabel", {Size=UDim2.new(0.25,0,0,18),Position=UDim2.new(0.7,0,0,4),BackgroundTransparency=1,Text=tostring(padrao),TextColor3=CONFIG.COR_PRIMARIA,Font=CONFIG.FONTE_BOLD,TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,Parent=container,ZIndex=8})
    local barBg = criar("Frame", {Size=UDim2.new(1,-24,0,6),Position=UDim2.new(0,12,0,32),BackgroundColor3=CONFIG.COR_FUNDO,BorderSizePixel=0,Parent=container,ZIndex=8})
    arredondar(barBg,3)
    local fill = criar("Frame", {Size=UDim2.new((padrao-min)/(max-min),0,1,0),BackgroundColor3=CONFIG.COR_PRIMARIA,BorderSizePixel=0,Parent=barBg,ZIndex=8})
    arredondar(fill,3)
    local knob = criar("Frame", {Size=UDim2.new(0,14,0,14),Position=UDim2.new((padrao-min)/(max-min),-7,0.5,-7),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=barBg,ZIndex=9})
    arredondar(knob,7)
    local dragging = false
    local btn = criar("TextButton", {Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=barBg,ZIndex=10})
    local function update(input)
        local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X)/barBg.AbsoluteSize.X,0,1)
        local val = math.floor(min + (max-min)*pos)
        valorLabel.Text = tostring(val)
        TweenService:Create(fill,TweenInfo.new(0.05),{Size=UDim2.new(pos,0,1,0)}):Play()
        TweenService:Create(knob,TweenInfo.new(0.05),{Position=UDim2.new(pos,-7,0.5,-7)}):Play()
        if callback then callback(val) end
    end
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; update(input)
        end
    end)
    btn.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

-- ABAS
local p1 = criarCategoria("COMBAT", "⚔")
criarToggle(p1, "Aimbot", "Mira automática", function(v) State.Aimbot = v end)
criarSlider(p1, "Aimbot FOV", 30, 500, 120, function(v) State.AimbotFOV = v end)
criarToggle(p1, "Verificar Paredes", "Só mira se visível", function(v) State.VerificarParedes = v end)
criarToggle(p1, "Ignorar Time & Corpos", "Não mira aliados/mortos", function(v) State.IgnorarTimeECorpos = v end)

local p2 = criarCategoria("VISUALS", "👁")
criarToggle(p2, "ESP Geral", "Liga/desliga todos", function(v) State.ESP = v end)
criarToggle(p2, "Box", "Caixa ao redor", function(v) State.Box = v end)
criarToggle(p2, "Linhas", "Linhas até o jogador", function(v) State.Lines = v end)
criarToggle(p2, "Nomes", "Nome acima", function(v) State.Name = v end)
criarToggle(p2, "Distância", "Distância em metros", function(v) State.Distance = v end)
criarToggle(p2, "Vida", "Barra de vida", function(v) State.Health = v end)

local p3 = criarCategoria("MOVEMENT", "🏃")
criarToggle(p3, "Speed", "Aumenta velocidade", function(v) State.Speed = v end)
criarSlider(p3, "Speed Value", 16, 200, 25, function(v) State.SpeedValue = v end)
criarToggle(p3, "Noclip", "Atravessar paredes", function(v) State.Noclip = v end)
criarToggle(p3, "Spinbot", "Girar personagem", function(v) State.Spinbot = v end)
criarSlider(p3, "Spin Speed", 1, 50, 10, function(v) State.SpinSpeed = v end)

local p4 = criarCategoria("CRÉDITOS", "★")
local cc = criar("Frame", {Size=UDim2.new(1,-6,0,150),BackgroundColor3=CONFIG.COR_PAINEL,BackgroundTransparency=0.1,BorderSizePixel=0,LayoutOrder=1,Parent=p4,ZIndex=7})
arredondar(cc,8)
criar("TextLabel", {Size=UDim2.new(1,0,0,25),Position=UDim2.new(0,0,0,50),BackgroundTransparency=1,Text="PAKDJDIHR",TextColor3=CONFIG.COR_TEXTO,Font=CONFIG.FONTE_BOLD,TextSize=16,Parent=cc,ZIndex=8})
criar("TextLabel", {Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0,75),BackgroundTransparency=1,Text="Criador do PAK HUB",TextColor3=CONFIG.COR_SUBTEXTO,Font=CONFIG.FONTE,TextSize=11,Parent=cc,ZIndex=8})
criar("TextLabel", {Size=UDim2.new(1,0,0,25),Position=UDim2.new(0,0,0,105),BackgroundTransparency=1,Text="Obrigado por usar!",TextColor3=CONFIG.COR_PRIMARIA,Font=CONFIG.FONTE_BOLD,TextSize=13,Parent=cc,ZIndex=8})

task.wait(0.1)
if SidebarButtons["COMBAT"] then
    for _, p in pairs(Pages) do p.Visible = false end
    Pages["COMBAT"].Visible = true
    TweenService:Create(SidebarButtons["COMBAT"].btn,TweenInfo.new(0.15),{BackgroundColor3=CONFIG.COR_PRIMARIA}):Play()
    pageTitle.Text = "COMBAT"
end

-- DRAG
local function makeDraggable(frame, handle)
    local dragging, dragStart, startPos
    handle = handle or frame
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        end
    end)
end
makeDraggable(Hub, hubTopBar)
makeDraggable(KeyScreen, KeyScreen)
makeDraggable(FloatingBall)

-- VERIFICAÇÃO
confirmBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == CONFIG.KEY_CORRETA then
        KeyScreen:Destroy()
        Hub.Visible = true
    else
        errorLabel.Text = "✗ Key inválida"
        task.wait(1.5)
        errorLabel.Text = ""
    end
end)

minimBtn.MouseButton1Click:Connect(function() Hub.Visible = false; FloatingBall.Visible = true end)
FloatingBall.MouseButton1Click:Connect(function() FloatingBall.Visible = false; Hub.Visible = true end)
closeBtn.MouseButton1Click:Connect(function() Hub.Visible = false; FloatingBall.Visible = true end)
--// MÓDULO ESP
local espObjects = {}
local function criarESP(player)
    if player == LocalPlayer or espObjects[player] then return end
    espObjects[player] = {
        box = Drawing.new("Square"), name = Drawing.new("Text"),
        dist = Drawing.new("Text"), health = Drawing.new("Line"),
        line = Drawing.new("Line"),
    }
    for _, o in pairs(espObjects[player]) do o.Visible = false end
    espObjects[player].box.Thickness = 1.5
    espObjects[player].box.Filled = false
    espObjects[player].name.Size = 14; espObjects[player].name.Center = true; espObjects[player].name.Outline = true
    espObjects[player].dist.Size = 12; espObjects[player].dist.Center = true; espObjects[player].dist.Outline = true
    espObjects[player].health.Thickness = 2
    espObjects[player].line.Thickness = 1
end
local function removerESP(player)
    if espObjects[player] then
        for _, o in pairs(espObjects[player]) do pcall(function() o:Remove() end) end
        espObjects[player] = nil
    end
end
Players.PlayerAdded:Connect(criarESP)
Players.PlayerRemoving:Connect(removerESP)
for _, p in pairs(Players:GetPlayers()) do criarESP(p) end

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5; fovCircle.Color = CONFIG.COR_PRIMARIA; fovCircle.Filled = false
fovCircle.Transparency = 0.7; fovCircle.NumSides = 60; fovCircle.Visible = false

local function temParedeNaFrente(char)
    if not char or not char:FindFirstChild("Head") then return true end
    local head = char.Head
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char, LocalPlayer.Character, Camera}
    local ray = Workspace:Raycast(Camera.CFrame.Position, head.Position - Camera.CFrame.Position, params)
    return ray ~= nil
end

local function eDoMesmoTime(p)
    if not p then return false end
    if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then return true end
    return false
end

local function estaMorto(p)
    if not p or not p.Character then return true end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    if not h then return true end
    if h.Health <= 0 then return true end
    local s = h:GetState()
    if s == Enum.HumanoidStateType.Dead or s == Enum.HumanoidStateType.Physics then return true end
    return false
end

local function deveIgnorar(p)
    if not State.IgnorarTimeECorpos then return false end
    if eDoMesmoTime(p) or estaMorto(p) then return true end
    return false
end

task.spawn(function()
    while task.wait(60) do
        if State.AntiAFK then pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end) end
    end
end)

RunService.Stepped:Connect(function()
    if State.Noclip then
        local c = LocalPlayer.Character
        if c then for _, v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end end
    end
end)

RunService.RenderStepped:Connect(function()
    if State.Speed then
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c:FindFirstChildOfClass("Humanoid").WalkSpeed = State.SpeedValue
        end
    end

    if State.Aimbot then
        fovCircle.Visible = true; fovCircle.Radius = State.AimbotFOV
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    else fovCircle.Visible = false end

    for p, o in pairs(espObjects) do
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChild("Humanoid") then
            local hrp = c.HumanoidRootPart; local hum = c.Humanoid
            local pos, on = Camera:WorldToViewportPoint(hrp.Position)
            if on and State.ESP and hum.Health > 0 then
                local head = c:FindFirstChild("Head")
                if head then
                    local hp = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                    local fp = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
                    local h = math.abs(hp.Y - fp.Y); local w = h/2
                    local ok = not temParedeNaFrente(c)
                    local cor = ok and CONFIG.COR_ALVO_OK or CONFIG.COR_ALVO_BLOQ
                    if State.Box then
                        o.box.Visible = true
                        o.box.Size = Vector2.new(w,h)
                        o.box.Position = Vector2.new(pos.X-w/2, pos.Y-h/2)
                        o.box.Color = cor
                    else o.box.Visible = false end
                    if State.Name then
                        o.name.Visible = true; o.name.Text = p.Name
                        o.name.Position = Vector2.new(pos.X, pos.Y-h/2-18)
                    else o.name.Visible = false end
                    if State.Distance then
                        o.dist.Visible = true
                        o.dist.Text = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude).."m"
                        o.dist.Position = Vector2.new(pos.X, pos.Y+h/2+4)
                    else o.dist.Visible = false end
                    if State.Health then
                        o.health.Visible = true
                        local hpc = hum.Health/hum.MaxHealth
                        o.health.From = Vector2.new(pos.X-w/2-8, pos.Y+h/2)
                        o.health.To = Vector2.new(pos.X-w/2-8, pos.Y+h/2-(h*hpc))
                        o.health.Color = Color3.fromRGB(255*(1-hpc), 255*hpc, 0)
                    else o.health.Visible = false end
                    if State.Lines then
                        o.line.Visible = true
                        o.line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        o.line.To = Vector2.new(pos.X, pos.Y+h/2)
                        o.line.Color = cor
                    else o.line.Visible = false end
                end
            else
                for _, v in pairs(o) do v.Visible = false end
            end
        end
    end

    if State.Aimbot then
        local ctr = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local cl, cd = nil, State.AimbotFOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if not deveIgnorar(p) then
                    local ch = p.Character
                    if not (State.VerificarParedes and temParedeNaFrente(ch)) then
                        local pos, on = Camera:WorldToViewportPoint(ch.Head.Position)
                        if on then
                            local d = (Vector2.new(pos.X,pos.Y)-ctr).Magnitude
                            if d < cd then cd = d; cl = ch.Head end
                        end
                    end
                end
            end
        end
        if cl then Camera.CFrame = CFrame.new(Camera.CFrame.Position, cl.Position) end
    end

    if State.Spinbot then
        local c = LocalPlayer.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed), 0)
        end
    end
end)

StarterGui:SetCore("SendNotification", {Title="PAK HUB", Text="Carregado! Key: PakTop1", Duration=5})
