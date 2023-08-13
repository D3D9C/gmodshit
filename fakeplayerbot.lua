// shared autorun
local PLAYER    = FindMetaTable( "Player" )
local original  = {}

original.SteamID    = PLAYER.SteamID
original.SteamID64  = PLAYER.SteamID64
original.GetName    = PLAYER.GetName
original.Name       = PLAYER.Name
original.Nick       = PLAYER.Nick
original.IsBot      = PLAYER.IsBot

original.ShowProfile    = PLAYER.ShowProfile

// Add more
local info = {
    { steamid = "STEAM_1:1:554665853", steamid64 = "76561199069597435", steamname = "Tayogos"   },
    { steamid = "STEAM_1:1:709682757", steamid64 = "76561199379631243", steamname = "T4"        }, 
    { steamid = "STEAM_0:0:475054153", steamid64 = "76561198910374034", steamname = "Wigy"      },
}

if SERVER then
    local function OnSpawn( ply, trans )
        if not original.IsBot( ply ) then return end 
            
        ply:SetNWInt( "_fi", math.random( 1, #info ) )
    end

    hook.Add( "PlayerInitialSpawn", "_fi_pis", OnSpawn )
end 

if CLIENT then
    function PLAYER:IsBot()
        if original.IsBot( self ) then
            return false
        end
    
        return original.IsBot( self )
    end
    
    function PLAYER:Name()
        if original.IsBot( self ) then
            return info[ self:GetNWInt( "_fi", 1 ) ].steamname
        end
    
        return original.Name( self ) 
    end
    
    function PLAYER:Nick()
        if original.IsBot( self ) then
            return info[ self:GetNWInt( "_fi", 1 ) ].steamname
        end
    
        return original.Nick( self ) 
    end
    
    function PLAYER:GetName()
        if original.IsBot( self ) then
            return info[ self:GetNWInt( "_fi", 1 ) ].steamname
        end
    
        return original.GetName( self ) 
    end
    
    function PLAYER:SteamID()
        if original.IsBot( self ) then
            return info[ self:GetNWInt( "_fi", 1 ) ].steamid
        end
    
        return original.SteamID( self ) 
    end
    
    function PLAYER:SteamID64()
        if original.IsBot( self ) then
            return info[ self:GetNWInt( "_fi", 1 ) ].steamid64
        end
    
        return original.SteamID64( self ) 
    end

    function PLAYER:ShowProfile()
        if original.IsBot( self ) then
            gui.OpenURL( "https://steamcommunity.com/profiles/" .. info[ self:GetNWInt( "_fi", 1 ) ].steamid64 ) 
            return 
        end
    
        return original.ShowProfile( self ) 
    end
end
