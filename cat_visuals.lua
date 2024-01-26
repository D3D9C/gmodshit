require("zxcmodule")

local Cat                   = {}

local Ent                   = Entity 
local Vec                   = Vector 
local Ang                   = Angle 
local Col                   = Color 
local Ply                   = Player 
local Mat                   = Material 
local CreateMat             = CreateMaterial
local CurrentTime           = CurTime 
local RenderTime            = FrameTime
local GetConsoleVar         = GetConVar
local iPairs                = ipairs 
local Pairs                 = pairs 
local FirstTimePredicted    = IsFirstTimePredicted
local ValidCheck            = IsValid
local Interpolate           = Lerp 
local ToNumber              = tonumber 
local ToString              = tostring
local IsString              = isstring

local Bit                   = bit 
local Cam                   = cam 
local Engine                = engine 
local Ents                  = ents
local Util                  = util
local Hook                  = hook  
local InputLib              = input
local RenderLib             = render
local Math                  = math
local Steam                 = steamworks
local Surface               = surface 
local TeamLib               = team 

local Band                  = Bit.band 
local Bnot                  = Bit.bnot 
local Bor                   = Bit.bor 

local CamEnd2D              = Cam.End2D
local CamEnd3D              = Cam.End3D
local CamEnd3D2D            = Cam.End3D2D
local CamStart2D            = Cam.Start2D
local CamStart3D            = Cam.Start3D
local CamStart3D2D          = Cam.Start3D2D
local CamIgnoreZ            = Cam.IgnoreZ

local EngineTickCount       = Engine.TickCount

local EntsGetAll            = Ents.GetAll

local UtilTraceLine         = Util.TraceLine
local UtilTraceHull         = Util.TraceHull

local HookAdd               = Hook.Add
local HookRemove            = Hook.Remove

local InputIsKeyDown        = InputLib.IsKeyDown
local InputIsMouseDown      = InputLib.IsMouseDown
local InputWasKeyPressed    = InputLib.WasKeyPressed
local InputWasMousePressed  = InputLib.WasMousePressed

local MathAbs               = Math.abs 
local MathAcos              = Math.acos 
local MathApproach          = Math.Approach 
local MathAsin              = Math.asin
local MathAtan              = Math.atan
local MathAtan2             = Math.atan2 
local MathCeil              = Math.ceil
local MathClamp             = Math.Clamp 
local MathCos               = Math.cos 
local MathDeg               = Math.deg 
local MathFloor             = Math.floor  
local MathMax               = Math.max 
local MathMin               = Math.min 
local MathModF              = Math.modf 
local MathNormalizeAng      = Math.NormalizeAngle 
local MathRad               = Math.rad 
local MathRand              = Math.Rand 
local MathRandom            = Math.random 
local MathRandomSeed        = Math.randomseed 
local MathRound             = Math.Round 
local MathSin               = Math.sin 
local MathSqrt              = Math.sqrt 
local MathTan               = Math.tan

local SetAlphaMultiplier    = Surface.SetAlphaMultiplier
local SetTextDrawColor      = Surface.SetTextColor
local GetTextDrawSize       = Surface.GetTextSize
local DrawText              = Surface.DrawText
local SetTextPos            = Surface.SetTextPos
local SetTextFont           = Surface.SetFont
local DrawLine              = Surface.DrawLine
local SetDrawColor          = Surface.SetDrawColor
local DrawRect              = Surface.DrawRect
local SetDrawMaterial       = Surface.SetMaterial 
local TexturedRect          = Surface.DrawTexturedRect
local OutlinedRect          = Surface.DrawOutlinedRect

local MetaEntity            = FindMetaTable( "Entity" )
local MetaVector            = FindMetaTable( "Vector" )
local MetaPlayer            = FindMetaTable( "Player" )

local MetaOBBMins           = MetaEntity.OBBMins
local MetaOBBMaxs           = MetaEntity.OBBMaxs

local MetaToScreen          = MetaVector.ToScreen

local EngineActiveGamemode  = Engine.ActiveGamemode()
local EngineTickInterval    = Engine.TickInterval()
local EntLocalPlayer        = LocalPlayer()
local EntWorldSpawn         = Entity( 0 )
local ScreenWidth           = ScrW()
local ScreenHeight          = ScrH()
local ScreenCenterX         = MathFloor( ScreenWidth / 2 )
local ScreenCenterY         = MathFloor( ScreenHeight / 2 )

local TableEnts             = {}
local TablePlys             = {}
local TableHooks            = {}
local TraceStruct           = { filter = EntLocalPlayer, mask = MASK_SHOT }
local TraceResult           = {}

local function QuickBand( Bits, Mask ) 
    return Band( Bits, Mask ) == Mask  
end

local function TimeToTicks( Time )
	return MathFloor( 0.5 + Time / EngineTickInterval )
end

local function TicksToTime( Ticks )
    return EngineTickInterval * Ticks
