require("zxcmodule")
local slowmoticks = 0

local engine_TickInterval = engine.TickInterval()
local function TimeToTicks( time )
	return math.floor( 0.5 + time / engine_TickInterval )
end

local function hook_SendNetMsg( msgName )
    if msgName == "clc_Move" then
        if input.IsKeyDown( KEY_J ) then
            if slowmoticks < TimeToTicks( 0.5 ) then
                ded.EnableSlowmotion( true )
                slowmoticks = slowmoticks + 1
            else
                ded.EnableSlowmotion( false )
                slowmoticks = 0
            end
        else
            ded.EnableSlowmotion( false )
            slowmoticks = 0
        end
    end
end

ded.SetInterpolation( false )
ded.SetSequenceInterpolation( false )

hook.Add( "SendNetMsg", "hook_SendNetMsg", hook_SendNetMsg )
