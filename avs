--idk
local Library = {}

function Library.CreateLib(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ExampleHub"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainFrameCorner = Instance.new("UICorner")
    MainFrameCorner.CornerRadius = UDim.new(0, 12)
    MainFrameCorner.Parent = MainFrame

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -25, 0, 5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.BorderSizePixel = 0
    CloseButton.ZIndex = 2

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
    TitleBar.BorderColor3 = Color3.fromRGB(50, 55, 85)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.Text = title
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.TextSize = 18
    TitleBar.BorderSizePixel = 0

    local TitleBarCorner = Instance.new("UICorner")
    TitleBarCorner.CornerRadius = UDim.new(0, 12)
    TitleBarCorner.Parent = TitleBar

    local TabsFrame = Instance.new("Frame")
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Parent = MainFrame
    TabsFrame.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
    TabsFrame.Position = UDim2.new(0, 0, 0, 40)
    TabsFrame.Size = UDim2.new(0.3, 0, 1, -40)
    TabsFrame.BorderSizePixel = 0

    local TabsFrameCorner = Instance.new("UICorner")
    TabsFrameCorner.CornerRadius = UDim.new(0, 12)
    TabsFrameCorner.Parent = TabsFrame

    local ContentsFrame = Instance.new("Frame")
    ContentsFrame.Name = "ContentsFrame"
    ContentsFrame.Parent = MainFrame
    ContentsFrame.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
    ContentsFrame.Position = UDim2.new(0.3, 10, 0, 40)
    ContentsFrame.Size = UDim2.new(0.7, -12, 1, -40)
    ContentsFrame.BorderSizePixel = 0

    local ContentsFrameCorner = Instance.new("UICorner")
    ContentsFrameCorner.CornerRadius = UDim.new(0, 12)
    ContentsFrameCorner.Parent = ContentsFrame

    local TabButtons = {}
    local Tabs = {}  -- Track created tabs

    local function createTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Button"
        TabButton.Parent = TabsFrame
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
        TabButton.Size = UDim2.new(1, -20, 0, 40)
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 18
        TabButton.BorderSizePixel = 0

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 12)
        TabButtonCorner.Parent = TabButton

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Name = name .. "Content"
        ContentFrame.Parent = ContentsFrame
        ContentFrame.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.Visible = false
        ContentFrame.BorderSizePixel = 0

        local ContentFrameCorner = Instance.new("UICorner")
        ContentFrameCorner.CornerRadius = UDim.new(0, 12)
        ContentFrameCorner.Parent = ContentFrame

        TabButtons[name] = TabButton
        Tabs[name] = ContentFrame

        TabButton.MouseButton1Click:Connect(function()
            -- Hide all content frames
            for _, frame in pairs(ContentsFrame:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            -- Show the clicked tab's content frame
            ContentFrame.Visible = true

            -- Reset all tab buttons
            for _, btn in pairs(TabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
            end
            -- Highlight the selected tab button
            TabButton.BackgroundColor3 = Color3.fromRGB(90, 100, 150)
        end)

        return ContentFrame
    end

    local function getNextPosition(tabContent)
        local yPos = 5
        for _, child in ipairs(tabContent:GetChildren()) do
            if child:IsA("GuiObject") and child.Position.Y.Offset > yPos then
                yPos = child.Position.Y.Offset + child.Size.Y.Offset + 5
            end
        end
        return UDim2.new(0, 10, 0, yPos)
    end

    local function createButton(tabName, buttonName, callback)
        local tabContent = Tabs[tabName]
        if tabContent then
            local Button = Instance.new("TextButton")
            Button.Name = buttonName .. "Button"
            Button.Parent = tabContent
            Button.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.Position = getNextPosition(tabContent)
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 18
            Button.BorderSizePixel = 0

            local ButtonIcon = Instance.new("ImageLabel")
            ButtonIcon.Name = "ButtonIcon"
            ButtonIcon.Parent = Button
            ButtonIcon.BackgroundTransparency = 1
            ButtonIcon.Position = UDim2.new(0, 5, 0.5, -10)
            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
            ButtonIcon.Image = "rbxassetid://19004812116" -- Replace with your button icon asset ID
            ButtonIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

            local ButtonLabel = Instance.new("TextLabel")
            ButtonLabel.Name = "ButtonLabel"
            ButtonLabel.Parent = Button
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Position = UDim2.new(0, 30, 0, 0)
            ButtonLabel.Size = UDim2.new(1, -35, 1, 0)
            ButtonLabel.Font = Enum.Font.SourceSans
            ButtonLabel.Text = buttonName
            ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonLabel.TextSize = 18
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            ButtonLabel.TextYAlignment = Enum.TextYAlignment.Center
            ButtonLabel.TextTruncate = Enum.TextTruncate.AtEnd

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
            end)

            return Button
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createToggle(tabName, toggleName, callback)
        local tabContent = Tabs[tabName]
        if tabContent then
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = toggleName .. "Toggle"
            ToggleButton.Parent = tabContent
            ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            ToggleButton.Size = UDim2.new(1, -20, 0, 40)
            ToggleButton.Position = getNextPosition(tabContent)
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 18
            ToggleButton.BorderSizePixel = 0

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleButton
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 30, 0, 0)
            ToggleLabel.Size = UDim2.new(1, -35, 1, 0)
            ToggleLabel.Font = Enum.Font.SourceSans
            ToggleLabel.Text = toggleName
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 18
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.TextYAlignment = Enum.TextYAlignment.Center
            ToggleLabel.TextTruncate = Enum.TextTruncate.AtEnd

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Parent = ToggleButton

            local ToggleState = false
            ToggleButton.MouseButton1Click:Connect(function()
                ToggleState = not ToggleState
                ToggleButton.BackgroundColor3 = ToggleState and Color3.fromRGB(90, 100, 150) or Color3.fromRGB(70, 75, 105)
                if callback then
                    callback(ToggleState)
                end
            end)

            return ToggleButton
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createDropdown(tabName, dropdownName, options, callback)
        local tabContent = Tabs[tabName]
        if tabContent then
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = dropdownName .. "Dropdown"
            DropdownButton.Parent = tabContent
            DropdownButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            DropdownButton.Size = UDim2.new(1, -20, 0, 40)
            DropdownButton.Position = getNextPosition(tabContent)
            DropdownButton.Font = Enum.Font.SourceSans
            DropdownButton.Text = ""
            DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.TextSize = 18
            DropdownButton.BorderSizePixel = 0

            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Name = "DropdownLabel"
            DropdownLabel.Parent = DropdownButton
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Position = UDim2.new(0, 30, 0, 0)
            DropdownLabel.Size = UDim2.new(1, -35, 1, 0)
            DropdownLabel.Font = Enum.Font.SourceSans
            DropdownLabel.Text = dropdownName
            DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownLabel.TextSize = 18
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.TextYAlignment = Enum.TextYAlignment.Center
            DropdownLabel.TextTruncate = Enum.TextTruncate.AtEnd

            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Parent = DropdownButton

            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Parent = DropdownButton
            DropdownList.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Visible = false
            DropdownList.BorderSizePixel = 0

            local DropdownListCorner = Instance.new("UICorner")
            DropdownListCorner.CornerRadius = UDim.new(0, 8)
            DropdownListCorner.Parent = DropdownList

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.Parent = DropdownList
            DropdownListLayout.Padding = UDim.new(0, 5)

            for _, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = option
                OptionButton.Parent = DropdownList
                OptionButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
                OptionButton.Size = UDim2.new(1, -20, 0, 30)
                OptionButton.Font = Enum.Font.SourceSans
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.TextSize = 18
                OptionButton.BorderSizePixel = 0

                local OptionCorner = Instance.new("UICorner")
                OptionCorner.CornerRadius = UDim.new(0, 8)
                OptionCorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    DropdownLabel.Text = option
                    DropdownList.Visible = false
                    if callback then
                        callback(option)
                    end
                end)
            end

            DropdownButton.MouseButton1Click:Connect(function()
                DropdownList.Visible = not DropdownList.Visible
            end)

            return DropdownButton
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    -- Expose the functions
    Library.CreateTab = createTab
    Library.CreateButton = createButton
    Library.CreateToggle = createToggle
    Library.CreateDropdown = createDropdown

    return Library
end

return Library
