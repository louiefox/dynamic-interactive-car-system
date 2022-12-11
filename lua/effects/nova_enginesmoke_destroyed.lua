function EFFECT:Init(data)
	self.ent = data:GetEntity()
	-- if !self.ent or !self.ent:IsValid() or !self.ent:IsVehicle() or self.ent:GetClass() != "prop_vehicle_jeep" then return end
	-- local r = CMOD_Cars[self.ent:GetVehicleClass()]
	-- if !r and self.ent.CS_Stats then r = CMOD_Cars[self.ent.CS_Stats.Class] end
	-- if !r or !r.EnginePos then return end
	-- local ps = r.EnginePos
	-- local ps2 = self.ent:GetPos() + (self.ent:GetRight() * -ps.y) + (self.ent:GetUp() * ps.z)

	for i = 1, 2 do
	local randomizer = Vector( math.random(-12, 12), math.random(-12, 12), 0 )
	self.Emitter = ParticleEmitter( data:GetOrigin() )
			if !self.Emitter then return end

			local beat = self.Emitter:Add("particle/smokesprites_000"..math.random(1,8), data:GetOrigin())
			if (beat) then
				beat:SetPos( data:GetOrigin() + randomizer )
				beat:SetLifeTime(0)
				beat:SetDieTime(2)
				beat:SetStartAlpha(254)
				beat:SetEndAlpha(0)
				beat:SetStartSize(math.random(10,15))
				beat:SetEndSize(math.random(20,35))
				beat:SetCollide(false)
				beat:SetGravity(Vector(0,0,50))
				beat:SetRollDelta( math.random(-4,4) )
				beat:SetColor(55,55,55,math.random(4,30))
				beat:SetVelocity(Vector(math.random(-20, 20),math.random(-20, 20),math.random(20, 30) ))
			end
		end

		self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end