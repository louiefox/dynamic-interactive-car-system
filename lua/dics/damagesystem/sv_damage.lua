hook.Add( "EntityTakeDamage", "DICS.EntityTakeDamage.DamageSystem", function( ent, dmg )
	-- if not SVMOD:IsVehicle(ent) or not ent:SV_IsDriverSeat() then
	-- 	return
	-- end

	-- if dmg:GetInflictor() == ent then
	-- 	return
	-- end

	-- local totalDamage = dmg:GetDamage()
	-- if totalDamage < 0.1 then
	-- 	-- Fix for GMod doing shit on the damage
	-- 	totalDamage = totalDamage * 10000
	-- end

	-- totalDamage = math.floor(math.max(1, totalDamage * SVMOD.CFG.Damage.BulletMultiplier))

	-- -- Deal damage to the driver
	-- local driver = ent:GetDriver()
	-- if IsValid(driver) then
	-- 	local dInfo = DamageInfo()
	-- 	dInfo:SetAttacker(dmg:GetAttacker())
	-- 	dInfo:SetInflictor(dmg:GetInflictor())
	-- 	dInfo:SetDamage(math.Round(totalDamage * 0.5 * SVMOD.CFG.Damage.DriverMultiplier))
	-- 	dInfo:SetDamageType(DMG_VEHICLE)
	-- 	driver:TakeDamageInfo(dInfo)
	-- end

	-- -- Deal damage to passengers
	-- for _, passengerSeat in ipairs(ent:SV_GetPassengerSeats()) do
	-- 	if IsValid(passengerSeat:GetDriver()) then
	-- 		local dInfo = DamageInfo()
	-- 		dInfo:SetAttacker(dmg:GetAttacker())
	-- 		dInfo:SetInflictor(dmg:GetInflictor())
	-- 		dInfo:SetDamage(math.Round(totalDamage * 0.5 * SVMOD.CFG.Damage.PassengerMultiplier))
	-- 		dInfo:SetDamageType(DMG_VEHICLE)
	-- 		passengerSeat:GetDriver():TakeDamageInfo(dInfo)
	-- 	end
	-- end

	-- local nearestWheelID, nearestWheelDistance = ent:SV_GetNearestWheel(ent:WorldToLocal(dmg:GetDamagePosition()))

	-- if nearestWheelDistance < 800 then
	-- 	ent:SV_SetHealth(ent:SV_GetHealth() - totalDamage * 0.2)
	-- 	ent:SV_DealDamageToWheel(nearestWheelID, totalDamage * 0.8 * SVMOD.CFG.Damage.WheelShotMultiplier)
	-- 	ent:SV_StartPunctureWheel(nearestWheelID, SVMOD.CFG.Damage.TimeBeforeWheelIsPunctured) -- 0 to disable
	-- else
	-- 	ent:SV_SetHealth(ent:SV_GetHealth() - totalDamage * 0.8)
	-- 	ent:SV_DealDamageToWheel(nearestWheelID, totalDamage * 0.2 * SVMOD.CFG.Damage.WheelShotMultiplier)
	-- end
end )