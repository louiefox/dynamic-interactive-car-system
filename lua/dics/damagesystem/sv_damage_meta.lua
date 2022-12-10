local VEHICLE = FindMetaTable( "Vehicle" )

function VEHICLE:KillTyre( num )
    local wheelCfg = DICS.VEHICLECFG[self:GetVehicleClass()].Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 0, 0, 0 ) )

	self:SetSpringLength( num, 499 )

    self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() * 0.1 )
	self:EmitSound( "weapons/pistol/pistol_fire3.wav", 150, 50 )
end

function VEHICLE:KillTyre( num )
    local wheelCfg = DICS.VEHICLECFG[self:GetVehicleClass()].Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 0, 0, 0 ) )

	self:SetSpringLength( num, DICS.CFG.BrokeSuspension )

    self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() * 0.1 )
	self:EmitSound( "weapons/pistol/pistol_fire3.wav", 150, 50 )
end

function VEHICLE:RepairTyre( num )
    local vehicleCfg = DICS.VEHICLECFG[self:GetVehicleClass()]
    local wheelCfg = vehicleCfg.Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 1, 1, 1 ) )
	self:SetSpringLength( num, DICS.CFG.NormalSuspension + vehicleCfg.Suspension / 100 )
end

function VEHICLE:RepairFull( num )
    for i = 0, 3 do
        self:RepairTyre( i )
    end
end