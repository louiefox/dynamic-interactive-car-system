DICS.TEMP.BrokenCars = DICS.TEMP.BrokenCars or {}
local function onCoreBrokenChange( ent, name, oldVal, newVal )
    if( newVal == true ) then
        DICS.TEMP.BrokenCars[ent] = true
    else
        DICS.TEMP.BrokenCars[ent] = nil
    end
end

local function intializeVehicle( ent )
	if( not ent:IsDICSVehicle() ) then return end

	ent:SetNW2VarProxy( "dicsCoreBroken", onCoreBrokenChange )
end

hook.Add( "OnEntityCreated", "DICS.OnEntityCreated.DamageEffects", function( ent )
	if( not ent:IsVehicle() ) then return end

	timer.Simple( 0, function()
		if( not IsValid( ent ) ) then return end
		intializeVehicle( ent )
	end )
end )

local nextThink = 0
hook.Add( "Think", "DICS.Think.DamageEffects", function()
	if( CurTime() < nextThink ) then return end
    nextThink = CurTime()+1

    for ent, _ in pairs( DICS.TEMP.BrokenCars ) do
        if( not IsValid( ent ) ) then
            DICS.TEMP.BrokenCars[ent] = nil
            continue
        end

        -- if( ent.dicsCoreSmoke ) then continue end

        local vPoint = ent:GetPos() + ent:GetUp() * 65 - ent:GetRight() * 100
        local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		-- effectdata:SetScale(2)
		-- effectdata:SetMagnitude( 1 )
		effectdata:SetEntity( ent )
		-- effectdata:SetNormal( Vector( 0, 0, 1 ) )
		util.Effect("nova_enginesmoke_destroyed", effectdata)

        local vPoint = ent:GetPos() + ent:GetUp() * 65 - ent:GetRight() * 100
        local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(2)
		effectdata:SetMagnitude( 1 )
		effectdata:SetEntity( ent )
		effectdata:SetNormal( Vector( 0, 0, 1 ) )
		util.Effect("ElectricSpark", effectdata)

        print( "HERE ")

        -- ent.dicsCoreSmoke = true
    end
end )

concommand.Add( "testtttttt", function()
    PrintTable( DICS.TEMP.BrokenCars )
end )