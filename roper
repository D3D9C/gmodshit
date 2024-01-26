
local DrawList = {
    { x = 1, y = 0, vec = { 255, 0, 0 } },
    { x = 2, y = 0, vec = { 255, 0, 0 } },
    { x = 3, y = 0, vec = { 255, 0, 0 } },
    { x = 4, y = 0, vec = { 255, 0, 0 } },

    { x = 4, y = 1, vec = { 255, 0, 0 } },
    { x = 4, y = 2, vec = { 255, 0, 0 } },
    { x = 4, y = 3, vec = { 255, 0, 0 } },
    { x = 4, y = 4, vec = { 255, 0, 0 } },

    { x = 5, y = 4, vec = { 255, 0, 0 } },
    { x = 6, y = 4, vec = { 255, 0, 0 } },
    { x = 7, y = 4, vec = { 255, 0, 0 } },
    { x = 8, y = 4, vec = { 255, 0, 0 } },

    { x = 8, y = 3, vec = { 255, 0, 0 } },
    { x = 8, y = 2, vec = { 255, 0, 0 } },
    { x = 8, y = 1, vec = { 255, 0, 0 } },
    { x = 8, y = 0, vec = { 255, 0, 0 } },

    { x = 4, y = 5, vec = { 255, 0, 0 } },
    { x = 4, y = 6, vec = { 255, 0, 0 } },
    { x = 4, y = 7, vec = { 255, 0, 0 } },
    { x = 4, y = 8, vec = { 255, 0, 0 } },

    { x = 5, y = 8, vec = { 255, 0, 0 } },
    { x = 6, y = 8, vec = { 255, 0, 0 } },
    { x = 7, y = 8, vec = { 255, 0, 0 } },
    { x = 8, y = 8, vec = { 255, 0, 0 } },

    { x = 1, y = 4, vec = { 255, 0, 0 } },
    { x = 2, y = 4, vec = { 255, 0, 0 } },
    { x = 3, y = 4, vec = { 255, 0, 0 } },
    { x = 4, y = 4, vec = { 255, 0, 0 } },

    { x = 1, y = 5, vec = { 255, 0, 0 } },
    { x = 1, y = 6, vec = { 255, 0, 0 } },
    { x = 1, y = 7, vec = { 255, 0, 0 } },
    { x = 1, y = 8, vec = { 255, 0, 0 } },
}


local Index = 1 
local Drawn = false 

local StartPos = Vector()
local Ang = Angle()

local function Draw( cmd )
    if cmd:CommandNumber() == 0 or cmd:CommandNumber() % 2 != 0 then return end 

    Ang:Normalize()

    if input.IsKeyDown( KEY_F ) then
        Index = 1
        StartPos = LocalPlayer():GetEyeTrace().HitPos
    end

    if Index > #DrawList or not input.IsKeyDown( KEY_N )  then return end 
    Ang = ( StartPos - LocalPlayer():EyePos() ):Angle() 

    if Drawn then
        Ang.y = Ang.y - DrawList[ Index ].x - 1
        Ang.p = Ang.p + DrawList[ Index ].y / 2

        cmd:SetViewAngles( Ang )
        cmd:AddKey( IN_ATTACK )

        Index = Index + 1
        Drawn = false 
    else
        RunConsoleCommand( "rope_color_r", DrawList[ Index ].vec[ 1 ]  )
        RunConsoleCommand( "rope_color_g", DrawList[ Index ].vec[ 2 ] )
        RunConsoleCommand( "rope_color_b", DrawList[ Index ].vec[ 3 ] )

        Ang.y = Ang.y - DrawList[ Index ].x 
        Ang.p = Ang.p + DrawList[ Index ].y / 2
        
        cmd:SetViewAngles( Ang )
        cmd:AddKey( IN_ATTACK )

        Drawn = true 
    end


end

hook.Add( "CreateMove", "RopeDraw", Draw )
