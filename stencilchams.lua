local ChamsMat = Material("skybox/mr_53bk")
local players

local function StencilChams(  )
	players = player.GetAll()

	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()

	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilFailOperation( STENCIL_REPLACE )

	for i = 1, #players do
		players[ i ]:DrawModel()
	end
	
	render.SetMaterial( ChamsMat )
	render.DrawScreenQuad()

	render.SetStencilEnable( false )
end)

hook.Add( "PostDrawEffects", "StencilChams", StencilChams )