end

local function RoundToTick( Time )
    return TicksToTime( TimeToTicks( Time ) )
end

local function AddHook( event, func )
    local UniqueIdentificator = Util.Base64Encode( event ) .. CurrentTime()

    TableHooks[ #TableHooks + 1 ] = { event, UniqueIdentificator }

    HookAdd( event, UniqueIdentificator, func )
end

local function IsKeyDown( Key )
    if Key >= 107 then
        return InputIsMouseDown( Key )
    end

    return InputIsKeyDown( Key )
end

local function WasKeyPressed( Key )
    if Key >= 107 then
        return InputWasMousePressed( Key )
    end

    return InputWasKeyPressed( Key )
end

// Cfg system 

Cat.Cfg = {}

Cat.Cfg.Vars.BoxEsp                 = true 
Cat.Cfg.Vars.BoxTeamColor           = true 
Cat.Cfg.Vars.BoxStyle               = 1
Cat.Cfg.Vars.BoxGradient            = false

Cat.Cfg.Vars.FilledBox              = false 
Cat.Cfg.Vars.FilledGradient         = false 

Cat.Cfg.Vars.NameEsp                = true 
Cat.Cfg.Vars.HighlightFriends       = true 
Cat.Cfg.Vars.SteamName              = false 
Cat.Cfg.Vars.NamePos                = 1

Cat.Cfg.Vars.AvatarImage            = true 

Cat.Cfg.Vars.UsergroupEsp           = true 
Cat.Cfg.Vars.HighlightAdmins        = false 
Cat.Cfg.Vars.UsergroupPos           = 1

Cat.Cfg.Vars.HealthEsp              = true 
Cat.Cfg.Vars.HealthBar              = true 
Cat.Cfg.Vars.HealthBarGradient      = true 
Cat.Cfg.Vars.HealthBarPos           = 4
Cat.Cfg.Vars.HealthPos              = 4 

Cat.Cfg.Vars.ArmorEsp               = true 
Cat.Cfg.Vars.ArmorBar               = true 
Cat.Cfg.Vars.ArmorBarGradient       = true 
Cat.Cfg.Vars.ArmorBarPos            = 4
Cat.Cfg.Vars.ArmorPos               = 4 

Cat.Cfg.Vars.WeaponEsp              = true 
Cat.Cfg.Vars.WeaponPrintName        = false 
Cat.Cfg.Vars.WeaponIcon             = false 
Cat.Cfg.Vars.WeaponReload           = true 
Cat.Cfg.Vars.ReloadingBar           = true 
Cat.Cfg.Vars.ReloadingGradient      = true 
Cat.Cfg.Vars.WeaponPos              = 2

Cat.Cfg.Vars.TeamEsp                = true 
Cat.Cfg.Vars.TeamPos                = 1

Cat.Cfg.Vars.MoneyEsp               = true 
Cat.Cfg.Vars.MoneyPos               = 1 

Cat.Cfg.Vars.LagcompIndicator       = true 
Cat.Cfg.Vars.PacketIndicator        = true 
Cat.Cfg.Vars.PacketPos              = 3

Cat.Cfg.Vars.TauntFlag              = false 
Cat.Cfg.Vars.NoclipFlag             = true 
Cat.Cfg.Vars.FrozenFlag             = true 
Cat.Cfg.Vars.WantedFlag             = true 
Cat.Cfg.Vars.FlagsPos               = 1

Cat.Cfg.Vars.SkeletonEsp            = true 

Cat.Cfg.Vars.SightLines             = true 

Cat.Cfg.Vars.MaxDistance            = 14888888 
Cat.Cfg.Vars.MainFont               = 1

Cat.Cfg.Vars.EntityBox              = false 
Cat.Cfg.Vars.EntityBoxStyle         = false 

Cat.Cfg.Vars.EntityName             = false 
Cat.Cfg.Vars.EntityClass            = false 
Cat.Cfg.Vars.EntityAddInfo          = false 

Cat.Cfg.Vars.EntityMaxDistance      = 2046

Cat.Cfg.Binds   = {}

Cat.Cfg.Colors  = {}

Cat.Cfg.Colors.Box                  = Col( 0, 255, 255 )
Cat.Cfg.Colors.BoxBg                = Col( 0, 0, 0 )
Cat.Cfg.Colors.BoxGr                = Col( 255, 0, 255 )
Cat.Cfg.Colors.BoxFill              = Col( 0, 255, 255, 32 )
Cat.Cfg.Colors.PlayerName           = Col( 255, 255, 255 )
Cat.Cfg.Colors.FriendName           = Col( 0, 255, 0 )
Cat.Cfg.Colors.Usergroup            = Col( 128, 255, 0 )
Cat.Cfg.Colors.AdminHighlight       = Col( 255, 0, 0 )
Cat.Cfg.Colors.Health               = Col( 56, 255, 0 )
Cat.Cfg.Colors.Armor                = Col( 0, 56, 255 )
Cat.Cfg.Colors.Weapon               = Col( 255, 255, 128 )               
Cat.Cfg.Colors.BrokenLC             = Col( 255, 16, 16 )  
Cat.Cfg.Colors.PacketSent           = Col( 173, 255, 47 )  
Cat.Cfg.Colors.Skeleton             = Col( 255, 255, 255 )
Cat.Cfg.Colors.HealthBarBg          = Col( 0, 0, 0 )
Cat.Cfg.Colors.HealthBar            = Col( 72, 255, 72 )
Cat.Cfg.Colors.HealthBarGr          = Col( 255, 72, 72 )
Cat.Cfg.Colors.ArmorBarBg           = Col( 0, 0, 0 )
Cat.Cfg.Colors.ArmorBar             = Col( 72, 72, 255 )
Cat.Cfg.Colors.ArmorBarGr           = Col( 72, 255, 72 )
Cat.Cfg.Colors.ReloadingBarBg       = Col( 0, 0, 0 )
Cat.Cfg.Colors.ReloadingBar         = Col( 255, 128, 72 )
Cat.Cfg.Colors.ReloadingBarGr       = Col( 255, 72, 128 )

Cat.Cfg.Friends = {}
Cat.Cfg.EntList = {}

// Cache 

Cat.FrameTime       = 0
Cat.CurrentTime     = 0

Cat.Colors  = {}

Cat.Colors.White    = Col( 255, 255, 255 )
Cat.Colors.Money    = Col( 133, 187, 101 ) // https://rgbcolorcode.com/color/dollar-bill
Cat.Colors.Ice      = Col( 115, 155, 208 )
Cat.Colors.Arrest   = Col( 255, 0, 51 )

Cat.Materials   = {}

Cat.Materials.GradientV = Mat( "gui/gradient_up" )
Cat.Materials.GradientH = Mat( "gui/gradient" )

// Player data caching 

Cat.InitiallyCached = {}
Cat.Recachable      = {}

Cat.LastRecache     = CurrentTime()

function Cat.CachePlayerData( Ply )   
    Cat.InitiallyCached[ Ply ] = {} 

    Cat.InitiallyCached[ Ply ].SteamID      = Ply:SteamID()
    Cat.InitiallyCached[ Ply ].SteamID64    = Ply:SteamID64()
    Cat.InitiallyCached[ Ply ].EntIndex     = Ply:EntIndex()
    Cat.InitiallyCached[ Ply ].UserID       = Ply:UserID()
    Cat.InitiallyCached[ Ply ].IsBot        = Ply:IsBot()

    Cat.InitiallyCached[ Ply ].AvatarImage  = vgui.Create( "AvatarImage" )
    Cat.InitiallyCached[ Ply ].AvatarImage:SetSize( 12, 12 )
	Cat.InitiallyCached[ Ply ].AvatarImage:SetPlayer( Ply, 32 )
    Cat.InitiallyCached[ Ply ].AvatarImage:SetPaintedManually( true )

    if Ply:IsBot() then
        Cat.InitiallyCached[ Ply ].RealName = Ply:Name()
    else
        Steam.RequestPlayerInfo( Cat.InitiallyCached[ Ply ].SteamID64, function( steamName )
            Cat.InitiallyCached[ Ply ].RealName = steamName
        end )
    end
end

function Cat.UpdatePlayerVars( Ply )
    TablePlys[ #TablePlys ].Ent         = Ply 

    TablePlys[ #TablePlys ].Health      = Ply:Health()
    TablePlys[ #TablePlys ].Armor       = Ply:Armor()
    TablePlys[ #TablePlys ].MaxHealth   = Ply:GetMaxHealth()
    TablePlys[ #TablePlys ].MaxArmor    = Ply:GetMaxArmor()

    TablePlys[ #TablePlys ].Origin      = Ply:GetPos()
    TablePlys[ #TablePlys ].NetOrigin   = Ply:GetNetworkOrigin()

    TablePlys[ #TablePlys ].OBBCenter   = Ply:OBBCenter()
    TablePlys[ #TablePlys ].OBBMaxs     = Ply:OBBMaxs()
    TablePlys[ #TablePlys ].OBBMins     = Ply:OBBMins()

    TablePlys[ #TablePlys ].Angle       = Ply:GetAngles()
    TablePlys[ #TablePlys ].EyeAngles   = Ply:EyeAngles()
    TablePlys[ #TablePlys ].NetAngles   = Ply:GetNetworkAngles()

    TablePlys[ #TablePlys ].Flags       = Ply:GetFlags()
    TablePlys[ #TablePlys ].EngineFlags = Ply:GetEFlags()
    TablePlys[ #TablePlys ].Effects     = Ply:GetEffects()
    TablePlys[ #TablePlys ].MoveType    = Ply:GetMoveType()

    TablePlys[ #TablePlys ].Alive       = Ply:Alive()
    TablePlys[ #TablePlys ].IsDormant   = Ply:IsDormant()

    TablePlys[ #TablePlys ].SimTime     = ded.GetSimulationTime( Cat.InitiallyCached[ Ply ].EntIndex )
    
    Ply.StartedReloading = Ply.StartedReloading or 0
    Ply.PrevSimTime = Ply.PrevSimTime or 0
    Ply.Choked = Ply.Choked or 0
    Ply.BreakingLC = Ply.BreakingLC or false
    Ply.PrevOrigin  = Ply.PrevOrigin or TablePlys[ #TablePlys ].NetOrigin
    
    TablePlys[ #TablePlys ].PacketSent  = false 
    TablePlys[ #TablePlys ].BreakingLC  = false

    if Ply.PrevSimTime != TablePlys[ #TablePlys ].SimTime then
        Ply.BreakingLC = Ply.PrevOrigin:DistToSqr( TablePlys[ #TablePlys ].NetOrigin ) > 4096

        TablePlys[ #TablePlys ].PacketSent = true

        Ply.Choked = TimeToTicks( TablePlys[ #TablePlys ].SimTime - Ply.PrevSimTime )
        Ply.PrevOrigin  = TablePlys[ #TablePlys ].NetOrigin
        Ply.PrevSimTime = TablePlys[ #TablePlys ].SimTime
    end
    
    TablePlys[ #TablePlys ].BreakingLC = Ply.BreakingLC 
    TablePlys[ #TablePlys ].ChokedPackets = Ply.Choked

    local w = Ply:GetActiveWeapon()

    TablePlys[ #TablePlys ].Weapon      = ValidCheck( w ) and w or false 
    TablePlys[ #TablePlys ].WeaponClass = TablePlys[ #TablePlys ].Weapon and w:GetClass() or "Unarmed"
    TablePlys[ #TablePlys ].WeaponName  = TablePlys[ #TablePlys ].Weapon and language.GetPhrase( w:GetPrintName() ) or "Unarmed"
end

function Cat.RecachePlayerData( Ply )
    if not Cat.Recachable[ Ply ] then
        Cat.Recachable[ Ply ] = {} 
    end

    Cat.Recachable[ Ply ].Team        = Ply:Team()
    Cat.Recachable[ Ply ].TeamColor   = TeamLib.GetColor( Cat.Recachable[ Ply ].Team )
    Cat.Recachable[ Ply ].TeamName    = TeamLib.GetName( Cat.Recachable[ Ply ].Team )

    if MetaPlayer.getDarkRPVar then
        Cat.Recachable[ Ply ].Money   = DarkRP.formatMoney( Ply:getDarkRPVar("money") ) or "beggar"
        Cat.Recachable[ Ply ].Wanted  = Ply:getDarkRPVar("wanted")
    end

    Cat.Recachable[ Ply ].Name        = Ply:Name()
    Cat.Recachable[ Ply ].UserGroup   = Ply:GetNWString( "UserGroup", "user" )
    Cat.Recachable[ Ply ].SteamFriend = Ply:GetFriendStatus() == "friend" 
    Cat.Recachable[ Ply ].IsAdmin     = Ply:IsAdmin()

    Cat.Recachable[ Ply ].Model       = Ply:GetModel()

    Cat.Recachable[ Ply ].DormantFade = 0
end

// 2D Visuals
Surface.CreateFont( "Veranda", { font = "Verdana", size = 12, antialias = false, outline = true } )

Cat.DrawData        = {}

Cat.DrawData.Vis    = false

Cat.DrawData.MaxX   = 0 
Cat.DrawData.MaxY   = 0 
Cat.DrawData.MinX   = 0 
Cat.DrawData.MinY   = 0 
Cat.DrawData.Width  = 0 
Cat.DrawData.Height = 0
Cat.DrawData.TextX  = 0
Cat.DrawData.TextY  = 0

Cat.DrawData.DrawnText  = {}
Cat.DrawData.StartPoses = {}

Cat.DrawData.BarPoses   = {}
Cat.DrawData.BarPadding = {}

Cat.CachedTextSize  = {}

Cat.BarPadding = { { x = 0, y = -5 }, { x = 0, y = 5 }, { x = 5, y = 0 }, { x = -5, y = 0 } }

function Cat.GetEntityBounds( Ent )
    local Pos   = Ent:GetPos()

    local Maxs  = MetaOBBMaxs( Ent )
    local Mins  = MetaOBBMins( Ent )

    local Bounds = {
        MetaToScreen( Pos + Vec( Maxs.x, Maxs.y, Maxs.z ) ),
        MetaToScreen( Pos + Vec( Maxs.x, Maxs.y, Mins.z ) ),
        MetaToScreen( Pos + Vec( Maxs.x, Mins.y, Mins.z ) ),
        MetaToScreen( Pos + Vec( Maxs.x, Mins.y, Maxs.z ) ),
        MetaToScreen( Pos + Vec( Mins.x, Mins.y, Mins.z ) ),
        MetaToScreen( Pos + Vec( Mins.x, Mins.y, Maxs.z ) ),
        MetaToScreen( Pos + Vec( Mins.x, Maxs.y, Mins.z ) ),
        MetaToScreen( Pos + Vec( Mins.x, Maxs.y, Maxs.z ) ),
    }

    local MaxX, MaxY, MinX, MinY 
    local Vis = false 

    for i = 1, #Bounds do
        local ScreenPoint = Bounds[ i ]
        Vis = ScreenPoint.visible

        if MaxX == nil then
            MaxX = ScreenPoint.x 
            MaxY = ScreenPoint.y
            MinX = ScreenPoint.x
            MinY = ScreenPoint.y

            continue 
        end

        MaxX = MathMax( MaxX, ScreenPoint.x ) 
        MaxY = MathMax( MaxY, ScreenPoint.y ) 
        MinX = MathMin( MinX, ScreenPoint.x )
        MinY = MathMin( MinY, ScreenPoint.y )
    end

    return MathCeil( MaxX ), MathCeil( MaxY ), MathFloor( MinX ), MathFloor( MinY ), Vis
end

function Cat.GetTextX( TextWidth, Pos )
    if Pos < 3 then
        return TextWidth / 2 
    elseif Pos == 4 then 
        return TextWidth - Cat.DrawData.BarPadding[ Pos ].x 
    end

    return Cat.DrawData.BarPadding[ Pos ].x 
end

function Cat.GetTextY( TextHeight, Pos )
    if Pos == 1 then
        return Cat.DrawData.MinY + Cat.DrawData.BarPadding[ Pos ].y - TextHeight - 2 - TextHeight * Cat.DrawData.DrawnText[ Pos ]
    elseif Pos == 2 then
        return Cat.DrawData.MaxY + Cat.DrawData.BarPadding[ Pos ].y + TextHeight * Cat.DrawData.DrawnText[ Pos ] 
    end

    return Cat.DrawData.MinY + TextHeight * Cat.DrawData.DrawnText[ Pos ]
end

function Cat.GetTextSize( String )
    if Cat.CachedTextSize[ String ] then
        return Cat.CachedTextSize[ String ].x, Cat.CachedTextSize[ String ].y
    end

    local TextW, TextH = GetTextDrawSize( String )
    Cat.CachedTextSize[ String ] = {
        x = TextW,
        y = TextH - 2
    }

    return Cat.CachedTextSize[ String ].x, Cat.CachedTextSize[ String ].y
end

function Cat.DrawEspText( String, Pos )
    if not IsString( String ) then String = ToString( String ) end
    local TextWidth, TextHeight = Cat.GetTextSize( String )

    Cat.DrawData.TextX = Cat.DrawData.StartPoses[ Pos ] - Cat.GetTextX( TextWidth, Pos )
    Cat.DrawData.TextY = Cat.GetTextY( TextHeight, Pos )

    SetTextPos( Cat.DrawData.TextX, Cat.DrawData.TextY )
    DrawText( String )

    Cat.DrawData.DrawnText[ Pos ] = Cat.DrawData.DrawnText[ Pos ] + 1
end

function Cat.EspText( Conditions, Text, TextPos, TextColor )
    if not Conditions then return end 
        
    SetTextDrawColor( TextColor )  
    Cat.DrawEspText( Text, TextPos )
end

function Cat.DrawBar( Pos, Current, Max, BarColor, BackColor, Gradient, GradientColor )
    local BarX, BarY = Cat.DrawData.BarPoses[ Pos ].x + Cat.DrawData.BarPadding[ Pos ].x, Cat.DrawData.BarPoses[ Pos ].y + Cat.DrawData.BarPadding[ Pos ].y
    local BarW, BarH = Cat.DrawData.Width, 4
    local FillW, FillH = MathCeil( Current / Max * BarW ), BarH

    if Pos > 2 then
        BarW, BarH = 4, Cat.DrawData.Height 
        FillW, FillH = BarW, MathCeil( Current / Max * BarH )
    end

    SetDrawColor( BackColor )
    DrawRect( BarX, BarY, BarW, BarH )

    BarX, BarY = BarX + 1, BarY + 1

    if Pos > 2 then
        BarY = BarY + BarH - FillH
    end

    BarW, BarH = BarW - 2, BarH - 2
    FillW, FillH = FillW - 2, FillH - 2
    
    SetDrawColor( BarColor )
    DrawRect( BarX, BarY, FillW, FillH )

    if Gradient then
        SetDrawColor( GradientColor )
        SetDrawMaterial( Pos > 2 and Cat.Materials.GradientV or Cat.Materials.GradientH )
        TexturedRect( BarX, BarY, FillW, FillH )
    end

    Cat.DrawData.BarPadding[ Pos ].x = Cat.DrawData.BarPadding[ Pos ].x + Cat.BarPadding[ Pos ].x 
    Cat.DrawData.BarPadding[ Pos ].y = Cat.DrawData.BarPadding[ Pos ].y + Cat.BarPadding[ Pos ].y
end

function Cat.DrawPlayerVisuals()
    if #TablePlys == 0 then return end 

    local MaxPlayerDistance = Cat.Cfg.Vars.MaxDistance
    local MaxEntityDistance = Cat.Cfg.Vars.EntityMaxDistance

    MaxPlayerDistance = MaxPlayerDistance * MaxPlayerDistance
    MaxEntityDistance = MaxEntityDistance * MaxEntityDistance

    local LocalPlayerPos = TablePlys[ 1 ].Origin

    local CachedVars, UpdatedVars, Recaching 

    SetTextFont( "Veranda" )

    local BarPos 
    local BarX, BarY
    local BarW, BarH 
    local FillW, FillH 
    local SequenceID = 1
    local Reloading = false

    for i = 2, #TablePlys do
        UpdatedVars = TablePlys[ i ]
        CachedVars  = Cat.InitiallyCached[ UpdatedVars.Ent ]
        Recaching   = Cat.Recachable[ UpdatedVars.Ent ]

        SetAlphaMultiplier( UpdatedVars.IsDormant and 0.35 or 1 )

        if not UpdatedVars.Alive then continue end

        Cat.DrawData.MaxX, Cat.DrawData.MaxY, Cat.DrawData.MinX, Cat.DrawData.MinY, Cat.DrawData.Vis = Cat.GetEntityBounds( UpdatedVars.Ent )

        if not Cat.DrawData.Vis then continue end
        if LocalPlayerPos:DistToSqr( UpdatedVars.Origin ) > MaxPlayerDistance then continue end

        Cat.DrawData.Width  = MathFloor( Cat.DrawData.MaxX - Cat.DrawData.MinX )
        Cat.DrawData.Height = MathFloor( Cat.DrawData.MaxY - Cat.DrawData.MinY )
        
        Cat.DrawData.DrawnText  = { 0, 0, 0, 0 }
        Cat.DrawData.BarPadding = { { x = 0, y = 0 }, { x = 0, y = 0 }, { x = 0, y = 0 }, { x = 0, y = 0 } }

        Cat.DrawData.StartPoses = { 
            Cat.DrawData.MinX + Cat.DrawData.Width / 2, 
            Cat.DrawData.MinX + Cat.DrawData.Width / 2, 
            Cat.DrawData.MaxX + 5, 
            Cat.DrawData.MinX - 5 
        }

        Cat.DrawData.BarPoses = {
            { x = Cat.DrawData.MinX, y = Cat.DrawData.MinY - 6 },
            { x = Cat.DrawData.MinX, y = Cat.DrawData.MaxY + 1 }, 
            { x = Cat.DrawData.MaxX + 1, y = Cat.DrawData.MinY }, 
            { x = Cat.DrawData.MinX - 6, y = Cat.DrawData.MinY }
        }

        if Cat.Cfg.Vars.SightLines then 
            local EyeTrace = UpdatedVars.Ent:GetEyeTrace()
            local StartPos, HitPos = EyeTrace.StartPos:ToScreen(), EyeTrace.HitPos:ToScreen()

            SetDrawColor( Recaching.TeamColor )
            DrawLine( StartPos.x, StartPos.y, HitPos.x, HitPos.y )
        end
           
        if Cat.Cfg.Vars.SkeletonEsp then
            SetDrawColor( Cat.Cfg.Colors.Skeleton )

		    for BoneId = 0, UpdatedVars.Ent:GetBoneCount() - 1 do
			    local Parent = UpdatedVars.Ent:GetBoneParent( BoneId )
			    if not Parent then continue end

			    local ChildPos = UpdatedVars.Ent:GetBonePosition( BoneId )
			    if ChildPos == UpdatedVars.Ent:GetPos() then continue end

			    local ParentPos = UpdatedVars.Ent:GetBonePosition( Parent )
			    if not ChildPos or not ParentPos then continue end

			    local ChildScreenPos    = MetaToScreen( ChildPos )
                local ParentScreenPos   = MetaToScreen( ParentPos )

			    DrawLine( ChildScreenPos.x, ChildScreenPos.y, ParentScreenPos.x, ParentScreenPos.y )
		    end
        end

        SetDrawMaterial( Cat.Materials.GradientV )

        if Cat.Cfg.Vars.FilledBox then
            SetDrawColor( Cat.Cfg.Colors.BoxFill )  

            if Cat.Cfg.Vars.FilledGradient then
                TexturedRect( Cat.DrawData.MinX, Cat.DrawData.MinY, Cat.DrawData.Width, Cat.DrawData.Height )
            else
                DrawRect( Cat.DrawData.MinX, Cat.DrawData.MaxY, Cat.DrawData.Width, Cat.DrawData.Height )
            end
        end

        if Cat.Cfg.Vars.BoxEsp then 
            SetDrawColor( Cat.Cfg.Colors.BoxBg )
            OutlinedRect( Cat.DrawData.MinX, Cat.DrawData.MinY, Cat.DrawData.Width, Cat.DrawData.Height, 3 )
        
            SetDrawColor( Cat.Cfg.Vars.BoxTeamColor and Recaching.TeamColor or Cat.Cfg.Colors.Box )
            OutlinedRect( Cat.DrawData.MinX + 1, Cat.DrawData.MinY + 1, Cat.DrawData.Width - 2, Cat.DrawData.Height - 2 )
        
            if Cat.Cfg.Vars.BoxGradient then
                SetDrawColor( Cat.Cfg.Colors.BoxGr ) 

                TexturedRect( Cat.DrawData.MinX + 1, Cat.DrawData.MinY, 1, Cat.DrawData.Height - 1 )
                TexturedRect( Cat.DrawData.MaxX - 2, Cat.DrawData.MinY, 1, Cat.DrawData.Height - 1 )
                DrawRect( Cat.DrawData.MinX + 1, Cat.DrawData.MaxY - 2, Cat.DrawData.Width - 2, 1 )
            end
        end 

        if Cat.Cfg.Vars.HealthBar then
            Cat.DrawBar( Cat.Cfg.Vars.HealthBarPos, UpdatedVars.Health, UpdatedVars.MaxHealth, Cat.Cfg.Colors.HealthBar, Cat.Cfg.Colors.HealthBarBg, Cat.Cfg.Vars.HealthBarGradient, Cat.Cfg.Colors.HealthBarGr )
        end

        if Cat.Cfg.Vars.ArmorBar and UpdatedVars.Armor > 0 then
            Cat.DrawBar( Cat.Cfg.Vars.ArmorBarPos, UpdatedVars.Armor, UpdatedVars.MaxArmor, Cat.Cfg.Colors.ArmorBar, Cat.Cfg.Colors.ArmorBarBg, Cat.Cfg.Vars.ArmorBarGradient, Cat.Cfg.Colors.ArmorBarGr )
        end

        if Cat.Cfg.Vars.WeaponReload then
            for Layer = 0, 13 do
                if not UpdatedVars.Ent:IsValidLayer( Layer ) then continue end 
                SequenceID = UpdatedVars.Ent:GetLayerSequence( Layer ) 
                if not UpdatedVars.Ent:GetSequenceActivityName( SequenceID ):find( "RELOAD" ) then continue end 
                      
                if UpdatedVars.Ent.StartedReloading == 0 then
                    UpdatedVars.Ent.StartedReloading = Cat.CurrentTime
                end

                Reloading = true 
                break
            end

            if not Reloading and UpdatedVars.Ent.StartedReloading > 0 then
                UpdatedVars.Ent.StartedReloading = 0
            end
        end
        
        if UpdatedVars.Ent.StartedReloading > 0 and Cat.Cfg.Vars.ReloadingBar then
            Cat.DrawBar( 2, ( Cat.CurrentTime - UpdatedVars.Ent.StartedReloading ), UpdatedVars.Ent:SequenceDuration( SequenceID ), Cat.Cfg.Colors.ReloadingBar, Cat.Cfg.Colors.ReloadingBarBg, Cat.Cfg.Vars.ReloadingGradient, Cat.Cfg.Colors.ReloadingBarGr )
        end 

        SetTextDrawColor( Cat.Colors.White )
           
        Cat.EspText( Cat.Cfg.Vars.NameEsp, Cat.Cfg.Vars.SteamName and CachedVars.RealName or Recaching.Name, Cat.Cfg.Vars.NamePos, Recaching.SteamFriend and Cat.Cfg.Colors.FriendName or Cat.Cfg.Colors.PlayerName )

        if Cat.Cfg.Vars.AvatarImage then
            CachedVars.AvatarImage:SetPos( Cat.DrawData.TextX - 14, Cat.DrawData.TextY + 1 )
            CachedVars.AvatarImage:PaintManual()
        end
   
        Cat.EspText( Cat.Cfg.Vars.UsergroupEsp, Recaching.UserGroup, Cat.Cfg.Vars.UsergroupPos, ( Recaching.IsAdmin and Cat.Cfg.Vars.HighlightAdmins ) and Cat.Cfg.Colors.AdminHighlight or Cat.Cfg.Colors.Usergroup )
        Cat.EspText( Cat.Cfg.Vars.HealthEsp, UpdatedVars.Health, Cat.Cfg.Vars.HealthPos, Cat.Cfg.Colors.Health )
        Cat.EspText( Cat.Cfg.Vars.ArmorEsp, UpdatedVars.Armor, Cat.Cfg.Vars.ArmorPos, Cat.Cfg.Colors.Armor )
        Cat.EspText( Cat.Cfg.Vars.WeaponEsp, Cat.Cfg.Vars.WeaponPrintName and UpdatedVars.WeaponName or UpdatedVars.WeaponClass, Cat.Cfg.Vars.WeaponPos, Cat.Cfg.Colors.Weapon )
        Cat.EspText( Reloading, "RELOADING!", Cat.Cfg.Vars.WeaponPos, Cat.Cfg.Colors.Weapon )
        Cat.EspText( Cat.Cfg.Vars.TeamEsp, Recaching.TeamName, Cat.Cfg.Vars.TeamPos, Recaching.TeamColor )
        Cat.EspText( Cat.Cfg.Vars.MoneyEsp and Recaching.Money, Recaching.Money, Cat.Cfg.Vars.MoneyPos, Cat.Colors.Money )
        Cat.EspText( Cat.Cfg.Vars.LagcompIndicator, "LAGCOMP", Cat.Cfg.Vars.PacketPos, UpdatedVars.BreakingLC and Cat.Cfg.Colors.BrokenLC or Cat.Cfg.Colors.PacketSent )
        Cat.EspText( Cat.Cfg.Vars.PacketIndicator, UpdatedVars.PacketSent and "Packet sent" or "Laggin " .. UpdatedVars.ChokedPackets, Cat.Cfg.Vars.PacketPos, UpdatedVars.PacketSent and Cat.Cfg.Colors.PacketSent or Cat.Cfg.Colors.BrokenLC )
        Cat.EspText( Cat.Cfg.Vars.TauntFlag and UpdatedVars.Ent:IsPlayingTaunt(), "Taunting", Cat.Cfg.Vars.FlagsPos, Cat.Colors.White )
        Cat.EspText( Cat.Cfg.Vars.NoclipFlag and UpdatedVars.MoveType == MOVETYPE_NOCLIP, "NOCLIP", Cat.Cfg.Vars.FlagsPos, Cat.Colors.White )
        Cat.EspText( Cat.Cfg.Vars.FrozenFlag and QuickBand( UpdatedVars.Flags, FL_FROZEN ), "FROZEN", Cat.Cfg.Vars.FlagsPos, Cat.Colors.Ice )
        Cat.EspText( Cat.Cfg.Vars.WantedFlag and Recaching.Wanted, "WANTED", Cat.Cfg.Vars.FlagsPos, Cat.Colors.Arrest )
    end

    CachedVars, UpdatedVars, Recaching = nil, nil, nil 

    SetAlphaMultiplier( 1 )
end

function Cat.CreateMoveHook( cmd )

end

// Think 

function Cat.ThinkHook()
    Cat.CurrentTime = CurrentTime()
    Cat.FrameTime = RenderTime()

end

// Frame stage hook 
ded.SetInterpolation( false )
ded.SetSequenceInterpolation( false )

Cat.FrameStages = {}

Cat.FrameStages[ 3 ] = function()
    local Entities = EntsGetAll()
    local CT = CurrentTime()
    local Ent 
    
    for i = 1, #TablePlys do TablePlys[ i ] = nil end
    for i = 1, #TableEnts do TableEnts[ i ] = nil end

    TablePlys[ 1 ] = {}

    if not Cat.InitiallyCached[ EntLocalPlayer ] then
        Cat.CachePlayerData( EntLocalPlayer )
        Cat.RecachePlayerData( EntLocalPlayer ) 
    end
    
    Cat.UpdatePlayerVars( EntLocalPlayer )

    if CT - Cat.LastRecache > 1 then 
        Cat.RecachePlayerData( EntLocalPlayer ) 
    end

    for i = 2, #Entities do
        Ent = Entities[ i ]
        TableEnts[ #TableEnts + 1 ] = Ent

        if not Ent:IsPlayer() or Ent == EntLocalPlayer then continue end 

        TablePlys[ #TablePlys + 1 ] = {}
        if not Cat.InitiallyCached[ Ent ] then 
            Cat.CachePlayerData( Ent ) 
            Cat.RecachePlayerData( Ent )
        end

        Cat.UpdatePlayerVars( Ent )

        if CT - Cat.LastRecache > 1 then
            Cat.RecachePlayerData( Ent )
        end
    end

    if CT - Cat.LastRecache > 1 then 
        Cat.LastRecache = CT + 1
    end

    Entities = nil 
end

function Cat.FrameStageHook( stage )
    if Cat.FrameStages[ stage ] then
        Cat.FrameStages[ stage ]()
    end
end

HookAdd( "PostFrameStageNotify", "Cat", Cat.FrameStageHook )
HookAdd( "HUDPaint", "Cat", Cat.DrawPlayerVisuals )
HookAdd( "Think", "Cat", Cat.ThinkHook )
HookAdd( "CreateMove", "Cat", Cat.CreateMoveHook )
