require("zxcmodule")

local nullVec = Vector() * -1
local cones = {}
local besttar = false 
local me = LocalPlayer()

GAMEMODE["EntityFireBullets"] = function( self, p, data ) 
    local w = me:GetActiveWeapon()

    if not IsValid( w ) then return end 

    w = w:GetClass()
    local spread = data.Spread * -1
    
	if cones[ w ] == spread or spread == nullVec then return end

    cones[ w ] = spread;
end

hook.Add( "CreateMove", "sawooo", function( cmd )
    besttar = false 

    if input.IsKeyDown( KEY_T ) then
        local plys = player.GetAll()
        local bestdistance = math.huge 

        for i = 1, #plys do
            if plys[ i ] == me or not plys[ i ]:Alive() or plys[ i ]:IsDormant() then continue end 
            
            local tr = util.TraceLine( {
                start = me:EyePos(),
                endpos = plys[ i ]:GetPos() + plys[ i ]:OBBCenter(),
                filter = me,
                mask = MASK_SHOT,
            } )

            if tr.Entity != plys[ i ] then continue end

            if ( plys[ i ]:GetPos() ):DistToSqr( me:GetPos() ) < bestdistance then
                besttar = plys[ i ]
            end
        end
    end

    if not besttar then return end 

    if not me:Alive() or not IsValid( me ) then return end 

    local w = me:GetActiveWeapon() 

    if not IsValid( w ) then return end
    if not w.GetShootPosAndDir then return end 

    local enemyPos = besttar:GetPos() + besttar:OBBCenter()
    local eyePos = me:EyePos() 
    local shootpos, shootdir, dirangle = w:GetShootPosAndDir()

    local diff = dirangle - cmd:GetViewAngles()
    diff:Normalize()
    
    local ang = ( enemyPos - shootpos ):Angle() 
    ang:Normalize()

    //if cones[ w:GetClass() ] then
    //    local spreadDir = ded.PredictSpread( cmd, ang, cones[ w:GetClass() ] ) 
    //    ang = ang + spreadDir:Angle()
    //    ang:Normalize()
    //end

    ang = ang - diff
    ang:Normalize()

    ang.r = 0 

    cmd:SetViewAngles( ang )
end )
