local function GetCorrectShootPos( Ent )
	local AttachmentId = Ent:LookupAttachment( "anim_attachment_rh" )

    if not AttachmentId then
        return Ent:GetShootPos(), Ent:EyeAngles():Forward()
    end

    local Attachment = Ent:GetAttachment( AttachmentId )
    local Pos, Ang = Attachment.Pos, Attachment.Ang

    return Pos, Ang:Forward()
end

function EntityFireBullets( entity, data )
    if not entity:IsPlayer() then return end 

    data.Src, data.Dir = GetCorrectShootPos( entity )

    return true     
end

hook.Add( "EntityFireBullets", "FireOriginCorrection", EntityFireBullets )
