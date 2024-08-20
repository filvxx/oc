--woz
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
    MainFrame.Draggable = false -- Initially set to false for manual handling

    local MainFrameCorner = Instance.new("UICorner")
    MainFrameCorner.CornerRadius = UDim.new(0, 12)
    MainFrameCorner.Parent = MainFrame

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

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, -250)   
    padding.PaddingRight = UDim.new(0, 0)
    padding.PaddingTop = UDim.new(0, 0)
    padding.PaddingBottom = UDim.new(0, 0)
    padding.Parent = TitleBar

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

    -- Dragging functionality
    local dragging = false
    local dragInput, startPos, startDragPos

    local function updateDrag(input)
        local delta = input.Position - dragInput.Position
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    local function onDragStart(input)
        dragging = true
        dragInput = input
        startPos = MainFrame.Position
        startDragPos = input.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    local function onDragEnd()
        dragging = false
    end

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            onDragStart(input)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateDrag(input)
        end
    end)

    TitleBar.InputEnded:Connect(function()
        onDragEnd()
    end)

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

-- Create the "-" button for collapsing and expanding the GUI
local CollapseButton = Instance.new("TextButton")
CollapseButton.Name = "CollapseButton"
CollapseButton.Parent = TitleBar
CollapseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red button for collapsing
CollapseButton.Position = UDim2.new(1, -50, 0, 5)  -- Position it to the right of the title bar
CollapseButton.Size = UDim2.new(0, 20, 0, 20)
CollapseButton.Font = Enum.Font.SourceSansBold
CollapseButton.Text = "-"
CollapseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollapseButton.TextSize = 18
CollapseButton.BorderSizePixel = 0
CollapseButton.ZIndex = 2

local isCollapsed = false

