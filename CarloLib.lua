-- ====================================================================================
-- CARLOLIB V4.0 - PASTEL BLUE EDITION (FULL INTEGRATED FOR CLARO MASTER)
-- ====================================================================================

local CarloLib = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

function CarloLib:CreateWindow(options)
    options = options or {}
    local titleText = options.Title or "Carlo UI"
    local theme = options.Theme or {
        MainColor = Color3.fromRGB(235, 245, 251),
        AccentColor = Color3.fromRGB(93, 173, 226),
        BackgroundColor = Color3.fromRGB(214, 234, 248),
        TextColor = Color3.fromRGB(46, 64, 87)
    }

    if CoreGui:FindFirstChild("CarloLibUI") then
        CoreGui.CarloLibUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CarloLibUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = theme.MainColor
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = theme.BackgroundColor
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = Header
    TitleLabel.Text = titleText
    TitleLabel.Font = Enum.Font.FredokaOne
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = theme.TextColor
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0, 350, 1, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.Size = UDim2.new(0, 150, 1, -40)
    Sidebar.BackgroundColor3 = theme.BackgroundColor
    Sidebar.BorderSizePixel = 0

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 12)
    SidebarCorner.Parent = Sidebar

    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Name = "ContainerHolder"
    ContainerHolder.Parent = MainFrame
    ContainerHolder.Position = UDim2.new(0, 160, 0, 50)
    ContainerHolder.Size = UDim2.new(1, -170, 1, -60)
    ContainerHolder.BackgroundTransparency = 1

    local OriginalSize = MainFrame.Size
    local IsMinimized = false

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = Header
    CloseBtn.Text = "×"
    CloseBtn.Font = Enum.Font.FredokaOne
    CloseBtn.TextSize = 22
    CloseBtn.TextColor3 = theme.TextColor
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.ZIndex = 100
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui.Enabled = false end)

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Header
    MinimizeBtn.Text = "−"
    MinimizeBtn.Font = Enum.Font.FredokaOne
    MinimizeBtn.TextSize = 22
    MinimizeBtn.TextColor3 = theme.TextColor
    MinimizeBtn.Position = UDim2.new(1, -65, 0, 5)
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.ZIndex = 100

    MinimizeBtn.MouseButton1Click:Connect(function()
        IsMinimized = not IsMinimized
        if IsMinimized then
            MainFrame:TweenSize(UDim2.new(OriginalSize.X.Scale, OriginalSize.X.Offset, 0, 40), "Out", "Quad", 0.2, true)
            MinimizeBtn.Text = "+"
            Sidebar.Visible = false
            ContainerHolder.Visible = false
        else
            MainFrame:TweenSize(OriginalSize, "Out", "Quad", 0.2, true)
            MinimizeBtn.Text = "−"
            task.wait(0.1)
            Sidebar.Visible = true
            ContainerHolder.Visible = true
        end
    end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.RightControl then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    local tabCount = 0
    local currentTab = nil
    local windowMethods = {}

    function windowMethods:CreateTab(tabName)
        tabCount = tabCount + 1
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = Sidebar
        TabBtn.Text = tabName
        TabBtn.Size = UDim2.new(1, -10, 0, 35)
        TabBtn.Position = UDim2.new(0, 5, 0, (tabCount - 1) * 40 + 5)
        TabBtn.Font = Enum.Font.FredokaOne
        TabBtn.TextSize = 13
        TabBtn.TextColor3 = theme.TextColor
        TabBtn.BackgroundColor3 = theme.MainColor
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabContainer = Instance.new("ScrollingFrame")
        TabContainer.Parent = ContainerHolder
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.ScrollBarThickness = 4
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, 600)
        TabContainer.Visible = false

        local elementCount = 0

        if tabCount == 1 then
            TabContainer.Visible = true
            TabBtn.BackgroundColor3 = theme.AccentColor
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            currentTab = {Btn = TabBtn, Container = TabContainer}
        end

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Container.Visible = false
                currentTab.Btn.BackgroundColor3 = theme.MainColor
                currentTab.Btn.TextColor3 = theme.TextColor
            end
            TabContainer.Visible = true
            TabBtn.BackgroundColor3 = theme.AccentColor
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            currentTab = {Btn = TabBtn, Container = TabContainer}
        end)

        local tabMethods = {}

        -- Thành phần UI: Toggle
        function tabMethods:CreateToggle(toggleName, defaultState, callback)
            elementCount = elementCount + 1
            local enabled = defaultState or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -5, 0, 35)
            ToggleFrame.Position = UDim2.new(0, 0, 0, (elementCount - 1) * 40)
            ToggleFrame.BackgroundColor3 = theme.BackgroundColor
            ToggleFrame.Parent = TabContainer
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Text = toggleName
            Label.Font = Enum.Font.FredokaOne
            Label.TextSize = 13
            Label.TextColor3 = theme.TextColor
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = ToggleFrame

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0, 50, 0, 23)
            Btn.Position = UDim2.new(1, -60, 0.5, -11)
            Btn.Font = Enum.Font.FredokaOne
            Btn.TextSize = 11
            Btn.Parent = ToggleFrame
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

            local function updateToggle()
                Btn.Text = enabled and "ON" or "OFF"
                Btn.BackgroundColor3 = enabled and theme.AccentColor or Color3.fromRGB(200, 200, 200)
                Btn.TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or theme.TextColor
            end
            updateToggle()

            Btn.MouseButton1Click:Connect(function()
                enabled = not enabled
                updateToggle()
                callback(enabled)
            end)

            local toggleObj = {}
            function toggleObj:SetState(state)
                enabled = state
                updateToggle()
            end
            return toggleObj
        end

        -- Thành phần UI: Slider
        function tabMethods:CreateSlider(sliderName, min, max, default, callback)
            elementCount = elementCount + 1

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -5, 0, 45)
            SliderFrame.Position = UDim2.new(0, 0, 0, (elementCount - 1) * 40)
            SliderFrame.BackgroundColor3 = theme.BackgroundColor
            SliderFrame.Parent = TabContainer
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Text = sliderName .. ": " .. tostring(default)
            Label.Font = Enum.Font.FredokaOne
            Label.TextSize = 12
            Label.TextColor3 = theme.TextColor
            Label.Size = UDim2.new(1, -20, 0, 20)
            Label.Position = UDim2.new(0, 10, 0, 2)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = SliderFrame

            local BarBg = Instance.new("Frame")
            BarBg.Size = UDim2.new(1, -20, 0, 6)
            BarBg.Position = UDim2.new(0, 10, 0, 28)
            BarBg.BackgroundColor3 = theme.MainColor
            BarBg.Parent = SliderFrame
            Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 3)

            local Bar = Instance.new("Frame")
            Bar.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Bar.BackgroundColor3 = theme.AccentColor
            Bar.Parent = BarBg
            Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 3)

            local SliderBtn = Instance.new("TextButton")
            SliderBtn.Size = UDim2.new(0, 14, 0, 14)
            SliderBtn.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
            SliderBtn.BackgroundColor3 = theme.AccentColor
            SliderBtn.Text = ""
            SliderBtn.Parent = BarBg
            Instance.new("UICorner", SliderBtn).CornerRadius = UDim.new(0, 7)

            local dragging = false
            SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percentage = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                    SliderBtn.Position = UDim2.new(percentage, -7, 0.5, -7)
                    Bar.Size = UDim2.new(percentage, 0, 1, 0)
                    local val = min + (percentage * (max - min))
                    val = math.floor(val * 100) / 100
                    Label.Text = sliderName .. ": " .. tostring(val)
                    callback(val)
                end
            end)
        end

        -- Thành phần UI: Dropdown nâng cấp dạng trượt xổ xuống
        function tabMethods:CreateDropdown(dropdownName, list, default, callback)
            elementCount = elementCount + 1
            local selected = default or list[1]
            local isOpened = false

            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, -5, 0, 35)
            DropFrame.Position = UDim2.new(0, 0, 0, (elementCount - 1) * 40)
            DropFrame.BackgroundColor3 = theme.BackgroundColor
            DropFrame.Parent = TabContainer
            DropFrame.ZIndex = 100 - elementCount
            Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Text = dropdownName
            Label.Font = Enum.Font.FredokaOne
            Label.TextSize = 13
            Label.TextColor3 = theme.TextColor
            Label.Size = UDim2.new(0.5, 0, 0, 35)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = DropFrame

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0, 120, 0, 25)
            Btn.Position = UDim2.new(1, -130, 0, 5)
            Btn.Font = Enum.Font.FredokaOne
            Btn.TextSize = 11
            Btn.Text = tostring(selected) .. " ▾"
            Btn.BackgroundColor3 = theme.MainColor
            Btn.TextColor3 = theme.TextColor
            Btn.Parent = DropFrame
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

            local ScrollList = Instance.new("ScrollingFrame")
            ScrollList.Size = UDim2.new(0, 120, 0, 0)
            ScrollList.Position = UDim2.new(1, -130, 0, 32)
            ScrollList.BackgroundColor3 = theme.MainColor
            ScrollList.BorderSizePixel = 0
            ScrollList.ZIndex = 999
            ScrollList.Visible = false
            ScrollList.ScrollBarThickness = 3
            ScrollList.Parent = DropFrame
            Instance.new("UICorner", ScrollList).CornerRadius = UDim.new(0, 4)

            local listLayout = Instance.new("UIListLayout")
            listLayout.Parent = ScrollList

            for _, option in ipairs(list) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 25)
                OptBtn.Text = tostring(option)
                OptBtn.Font = Enum.Font.FredokaOne
                OptBtn.TextSize = 11
                OptBtn.TextColor3 = theme.TextColor
                OptBtn.BackgroundTransparency = 1
                OptBtn.ZIndex = 1000
                OptBtn.Parent = ScrollList

                OptBtn.MouseButton1Click:Connect(function()
                    selected = option
                    Btn.Text = tostring(selected) .. " ▾"
                    ScrollList.Size = UDim2.new(0, 120, 0, 0)
                    ScrollList.Visible = false
                    isOpened = false
                    callback(selected)
                end)
            end

            Btn.MouseButton1Click:Connect(function()
                isOpened = not isOpened
                if isOpened then
                    ScrollList.Visible = true
                    ScrollList:TweenSize(UDim2.new(0, 120, 0, math.min(#list * 25, 100)), "Out", "Quad", 0.15, true)
                    ScrollList.CanvasSize = UDim2.new(0, 0, 0, #list * 25)
                else
                    ScrollList:TweenSize(UDim2.new(0, 120, 0, 0), "Out", "Quad", 0.15, true)
                    task.wait(0.15)
                    ScrollList.Visible = false
                end
            end)
        end

        return tabMethods
    end

    return windowMethods
end

return CarloLib
