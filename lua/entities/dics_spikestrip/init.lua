AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_building_details/Storefront_Template001a_Bars.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
	if( phys:IsValid() ) then
		phys:Wake()
	end

    self:SetUseType( SIMPLE_USE )
end

function ENT:Use( ply )

end

function ENT:StartTouch( entity )
    if( not entity:IsDICSVehicle() or entity.IsVehicleDeadBruv ) then return end
    entity.IsVehicleDeadBruv = true

    entity:KillTyre( 0 )
    entity:KillTyre( 1 )

    self:Remove()
end

-- function ENT:SpawnFunction( ply, tr, ClassName )
-- 	if ( !tr.Hit ) then return end

-- 	local SpawnPos = tr.HitPos + tr.HitNormal * 10
-- 	local SpawnAng = ply:EyeAngles()
-- 	SpawnAng.p = 0
-- 	SpawnAng.y = SpawnAng.y + 180

-- 	local ent = ents.Create( ClassName )
-- 	ent:SetPos( SpawnPos )
-- 	ent:SetAngles( SpawnAng+Angle( 0, 180, 0 ) )
-- 	ent:Spawn()
-- 	ent:Activate()

-- 	return ent
-- end

function ENT:OnRemove()

end