CollapseButton.MouseButton1Click:Connect(function()
    if isCollapsed then
        -- Expand the GUI
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        TabsFrame.Visible = true
        ContentsFrame.Visible = true
        TitleBar.Visible = true
        CollapseButton.Text = "-"
    else
        -- Collapse the GUI
        MainFrame.Size = UDim2.new(0, 500, 0, 40)  -- Adjust the height to only show the title bar
        TabsFrame.Visible = false
        ContentsFrame.Visible = false
        TitleBar.Visible = true
        CollapseButton.Text = "+"
    end
    isCollapsed = not isCollapsed
end)


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

            -- Create the ImageLabel to act as the decal
            local Decal = Instance.new("ImageLabel")
            Decal.Size = UDim2.new(0, 30, 0, 30)
            Decal.Position = UDim2.new(0, 2, 0.4, -10)  -- Position the decal where needed
            Decal.BackgroundTransparency = 1  -- Make sure background is transparent
            Decal.Image = "rbxassetid://121362887907702"  -- Replace with a white image asset ID
            Decal.ImageColor3 = Color3.fromRGB(90, 100, 150)  -- Initial color (white)
            Decal.Parent = Button

            -- Set the desired color for the image
            local desiredColor = Color3.fromRGB(90, 100, 150)  -- The color you want to apply

            Button.MouseButton1Click:Connect(function()
                Decal.ImageColor3 = desiredColor  -- Apply the color
                callback()
            end)
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

            -- Create a dot frame on the left side
            local Dot = Instance.new("Frame")
            Dot.Size = UDim2.new(0, 20, 0, 20)
            Dot.Position = UDim2.new(0, 10, 0.5, -10)  -- Positioned on the left
            Dot.BackgroundColor3 = Color3.fromRGB(90, 100, 150)  -- Border color of the dot
            Dot.BackgroundTransparency = 0.5  -- Make the border semi-transparent
            Dot.Parent = Toggle

            local DotCorner = Instance.new("UICorner")
            DotCorner.CornerRadius = UDim.new(1, 0)  -- Fully rounded corners to make it a dot
            DotCorner.Parent = Dot

            -- Create an inner frame for the filled state
            local DotInner = Instance.new("Frame")
            DotInner.Size = UDim2.new(1, -4, 1, -4)  -- Slightly smaller than Dot to fit within
            DotInner.Position = UDim2.new(0, 2, 0, 2)  -- Centered within Dot
            DotInner.BackgroundColor3 = Color3.fromRGB(90, 100, 150)  -- Fill color when toggled
            DotInner.BackgroundTransparency = 1  -- Start as fully transparent
            DotInner.Parent = Dot

            local DotInnerCorner = Instance.new("UICorner")
            DotInnerCorner.CornerRadius = UDim.new(1, 0)  -- Fully rounded corners to make it a filled dot
            DotInnerCorner.Parent = DotInner

            local isToggled = false
            Toggle.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                DotInner.BackgroundTransparency = isToggled and 0 or 1  -- Show or hide the fill color based on toggle state
                callback(isToggled)
            end)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    local function createDropdown(tabName, dropdownName, options, callback)
        local tabContent = ContentsFrame:FindFirstChild(tabName .. "Content")
        if tabContent then
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = dropdownName .. "Button"
            DropdownButton.Parent = tabContent
            DropdownButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
            DropdownButton.Position = getNextPosition(tabContent)
            DropdownButton.Size = UDim2.new(1, -20, 0, 40)
            DropdownButton.Font = Enum.Font.SourceSans
            DropdownButton.Text = dropdownName  -- Keep the original dropdown name
            DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.TextSize = 18
            DropdownButton.BorderSizePixel = 0

            local DropdownButtonCorner = Instance.new("UICorner")
            DropdownButtonCorner.CornerRadius = UDim.new(0, 12)
            DropdownButtonCorner.Parent = DropdownButton

            -- Create the ImageLabel for the dropdown icon
            local Decal = Instance.new("ImageLabel")
            Decal.Size = UDim2.new(0, 55, 0, 55)  -- Adjust size as needed
            Decal.Position = UDim2.new(0, 47, 0.757, -10)  -- Adjust position to fit within the button
            Decal.BackgroundTransparency = 1  -- Ensure the background is transparent
            Decal.Image = "rbxassetid://86728155667911"  -- Replace with your decal ID
            Decal.ImageColor3 = Color3.fromRGB(90, 100, 150)  -- Set the image color if needed
            Decal.AnchorPoint = Vector2.new(1, 0.5)  -- Anchor to the right and center vertically
            Decal.Parent = DropdownButton

            local DropdownList = Instance.new("Frame")
            DropdownList.Name = dropdownName .. "List"
            DropdownList.Parent = DropdownButton
            DropdownList.BackgroundColor3 = Color3.fromRGB(41, 45, 70)
            DropdownList.Position = UDim2.new(0, 0, 1, 0)
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.ClipsDescendants = true
            DropdownList.Visible = false
            DropdownList.BorderSizePixel = 0

            local DropdownListCorner = Instance.new("UICorner")
            DropdownListCorner.CornerRadius = UDim.new(0, 12)
            DropdownListCorner.Parent = DropdownList

            local selectedOption

            local function createOption(optionName, index)
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = optionName .. "Option"
                OptionButton.Parent = DropdownList
                OptionButton.BackgroundColor3 = Color3.fromRGB(70, 75, 105)
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.Position = UDim2.new(0, 0, 0, (index - 1) * 30)
                OptionButton.Font = Enum.Font.SourceSans
                OptionButton.Text = optionName
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.TextSize = 18
                OptionButton.BorderSizePixel = 0

                local OptionButtonCorner = Instance.new("UICorner")
                OptionButtonCorner.CornerRadius = UDim.new(0, 12)
                OptionButtonCorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    if selectedOption then
                        selectedOption.BackgroundColor3 = Color3.fromRGB(70, 75, 105)  -- Reset the previous selected option's color
                    end
                    OptionButton.BackgroundColor3 = Color3.fromRGB(90, 180, 90)  -- Highlight the selected option
                    selectedOption = OptionButton

                    DropdownList:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true, function()
                        DropdownList.Visible = false
                        -- Animate the elements below the dropdown to move back up
                        for _, v in ipairs(tabContent:GetChildren()) do
                            if v:IsA("GuiObject") and v.Position.Y.Offset > DropdownButton.Position.Y.Offset then
                                v:TweenPosition(UDim2.new(v.Position.X.Scale, v.Position.X.Offset, v.Position.Y.Scale, v.Position.Y.Offset - #options * 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
                            end
                        end
                    end)
                    callback(optionName)
                end)
            end

            for index, option in ipairs(options) do
                createOption(option, index)
            end

            DropdownButton.MouseButton1Click:Connect(function()
                if DropdownList.Visible then
                    -- Collapse the dropdown and move the elements back up
                    DropdownList:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true, function()
                        DropdownList.Visible = false
                        for _, v in ipairs(tabContent:GetChildren()) do
                            if v:IsA("GuiObject") and v.Position.Y.Offset > DropdownButton.Position.Y.Offset then
                                v:TweenPosition(UDim2.new(v.Position.X.Scale, v.Position.X.Offset, v.Position.Y.Scale, v.Position.Y.Offset - #options * 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
                            end
                        end
                    end)
                else
                    -- Expand the dropdown and move the elements below it down
                    DropdownList.Visible = true
                    DropdownList:TweenSize(UDim2.new(1, 0, 0, #options * 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
                    for _, v in ipairs(tabContent:GetChildren()) do
                        if v:IsA("GuiObject") and v.Position.Y.Offset > DropdownButton.Position.Y.Offset then
                            v:TweenPosition(UDim2.new(v.Position.X.Scale, v.Position.X.Offset, v.Position.Y.Scale, v.Position.Y.Offset + #options * 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
                        end
                    end
                end
            end)
        else
            warn("Tab '" .. tabName .. "' not found.")
        end
    end

    return {
        NewTab = createTab,
        NewButton = createButton,
        NewToggle = createToggle,
        NewDropdown = createDropdown
    }
end

return Library
