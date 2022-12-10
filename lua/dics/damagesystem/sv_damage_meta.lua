local VEHICLE = FindMetaTable( "Vehicle" )

function VEHICLE:KillTyre( num )
    local wheelCfg = DICS.VEHICLECFG[self:GetVehicleClass()].Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 0, 0, 0 ) )

	self:SetSpringLength( num, 499 )

    self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() * 0.1 )
	self:EmitSound( "weapons/pistol/pistol_fire3.wav", 150, 50 )
end