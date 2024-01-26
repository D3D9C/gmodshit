local function AutoComplete(cmd, stringargs)
    stringargs = string.Trim(stringargs:lower())

    local tbl = {}

    for _, ply in pairs(player.GetAll()) do
        local name = ply:Nick()
        if name:lower():find(stringargs) then
            name = "ipgrab \"" .. name .. "\""
            table.insert(tbl, name)
        end
    end
    
    return tbl
end

concommand.Add( 
    "ipgrab", 
    function( ply, cmd, args )
        local plys = player.GetAll()
        for i = 1, #plys do
            if plys[i]:Name() == tostring( args[ 1 ] ) then
                RunConsoleCommand("say","[IP-SCREAM] Grabbind " .. plys[i]:Name() .. " ip........")

                timer.Simple( 3 ,function()
                    RunConsoleCommand( "say", "[IP-SCREAM] " .. plys[i]:Name() .. " ip - " .. math.random(1,255) .. "." .. math.random(1,255).. "." .. math.random(1,255).. "." .. math.random(1,255) .. "!" ) 
                end )  
            end
        end
    end,
    AutoComplete
)
