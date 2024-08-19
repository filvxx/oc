local Library = {}

-- Image IDs (replace these with actual image asset IDs)
local buttonImageId = "rbxassetid://19004812116"  -- Replace with your button image ID
local dropdownImageId = "rbxassetid://19004936041"  -- Replace with your dropdown image ID
local toggleOnImageId = "rbxassetid://19004892360"  -- Replace with your green toggle image ID
local toggleOffImageId = "rbxassetid://19004898108"  -- Replace with your red toggle image ID

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

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 12)
        TabButtonCorner.Parent = TabButton

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Name = name .. "Content"
        ContentFrame.Parent = ContentsFrame
        ContentFrame.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
        ContentFrame.Position = UDim2.new(0, 0, 0, 0)
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.Visible = false
        ContentFrame.BorderSizePixel = 0

        local ContentFrameCorner = Instance.new("UICorner")
        ContentFrameCorner.CornerRadius = UDim.new(0, 12)
        ContentFrameCorner.Parent = ContentFrame

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

    -- Function to add an image next to the button
    local function addImage(parent, imageId)
        local Image = Instance.new("ImageLabel")
        Image.Parent = parent
        Image.Size = UDim2.new(0, 30, 0, 30)
        Image.Position = UDim2.new(0, -35, 0.5, -15)  -- Position it to the left of the element
        Image.Image = imageId
        Image.BackgroundTransparency = 1
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

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 12)
            ButtonCorner.Parent = Button

            -- Add image to the button
            addImage(Button, buttonImageId)

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

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 12)
            ToggleCorner.Parent = Toggle

            -- Create the image that represents the toggle state
            local ToggleImage = Instance.new("ImageLabel")
            ToggleImage.Parent = Toggle
            ToggleImage.Size = UDim2.new(0, 20, 0, 20)
            ToggleImage.Position = UDim2.new(1, -30, 0.5, -10) -- Adjust position to the right
            ToggleImage.Image = toggleOffImageId -- Default to off
            ToggleImage.BackgroundTransparency = 1

            local isOn = false
            Toggle.MouseButton1Click:Connect(function()
                isOn = not isOn
                ToggleImage.Image = isOn and toggleOnImageId or toggleOffImageId
                callback(isOn)
            end)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createDropdown(tabName, dropdownName, options, callback)
        local tabContent = ContentsFrame:FindFirstChild(tabName .. "Content")
        if tabContent then
            local Dropdown = Instance.new("TextButton")
            Dropdown.Name = dropdownName .. "Dropdown"
            Dropdown.Parent = tabContent
            Dropdown.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            Dropdown.Position = getNextPosition(tabContent)
            Dropdown.Size = UDim2.new(1, -20, 0, 40)
            Dropdown.Font = Enum.Font.SourceSans
            Dropdown.Text = dropdownName
            Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.TextSize = 18
            Dropdown.BorderSizePixel = 0

            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 12)
            DropdownCorner.Parent = Dropdown

            -- Add image to the dropdown
            addImage(Dropdown, dropdownImageId)

            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = dropdownName .. "DropdownFrame"
            DropdownFrame.Parent = Dropdown
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 65, 90)
            DropdownFrame.Position = UDim2.new(0, 0, 1, 0)
            DropdownFrame.Size = UDim2.new(1, 0, 0, #options * 40)
            DropdownFrame.Visible = false
            DropdownFrame.BorderSizePixel = 0

            local DropdownFrameCorner = Instance.new("UICorner")
            DropdownFrameCorner.CornerRadius = UDim.new(0, 12)
            DropdownFrameCorner.Parent = DropdownFrame

            for i, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = option .. "Option"
                OptionButton.Parent = DropdownFrame
                OptionButton.BackgroundColor3 = Color3.fromRGB(60, 65, 90)
                OptionButton.Size = UDim2.new(1, 0, 0, 40)
                OptionButton.Font = Enum.Font.SourceSans
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.TextSize = 18
                OptionButton.BorderSizePixel = 0

                local OptionButtonCorner = Instance.new("UICorner")
                OptionButtonCorner.CornerRadius = UDim.new(0, 12)
                OptionButtonCorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    Dropdown.Text = dropdownName .. ": " .. option
                    DropdownFrame.Visible = false
                    callback(option)
                end)
            end

            Dropdown.MouseButton1Click:Connect(function()
                DropdownFrame.Visible = not DropdownFrame.Visible
            end)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    return {
        createTab = createTab,
        createButton = createButton,
        createToggle = createToggle,
        createDropdown = createDropdown,
    }
end

return Library
