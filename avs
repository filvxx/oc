--[[

    This is the updated version of the library script.
    Make sure to replace this with the correct URL content.

--]]

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

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.Text = title
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.TextSize = 18
    TitleBar.BorderSizePixel = 0

    local TabsFrame = Instance.new("Frame")
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Parent = MainFrame
    TabsFrame.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
    TabsFrame.Position = UDim2.new(0, 0, 0, 40)
    TabsFrame.Size = UDim2.new(0.3, 0, 1, -40)
    TabsFrame.BorderSizePixel = 0

    local ContentsFrame = Instance.new("Frame")
    ContentsFrame.Name = "ContentsFrame"
    ContentsFrame.Parent = MainFrame
    ContentsFrame.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
    ContentsFrame.Position = UDim2.new(0.3, 10, 0, 40)
    ContentsFrame.Size = UDim2.new(0.7, -12, 1, -40)
    ContentsFrame.BorderSizePixel = 0

    local TabButtons = {}

    local function createTab(name, position)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Button"
        TabButton.Parent = TabsFrame
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
        TabButton.Position = UDim2.new(0, 10, 0, position)
        TabButton.Size = UDim2.new(1, -20, 0, 40)
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 18
        TabButton.BorderSizePixel = 0

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Name = name .. "Content"
        ContentFrame.Parent = ContentsFrame
        ContentFrame.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.Visible = false
        ContentFrame.BorderSizePixel = 0

        TabButtons[name] = TabButton

        TabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(ContentsFrame:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            ContentFrame.Visible = true
            for _, btn in pairs(TabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(90, 100, 150)
        end)

        return ContentFrame
    end

    local function getNextPosition(tabContent)
        local yPos = 5
        for _, child in ipairs(tabContent:GetChildren()) do
            if child:IsA("TextButton") then
                yPos = yPos + child.Size.Y.Offset + 5
            end
        end
        return UDim2.new(0, 10, 0, yPos)
    end

    local function createButton(tabName, buttonName, callback)
        local tabContent = ContentsFrame:FindFirstChild(tabName .. "Content")
        if tabContent then
            local Button = Instance.new("TextButton")
            Button.Name = buttonName .. "Button"
            Button.Parent = tabContent
            Button.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            Button.Position = getNextPosition(tabContent)
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.Font = Enum.Font.SourceSans
            Button.Text = buttonName
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 18
            Button.BorderSizePixel = 0

            Button.MouseButton1Click:Connect(callback)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createToggle(tabName, toggleName, callback)
        local tabContent = ContentsFrame:FindFirstChild(tabName .. "Content")
        if tabContent then
            local Toggle = Instance.new("TextButton")
            Toggle.Name = toggleName .. "Toggle"
            Toggle.Parent = tabContent
            Toggle.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            Toggle.Position = getNextPosition(tabContent)
            Toggle.Size = UDim2.new(1, -20, 0, 40)
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = toggleName
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 18
            Toggle.BorderSizePixel = 0

            local isToggled = false
            Toggle.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                Toggle.BackgroundColor3 = isToggled and Color3.fromRGB(90, 180, 90) or Color3.fromRGB(70, 75, 105)
                Toggle.Text = toggleName .. (isToggled and " (Enabled)" or "")
                callback(isToggled)
            end)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createDropdown(tabName, dropdownName, dropdownInfo, options, callback)
        local tabContent = ContentsFrame:FindFirstChild(tabName .. "Content")
        if tabContent then
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = dropdownName .. "Dropdown"
            Dropdown.Parent = tabContent
            Dropdown.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            Dropdown.Position = getNextPosition(tabContent)
            Dropdown.Size = UDim2.new(1, -20, 0, 40)

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Parent = Dropdown
            DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
            DropdownButton.Size = UDim2.new(1, 0, 0, 20)
            DropdownButton.Font = Enum.Font.SourceSans
            DropdownButton.Text = dropdownName
            DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.TextSize = 18
            DropdownButton.BorderSizePixel = 0

            local DropdownList = Instance.new("Frame")
            DropdownList.Parent = Dropdown
            DropdownList.BackgroundColor3 = Color3.fromRGB(50, 55, 85)
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Visible = false

            local function updateDropdownList()
                local yPos = 0
                for _, option in ipairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
                    OptionButton.Position = UDim2.new(0, 0, 0, yPos)
                    OptionButton.Size = UDim2.new(1, 0, 0, 20)
                    OptionButton.Font = Enum.Font.SourceSans
                    OptionButton.Text = option
                    OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    OptionButton.TextSize = 18
                    OptionButton.BorderSizePixel = 0

                    OptionButton.MouseButton1Click:Connect(function()
                        DropdownButton.Text = option
                        DropdownList.Visible = false
                        callback(option)
                    end)

                    yPos = yPos + 20
                end
            end

            DropdownButton.MouseButton1Click:Connect(function()
                DropdownList.Visible = not DropdownList.Visible
                if not DropdownList.Visible then
                    DropdownList.Size = UDim2.new(1, 0, 0, 0)
                else
                    DropdownList.Size = UDim2.new(1, 0, 0, #options * 20)
                end
            end)

            updateDropdownList()
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    Library.NewTab = createTab
    Library.NewButton = createButton
    Library.NewToggle = createToggle
    Library.NewDropdown = createDropdown

    return Library
end

return Library
