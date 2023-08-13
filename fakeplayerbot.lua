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
 { steamid = 'STEAM_0:1:627863287', steamid64 = '76561199215992303', steamname = 'doomguy'   },
    { steamid = 'STEAM_0:0:587604068', steamid64 = '76561199135473864', steamname = 'Cyberprunk2'   },
    { steamid = 'STEAM_0:0:786635720', steamid64 = '76561199533537168', steamname = 'egorchik'   },
    { steamid = 'STEAM_0:0:551039236', steamid64 = '76561199062344200', steamname = 'FOLITE'   },
    { steamid = 'STEAM_0:0:688200093', steamid64 = '76561199336665914', steamname = 'Neko'   },
    { steamid = 'STEAM_0:1:462726666', steamid64 = '76561198885719061', steamname = 'TneEvilCheat'   },
    { steamid = 'STEAM_0:0:755535217', steamid64 = '76561199471336162', steamname = 'Mendeleev'   },
    { steamid = 'STEAM_0:0:537807139', steamid64 = '76561199035880006', steamname = 'Viva Miller'   },
    { steamid = 'STEAM_0:1:786727422', steamid64 = '76561199533720573', steamname = 'pghoster'   },
    { steamid = 'STEAM_0:0:589148475', steamid64 = '76561199138562678', steamname = 'KILLER228'   },
    { steamid = 'STEAM_0:1:212891512', steamid64 = '76561198386048753', steamname = 'НЯМ НЯМ 500'   },
    { steamid = 'STEAM_0:0:774635014', steamid64 = '76561199509535756', steamname = 'volchara'   },
    { steamid = 'STEAM_0:1:161456642', steamid64 = '76561198283179013', steamname = 'My master'   },
    { steamid = 'STEAM_0:1:232674304', steamid64 = '76561198425614337', steamname = 'diko'   },
    { steamid = 'STEAM_0:0:546938804', steamid64 = '76561199054143336', steamname = 'daniilpugachev'   },
    { steamid = 'STEAM_0:1:451438536', steamid64 = '76561198863142801', steamname = 'Genadiy Gorin'   },
    { steamid = 'STEAM_0:0:603342841', steamid64 = '76561199166951410', steamname = 'первокласс'   },
    { steamid = 'STEAM_0:1:431107727', steamid64 = '76561198822481183', steamname = 'AtomLord'   },
    { steamid = 'STEAM_0:1:515282943', steamid64 = '76561198990831615', steamname = 'AlemaNeko224'   },
    { steamid = 'STEAM_0:0:81642121', steamid64 = '76561198123549970', steamname = 'Vladosina'   },
    { steamid = 'STEAM_0:1:118316450', steamid64 = '76561198196898629', steamname = 'katana'   },
    { steamid = 'STEAM_0:1:721739565', steamid64 = '76561199403744859', steamname = 'ozolinsdamir'   },
    { steamid = 'STEAM_0:0:549717127', steamid64 = '76561199059699982', steamname = 'SanSika'   },
    { steamid = 'STEAM_0:1:657215264', steamid64 = '76561199274696257', steamname = 'Jamal Roblox Jr.'   },
    { steamid = 'STEAM_0:1:620106163', steamid64 = '76561199200478055', steamname = 'Makima'   },
    { steamid = 'STEAM_0:1:498479265', steamid64 = '76561198957224259', steamname = 'Amoral afro'   },
    { steamid = 'STEAM_0:1:186988991', steamid64 = '76561198334243711', steamname = 'Andrusha'   },
    { steamid = 'STEAM_0:1:213844273', steamid64 = '76561198387954275', steamname = 'Sen'   },
    { steamid = 'STEAM_0:0:552853604', steamid64 = '76561199065972936', steamname = 'noscx'   },
    { steamid = 'STEAM_0:1:72507672', steamid64 = '76561198105281073', steamname = 'Jacob Hantl'   },
    { steamid = 'STEAM_0:1:571891804', steamid64 = '76561199104049337', steamname = 'arbus'   },
    { steamid = 'STEAM_0:0:512134622', steamid64 = '76561198984534972', steamname = 'Pier dun'   },
    { steamid = 'STEAM_0:0:427329721', steamid64 = '76561198814925170', steamname = 'Shalopai'   },
    { steamid = 'STEAM_0:1:517272985', steamid64 = '76561198994811699', steamname = 'zekivan3'   },
    { steamid = 'STEAM_0:0:558977018', steamid64 = '76561199078219764', steamname = 'zxc_Артем'   },
    { steamid = 'STEAM_0:0:653305191', steamid64 = '76561199266876110', steamname = 'Black Haisenberg'   },
    { steamid = 'STEAM_0:0:695198923', steamid64 = '76561199350663574', steamname = 'BanKai'   },
    { steamid = 'STEAM_0:1:604195238', steamid64 = '76561199168656205', steamname = 'Popirosik'   },
    { steamid = 'STEAM_0:1:728982354', steamid64 = '76561199418230437', steamname = 'PUPCIK'   },
    { steamid = 'STEAM_0:1:429457463', steamid64 = '76561198819180655', steamname = 'tangar'   },
    { steamid = 'STEAM_0:1:767661328', steamid64 = '76561199495588385', steamname = 'HGT'   },
    { steamid = 'STEAM_0:1:437284789', steamid64 = '76561198834835307', steamname = 'Алкаш'   },
    { steamid = 'STEAM_0:1:714543816', steamid64 = '76561199389353361', steamname = 'weikandqw'   },
    { steamid = 'STEAM_0:1:596639033', steamid64 = '76561199153543795', steamname = 'Левый ПКМ'   },
    { steamid = 'STEAM_0:1:727337369', steamid64 = '76561199414940467', steamname = 'su152t3000'   },
    { steamid = 'STEAM_0:0:635040908', steamid64 = '76561199230347544', steamname = 'Jagon von piska'   },
    { steamid = 'STEAM_0:0:561677733', steamid64 = '76561199083621194', steamname = 'Shot'   },
    { steamid = 'STEAM_0:1:700449617', steamid64 = '76561199361164963', steamname = 'Fedor Ivanov'   },
    { steamid = 'STEAM_0:1:577536068', steamid64 = '76561199115337865', steamname = 'Veter'   },
    { steamid = 'STEAM_0:1:434453950', steamid64 = '76561198829173629', steamname = 'jester'   },
    { steamid = 'STEAM_0:0:233255887', steamid64 = '76561198426777502', steamname = 'M_arko'   },
    { steamid = 'STEAM_0:0:170761984', steamid64 = '76561198301789696', steamname = 'Hell_Dragon'   },
    { steamid = 'STEAM_0:0:758488134', steamid64 = '76561199477241996', steamname = 'ЁЖ'   },
    { steamid = 'STEAM_0:1:598008925', steamid64 = '76561199156283579', steamname = 'ZXC АРБУЗ'   },
    { steamid = 'STEAM_0:0:758426195', steamid64 = '76561199477118118', steamname = 'M1kyy'   },
    { steamid = 'STEAM_0:0:583714410', steamid64 = '76561199127694548', steamname = 'Medik'   },
    { steamid = 'STEAM_0:1:449000520', steamid64 = '76561198858266769', steamname = 'Petrov'   },
    { steamid = 'STEAM_0:0:585953114', steamid64 = '76561199132171956', steamname = 'rasKvasilo'   },
    { steamid = 'STEAM_0:1:462534928', steamid64 = '76561198885335585', steamname = 'SucrE'   },
    { steamid = 'STEAM_0:0:233363985', steamid64 = '76561198426993698', steamname = 'Kunixx'   },
    { steamid = 'STEAM_0:0:442617659', steamid64 = '76561198845501046', steamname = 'Yasha_no_ne_Lava'   },
    { steamid = 'STEAM_0:0:630780424', steamid64 = '76561199221826576', steamname = 'Myra'   },
    { steamid = 'STEAM_0:0:663166449', steamid64 = '76561199286598626', steamname = 'koresh'   },
    { steamid = 'STEAM_0:0:762912371', steamid64 = '76561199486090470', steamname = 'mini'   },
    { steamid = 'STEAM_0:1:739624942', steamid64 = '76561199439515613', steamname = 'kostya.bombom'   },
    { steamid = 'STEAM_0:0:573596068', steamid64 = '76561199107457864', steamname = 'Kirill Baranov'   },
    { steamid = 'STEAM_0:1:484522883', steamid64 = '76561198929311495', steamname = 'taburetka'   },
    { steamid = 'STEAM_0:0:568973999', steamid64 = '76561199098213726', steamname = 'Maksim_vatkovskiy'   },
    { steamid = 'STEAM_0:1:526639465', steamid64 = '76561199013544659', steamname = 'Vaska'   },
    { steamid = 'STEAM_0:0:561942984', steamid64 = '76561199084151696', steamname = 'nekto'   },
    { steamid = 'STEAM_0:0:774819507', steamid64 = '76561199509904742', steamname = 'Gimler Blaine'   },
    { steamid = 'STEAM_0:1:623242973', steamid64 = '76561199206751675', steamname = 'Vovich'   },
    { steamid = 'STEAM_0:1:175975157', steamid64 = '76561198312216043', steamname = 'Stark'   },
    { steamid = 'STEAM_0:0:107012621', steamid64 = '76561198174290970', steamname = 'five pos tyan <3'   },
    { steamid = 'STEAM_0:1:65798022', steamid64 = '76561198091861773', steamname = 'Ігарь'   },
    { steamid = 'STEAM_0:1:65468263', steamid64 = '76561198091202255', steamname = 'Sam'   },
    { steamid = 'STEAM_0:1:550246312', steamid64 = '76561199060758353', steamname = 'igroman'   },
    { steamid = 'STEAM_0:1:672114343', steamid64 = '76561199304494415', steamname = 'ImNasochek'   },
    { steamid = 'STEAM_0:0:742687871', steamid64 = '76561199445641470', steamname = 'MrBeast)'   },
    { steamid = 'STEAM_0:0:529441919', steamid64 = '76561199019149566', steamname = '1000-993?'   },
    { steamid = 'STEAM_0:1:483333659', steamid64 = '76561198926933047', steamname = 'zxсмерть'   },
    { steamid = 'STEAM_0:1:736489122', steamid64 = '76561199433243973', steamname = 'Imperator Death'   },
    { steamid = 'STEAM_0:0:433345518', steamid64 = '76561198826956764', steamname = 'kiska'   },
    { steamid = 'STEAM_0:0:61674982', steamid64 = '76561198083615692', steamname = '_ШЕКС_'   },
    { steamid = 'STEAM_0:0:633354755', steamid64 = '76561199226975238', steamname = 'Валера Логунов'   },
    { steamid = 'STEAM_0:1:622583547', steamid64 = '76561199205432823', steamname = 'GG_GUBY'   },
    { steamid = 'STEAM_0:0:641123502', steamid64 = '76561199242512732', steamname = 'W5673I'   },
    { steamid = 'STEAM_0:0:503821893', steamid64 = '76561198967909514', steamname = 'dropov'   },
    { steamid = 'STEAM_0:1:567477023', steamid64 = '76561199095219775', steamname = 'FreakMackFucker'   },
    { steamid = 'STEAM_0:0:156649459', steamid64 = '76561198273564646', steamname = 'haski_'   },
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

/*
local plys = player.GetAll()

for i = 1, #plys do
    local ply = plys[ i ]
    print( "{ steamid = " .. ply:SteamID() .. ", steamid64 = " .. ply:SteamID64() .. ", steamname = " .. ply:Name() .. "   }," )
end
*/
