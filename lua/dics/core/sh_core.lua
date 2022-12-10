function DICS.FUNC.WheelNumToName( num )
    return num == DICS.WHEEL.FL and "Front Left" 
        or num == DICS.WHEEL.FR and "Front Right" 
        or num == DICS.WHEEL.RL and "Rear Left" 
        or num == DICS.WHEEL.RR and "Rear Right" 
        or "Invalid"
end

properties.Add( "dicsrepair", {
	MenuLabel = "Repair Vehicle",
	Order = 0,
	MenuIcon = "icon16/bullet_wrench.png",
	Filter = function( self, ent, ply )
		return IsValid( ent ) and ent:IsDICSVehicle()
	end,
	Action = function( self, ent )
		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()
	end,
	Receive = function( self, length, ply )
		local ent = net.ReadEntity()

		if( !properties.CanBeTargeted( ent, ply ) ) then return end
		if( !self:Filter( ent, ply ) ) then return end

		ent:RepairFull()
	end 
} )

properties.Add( "dicsdamage", {
	MenuLabel = "Damage Vehicle",
	Order = 1,
	MenuIcon = "icon16/cog.png",
	Filter = function( self, ent, ply )
		return IsValid( ent ) and ent:IsDICSVehicle()
	end,
	Action = function( self, eEnt ) end,
	MenuOpen = function( self, option, ent )
		local subMenu = option:AddSubMenu()

        for i = 0, 3 do
            subMenu:AddOption( "Wheel - " .. DICS.FUNC.WheelNumToName( i ), function()
                self:MsgStart()
                    net.WriteEntity( ent )
                    net.WriteUInt( i, 2 )
                self:MsgEnd()
            end ):SetIcon( "icon16/cog.png" )
        end
	end,
    Receive = function( self, length, ply )
		local ent = net.ReadEntity()

		if( !properties.CanBeTargeted( ent, ply ) ) then return end
		if( !self:Filter( ent, ply ) ) then return end

		ent:KillTyre( net.ReadUInt( 2 ) )
	end 
})