AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

util.PrecacheModel( "models/props_vehicles/car002a_physics.mdl" )

function ENT:Initialize()
	self:SetModel( "models/props_vehicles/car002a_physics.mdl" )

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
    if( self.IsDriving ) then return end

    self.IsDriving = true
    self.Driver = ply
    self.DriveStarted = CurTime()
    drive.PlayerStartDriving( ply, self, "drive_dics_vehicle" )
end

function ENT:KickDriver()
    drive.PlayerStopDriving( self.Driver )
    self.Driver:SetParent( nil )
    self.Driver = nil
    self.IsDriving = false
    self.DriveStarted = nil
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