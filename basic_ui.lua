local Mouse = { x = 0, y = 0 }

local function InRect( x, y, w, h )
    w = x + w 
    h = y + h 

    return ( Mouse.x >= x and Mouse.x <= w ) and ( Mouse.y >= y and Mouse.y <= h )
end

local Context = { x = 0, y = 0, w = 0, h = 0, InArea = false }

local UI = {}

UI.IsHoveringPanel = false
UI.IsHoveringSub = false

UI.Frames = {}

function UI.CreateFrame( OnRender, StartX, StartY, FrameWidth, FrameHeight, ShouldDraw, PeformOverlay )
    UI.Frames[ #UI.Frames + 1 ] = {
        RenderX = StartX,
        RenderY = StartY,
        RenderW = FrameWidth,
        RenderH = FrameHeight,

        RenderFunc = OnRender,
        PerformOverlay = PeformOverlay,
        ShouldDraw = ShouldDraw,

        LastInteract = 0,
        OldX = 0,
        OldY = 0,
    }
end

local function NormalSort( a, b )
    return a.LastInteract < b.LastInteract
end

local function ReversedSort( a, b )
    return a.LastInteract > b.LastInteract
end

local function DoDo()

end

local function OnRender( self ) 
    surface.SetDrawColor( 16, 16, 16 )
    surface.DrawRect( self.RenderX, self.RenderY, self.RenderW, self.RenderH )
    surface.SetDrawColor( 72, 72, 72 )
    surface.DrawOutlinedRect( self.RenderX, self.RenderY, self.RenderW, self.RenderH )
end 

UI.CreateFrame( OnRender, 15, 15, 100, 100, function() return true end, DoDo )
UI.CreateFrame( OnRender, 15, 130, 100, 100, function() return LocalPlayer():Alive() end, DoDo )

function UI.Render()
    local CurrentMouseX, CurrentMouseY = input.GetCursorPos()
    local Frame 

    table.sort( UI.Frames, NormalSort )

    for i = 1, #UI.Frames do
        if not UI.Frames[ i ].ShouldDraw() then continue end

        UI.Frames[ i ].RenderFunc( UI.Frames[ i ] )
    end

    table.sort( UI.Frames, ReversedSort )

    for i = 1, #UI.Frames do
        Frame = UI.Frames[ i ]

        if not Frame.ShouldDraw() then continue end

        if InRect( Frame.RenderX, Frame.RenderY , Frame.RenderW, Frame.RenderH ) then        
            if input.IsMouseDown( MOUSE_LEFT ) and not UI.IsHoveringPanel then
                Frame.RenderX = Frame.RenderX + ( CurrentMouseX - Mouse.x )
                Frame.RenderY = Frame.RenderY + ( CurrentMouseY - Mouse.y )
    
                Frame.LastInteract = CurTime()
            end

            Frame.PerformOverlay()
    
            UI.IsHoveringPanel = true
        end
    
        Frame.OldX = Frame.RenderX
        Frame.OldY = Frame.RenderY
    end

    UI.IsHoveringPanel = false

    Mouse.x, Mouse.y = CurrentMouseX, CurrentMouseY
end

hook.Add( "DrawOverlay", "RenderUI", UI.Render )
