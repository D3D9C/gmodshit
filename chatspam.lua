 require( "zxcmodule" )

local me = LocalPlayer()

local strs = {
    "Сила Сулеймана - энергия и выносливость на весь день. sila-suleimana.ru",
    "Мощь в ваших руках с Силой Сулеймана. sila-suleimana.ru",
    "Готовы к вызовам с Силой Сулеймана? sila-suleimana.ru",
    "Больше работоспособности и концентрации с Силой Сулеймана. sila-suleimana.ru",
    "Забудьте о усталости с Силой Сулеймана. sila-suleimana.ru",
    "Природные ингредиенты для преодоления трудностей - Сила Сулеймана. sila-suleimana.ru",
    "Новый уровень энергии с Силой Сулеймана. sila-suleimana.ru",
    "Здоровье и активность с Силой Сулеймана. sila-suleimana.ru",
    "Прилив энергии с первого глотка Силы Сулеймана. sila-suleimana.ru",
    "Добавьте Силу Сулеймана в жизнь и ощутите разницу. sila-suleimana.ru",
}


// local adstr = "ВСЕ ВАШИ УСТРОЙСТВА ЗАРАЖЕНЫ! УБРАТЬ ВИРУС ->

local curname = me:Name()
local uebok = me
local names = {}

local client_cd = 0 
local server_cd = 0.25

local function drawStatus_()
    surface.SetDrawColor( 0, 0, 0 )
    surface.DrawRect( 15, 15, 200, 12 )

    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawRect( 15, 15, 200 - math.Round( client_cd - CurTime(), 2 ) * 10, 12 )
end

local function serejaga_()
    // print( client_cd, CurTime() )

    if CurTime() > client_cd then
        
        local plys = player.GetAll()
        local tars = {}

        for i = 1, #plys do
            local tar = plys[ i ]

            print( "possible targeted ", tar, tar == me, names[ tar ], tar:Name() == curname )

            if tar == me or names[ tar ] or tar:Name() == curname then continue end 

            print( "valid targeted ", tar )

            curname = tar:Name()
            uebok = tar 

            RunConsoleCommand( "say", "// " .. strs[ math.random( 1, #strs ) ] )

            names[ uebok ] = true 
            client_cd = CurTime() + server_cd 

            timer.Simple( 1, function() ded.NetSetConVar( "name", curname ) end )

            break 
        end

        if #names > ( #plys - 3 ) then names = {} end
    end
end

hook.Add( "Think", "CoolAds", serejaga_ ) 
hook.Add( "DrawOverlay", "CoolAds2", drawStatus_ )
