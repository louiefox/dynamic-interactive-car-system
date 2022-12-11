local VEHICLE = FindMetaTable( "Vehicle" )

-- CORE --
function VEHICLE:DamageCore( damage )
    local healthTable = self.DICS.Health
    if( healthTable.Core <= 0 ) then return end

    healthTable.Core = healthTable.Core - damage

	if( healthTable.Core <= 0 ) then
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		effectdata:SetEntity( self )
		util.Effect("Explosion", effectdata)

        self:SetNW2Bool( "dicsCoreBroken", true )
	end
end

-- WHEELS --
function VEHICLE:DamageWheel( wheelNum, damage )
    local wheelsHealthTable = self.DICS.Health.Wheels
    local wheelHealth = wheelsHealthTable[wheelNum]
    if( wheelHealth <= 0 ) then return end

    wheelsHealthTable[wheelNum] = wheelHealth - damage

    if( wheelsHealthTable[wheelNum] <= 0 ) then
        self:KillWheel( wheelNum )
    end
end

function VEHICLE:KillWheel( num )
    local wheelCfg = DICS.VEHICLECFG[self:GetVehicleClass()].Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 0, 0, 0 ) )

	self:SetSpringLength( num, DICS.CFG.BrokeSuspension )

    self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() * 0.1 )
	self:EmitSound( "weapons/pistol/pistol_fire3.wav", 150, 50 )
end

function VEHICLE:RepairWheel( num )
    local vehicleCfg = DICS.VEHICLECFG[self:GetVehicleClass()]
    local wheelCfg = vehicleCfg.Wheel

    self:ManipulateBoneScale( self:LookupBone( wheelCfg.Bones[num] ), Vector( 1, 1, 1 ) )
	self:SetSpringLength( num, DICS.CFG.NormalSuspension + vehicleCfg.Suspension / 100 )
end

-- REPARING --
function VEHICLE:RepairFull( num )
    self.DICS.Health = {
		Core = 100,
		Wheels = {
			[0] = 100,
			[1] = 100,
			[2] = 100,
			[3] = 100
		}
	}

    self:SetNW2Bool( "dicsCoreBroken", false )

    for i = 0, 3 do
        self:RepairWheel( i )
    end
end