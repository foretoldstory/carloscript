local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local ClaroLib = {}
ClaroLib.__index = ClaroLib

local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = parent
    return corner
end

function ClaroLib.new(titleText)
    local self = setmetatable({}, ClaroLib)
    
    if CoreGui:FindFirstChild("ClaroMainUI") then 
        CoreGui.ClaroMainUI:Destroy() 
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ClaroMainUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 650, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
    MainFrame.Active = true
    MainFrame.Draggable = true
    AddCorner(MainFrame, 20)
    
    self.Gui = ScreenGui
    self.MainFrame = MainFrame
    return self
end

function ClaroLib:AddToggle(parent, text, yPos, initialValue, callback)
    local label = Instance.new("TextLabel", parent)
    label.Text = text
    label.Size = UDim2.new(0, 220, 0, 30)
    label.Position = UDim2.new(0, 15, 0, yPos)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(112, 169, 219)
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local state = initialValue or false
    local btn = Instance.new("TextButton", parent)
    btn.Text = state and "ON" or "OFF"
    btn.Size = UDim2.new(0, 60, 0, 26)
    btn.Position = UDim2.new(1, -95, 0, yPos + 2)
    btn.BackgroundColor3 = state and Color3.fromRGB(112, 169, 219) or Color3.fromRGB(235, 235, 235)
    btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 12
    AddCorner(btn, 6)

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(112, 169, 219) or Color3.fromRGB(235, 235, 235)
        btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        
        if callback then callback(state) end
    end)
    
    return btn
end

return ClaroLib
