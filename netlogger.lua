/*
    Logs
*/

local frame         = false 
local richtext      = false

local logged        = {}
logged.Original     = {}
logged.Nets         = {}

logged.lastIncoming = "NONE"
logged.lastOutgoing = "NONE"

/*
    Types
*/

local types = {
    { "Vector",     Color( 72, 86, 128 )    }, // 1
    { "Angle",      Color( 128, 72, 86 )    },
    { "Bool",       Color( 128, 128, 72 )   },
    { "Color",      Color( 72, 128, 64 )    },
    { "Number",     Color( 32, 86, 128 )    }, // 5
    { "String",     Color( 164, 128, 86 )   },
    { "Entity",     Color( 128, 32, 32 )    },
    { "Vector",     Color( 72, 86, 128 )    },
    { "VMatrix",    Color( 32, 186, 86 )    },
    { "Vector",     Color( 72, 86, 128 )    }, // 10
    { "Table",      Color( 72, 72, 64 )     }, 
    { "Receive",    Color( 0, 255, 255)     }, 
    { "Send",       Color( 255, 0, 255)     }, 
}

/*
    Log func
*/

local function Log( str, mtypes, writed, read )
    read = read or false
    local lastnet = read and logged.lastIncoming or logged.lastOutgoing

    local strWrite = {}

    for i = 1, #writed do
        strWrite[ i ] = tostring( writed[ i ] )
    end

    logged.Nets[ #logged.Nets + 1 ]   = { b = read, func = str, types = mtypes, writed = strWrite, last = lastnet }

    local sstr = "[" .. lastnet .. "]"

    local col = read and types[ 12 ][ 2 ] or types[ 13 ][ 2 ]
    richtext:InsertColorChange( col.r, col.g, col.b, 255 )
    richtext:AppendText( sstr )

    col  = types[ mtypes[ 1 ] ][ 2 ]
    sstr = "[ " .. str .. " ]"

    richtext:InsertColorChange( col.r, col.g, col.b, 255 )
    richtext:AppendText( sstr )

    sstr = read and " Readed" or " Writed"

    for i = 1, #writed do
        sstr = sstr .. " " .. types[ mtypes[ i ] ][ 1 ] .. " " .. strWrite[ i ]
    end 

    richtext:InsertColorChange( 255, 255, 255, 255 )
    richtext:AppendText( sstr .. "\n" ) 
end

/*  
    Writable
*/

local original_WriteInt = net.WriteInt
net.WriteInt = function( first, second )
    Log( "net.WriteInt", { 5, 5 }, { first, second } )
    original_WriteInt( first, second )
end

local original_WriteColor = net.WriteColor
net.WriteColor = function( first, second )
    if not second then second = false end
    Log( "net.WriteColor", { 4, 3 }, { first, second } )
    original_WriteColor( first, second )
end

local original_WriteData = net.WriteData
net.WriteData = function( first, second )
    Log( "net.WriteData", { 6, 5 }, { first, second } )
    original_WriteData( first, second )
end

local original_WriteUInt = net.WriteUInt
net.WriteUInt = function( first, second )
    Log( "net.WriteUInt", { 5, 5 }, { first, second } )
    original_WriteUInt( first, second )
end

local original_WriteAngle = net.WriteAngle
net.WriteAngle = function( var )
    Log( "net.WriteAngle", { 2 }, { var } )
    original_WriteAngle( var )
end

local original_WriteBit = net.WriteBit
net.WriteBit = function( var )
    Log( "net.WriteBit", { 5 }, { var } )
    original_WriteBit( var )
end

local original_WriteBool = net.WriteBool
net.WriteBool = function( var )
    Log( "net.WriteBool", { 3 }, { var } )
    original_WriteBool( var )
end

local original_WriteDouble = net.WriteDouble
net.WriteDouble = function( var )
    Log( "net.WriteDouble", { 5 }, { var } )
    original_WriteDouble( var )
end

local original_WriteEntity = net.WriteEntity
net.WriteEntity = function( var )
    Log( "net.WriteEntity", { 7 }, { var } )
    original_WriteEntity( var )
end

local original_WriteFloat = net.WriteFloat
net.WriteFloat = function( var )
    Log( "net.WriteFloat", { 5 }, { var } )
    original_WriteFloat( var )
end

local original_WriteMatrix = net.WriteMatrix
net.WriteMatrix = function( var )
    Log( "net.WriteMatrix", { 9 }, { var } )
    original_WriteMatrix( var )
end

local original_WriteNormal = net.WriteNormal
net.WriteNormal = function( var )
    Log( "net.WriteNormal", { 1 }, { var } )
    original_WriteNormal( var )
end

local original_WriteVector = net.WriteVector
net.WriteVector = function( var )
    Log( "net.WriteVector", { 1 }, { var } )
    original_WriteVector( var )
end

local original_WriteString = net.WriteString
net.WriteString = function( var )
    Log( "net.WriteString", { 6 }, { var } )
    original_WriteString( var )
end

local original_WriteTable = net.WriteTable
net.WriteTable = function( var )
    Log( "net.WriteTable", { 11 }, { var } )
    original_WriteTable( var )
end

/*
    Readable
*/

local orignal_ReadAngle = net.ReadAngle
net.ReadAngle = function()
    local result = orignal_ReadAngle()
    Log( "net.ReadAngle", { 2 }, { result }, true )
    return result
end

local orignal_ReadBit = net.ReadBit
net.ReadBit = function()
    local result = orignal_ReadBit()
    Log( "net.ReadBit", { 5 }, { result }, true )
    return result
end

local orignal_ReadBool = net.ReadBool
net.ReadBool = function()
    local result = orignal_ReadBool()
    Log( "net.ReadBool", { 3 }, { result }, true )
    return result
end

local orignal_ReadColor = net.ReadColor
net.ReadColor = function( alpha )
    if not alpha then alpha = false end 
    local result = orignal_ReadColor( alpha )
    Log( "net.ReadColor", { 4 }, { result }, true )
    return result
end

local orignal_ReadData = net.ReadData
net.ReadData = function( num )
    local result = orignal_ReadData( num )
    Log( "net.ReadData", { 6 }, { result }, true )
    return result
end

local orignal_ReadDouble = net.ReadDouble
net.ReadDouble = function()
    local result = orignal_ReadDouble()
    Log( "net.ReadDouble", { 5 }, { result }, true )
    return result
end

local orignal_ReadEntity = net.ReadEntity
net.ReadEntity = function()
    local result = orignal_ReadEntity()
    Log( "net.ReadEntity", { 7 }, { result }, true )
    return result
end

local orignal_ReadFloat = net.ReadFloat
net.ReadFloat = function()
    local result = orignal_ReadFloat()
    Log( "net.ReadFloat", { 5 }, { result }, true )
    return result
end

local orignal_ReadInt = net.ReadInt
net.ReadInt = function( bits )
    local result = orignal_ReadInt( bits )
    Log( "net.ReadInt", { 5 }, { result }, true )
    return result
end

local orignal_ReadMatrix = net.ReadMatrix
net.ReadMatrix = function()
    local result = orignal_ReadMatrix()
    Log( "net.ReadMatrix", { 9 }, { result }, true )
    return result
end

local orignal_ReadNormal = net.ReadNormal
net.ReadNormal = function()
    local result = orignal_ReadNormal()
    Log( "net.ReadNormal", { 1 }, { result }, true )
    return result
end

local orignal_ReadString = net.ReadString
net.ReadString = function()
    local result = orignal_ReadString()
    Log( "net.ReadString", { 6 }, { result }, true )
    return result
end

local orignal_ReadTable = net.ReadTable
net.ReadTable = function()
    local result = orignal_ReadTable()
    Log( "net.ReadTable", { 11 }, { result }, true )
    return result
end

local orignal_ReadUInt = net.ReadUInt
net.ReadUInt = function( bits )
    local result = orignal_ReadUInt( bits )
    Log( "net.ReadUInt", { 5 }, { result }, true )
    return result
end

local orignal_ReadVector = net.ReadVector
net.ReadVector = function()
    local result = orignal_ReadVector()
    Log( "net.ReadVector", { 1 }, { result }, true )
    return result
end

/*
    Send / SendToServer
*/

local original_Start = net.Start 
net.Start = function( str, unreliable )
    logged.lastOutgoing = str
    Log( "net.Start", { 13 }, { str } )
    original_Start( str, true )
end

local original_SendToServer = net.SendToServer 
net.SendToServer = function()
    Log( "net.SendToServer", { 13 }, { logged.lastOutgoing } )
    original_SendToServer()
end

/*
    Override receivers 
*/

local receivers = net.Receivers
local original_Receive = net.Receive 

for key, value in pairs( receivers ) do
    local original_Receiver = value 

    local function Override_Receiver()
        logged.lastIncoming = key
        Log( "net.Receive", { 12 }, { key }, true )

        original_Receiver()
    end

    original_Receive( key, Override_Receiver )
end

net.Receive = function( str, func )
    local original_Receiver = func 

    local function Override_Receiver()
        logged.lastIncoming = str
        Log( "net.Receive", { 12 }, { str }, true )

        original_Receiver()
    end

    original_Receive( str, Override_Receiver )
end

/*
    Vgui panel
*/

frame = vgui.Create( "DFrame" )
frame:SetText( "UNL" )
frame:SetPos( 15, 15 )
frame:SetSize( 700, 500 )
frame:ShowCloseButton( false )
frame:MakePopup()

function frame:Paint( w, h )
    surface.SetDrawColor( 0, 0, 0, 128 )
    surface.DrawRect( 0, 0, w, h )
end

richtext = vgui.Create( "RichText", frame )
richtext:SetPos( 5, 35 )
richtext:SetSize( 690, 450 )
richtext:SetFontInternal( "BudgetLabel" )

/*
    Concommand
*/

concommand.Add( "_unl", function() frame:ToggleVisible() end )

