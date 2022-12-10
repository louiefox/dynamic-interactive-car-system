drive.Register( "drive_dics_vehicle", 
{
    Init = function( self, cmd )			
        if( SERVER ) then			
            self.Player:SetParent( self.Entity )
        end

        TEST_MOVECALSLS = 0
        print( "[DICS] Player [" .. self.Player:Nick() .. "] entered vehicle [" .. self.Entity:EntIndex() .. "]" )
    end,

	SetupControls = function( self, cmd )	

    end,

    -- Stop = function( self )
    --     print( "TEST")
	-- 	self.StopDriving = true
	-- end,

    -- End = function( self, ply, ent )
    --     print( "TEST")
    --     ply:SetParent( nil )
	-- end,

	--
	-- Calculates the view when driving the entity
	--
	CalcView =  function( self, view )
        local dist = 300
        local hullsize = 2
        local entityfilter = { self.Entity }

		--
		-- > Get the current position (teh center of teh entity)
		-- > Move the view backwards the size of the entity
		--
		local neworigin = view.origin - self.Player:EyeAngles():Forward() * dist


		if ( hullsize && hullsize > 0 ) then

			--
			-- > Trace a hull (cube) from the old eye position to the new
			--
			local tr = util.TraceHull( {
				start	= view.origin,
				endpos	= neworigin,
				mins	= Vector( hullsize, hullsize, hullsize ) * -1,
				maxs	= Vector( hullsize, hullsize, hullsize ),
				filter	= entityfilter
			} )

			--
			-- > If we hit something then stop there
			--		[ stops the camera going through walls ]
			--
			if ( tr.Hit ) then
				neworigin = tr.HitPos
			end

		end

		--
		-- Set our calculated origin
		--
		view.origin		= neworigin

		--
		-- Set the angles to our view angles (not the entities eye angles)
		--
		view.angles		= self.Player:EyeAngles()

		view.angles.roll = 0
	end,

	--
	-- Called before each move. You should use your entity and cmd to 
	-- fill mv with information you need for your move. 
	--
	StartMove =  function( self, mv, cmd )
		self.Player:SetObserverMode( OBS_MODE_CHASE )
        
		mv:SetVelocity( self.Entity:GetAbsVelocity() )
	end,

	--
	-- Runs the actual move. On the client when there's 
	-- prediction errors this can be run multiple times.
	-- You should try to only change mv.
	--
	Move = function( self, mv )
        if( SERVER and mv:KeyDown( IN_USE ) and CurTime() >= (self.Entity.DriveStarted or 0)+1 ) then 
            self.Entity:KickDriver()
            return
        end

		--
		-- Set up a speed, go faster if shift is held down
		--
		local speed = 0.05 * FrameTime()
		-- if ( mv:KeyDown( IN_SPEED ) ) then speed = 0.005 * FrameTime() end

		--
		-- Get information from the movedata
		--
		local ang = self.Entity:GetAngles()
		-- local pos = mv:GetOrigin()
		local vel = Vector( 0, 0, 0 )--mv:GetVelocity()

		--
		-- Add velocities. This can seem complicated. On the first line
		-- we're basically saying get the forward vector, then multiply it
		-- by our forward speed (which will be > 0 if we're holding W, < 0 if we're
		-- holding S and 0 if we're holding neither) - and add that to velocity.
		-- We do that for right and up too, which gives us our free movement.
		--
		vel = vel + ang:Forward() * mv:GetForwardSpeed() * speed
		-- vel = vel + ang:Right() * mv:GetSideSpeed() * speed
		-- vel = vel + ang:Up() * mv:GetUpSpeed() * speed

		--
		-- We don't want our velocity to get out of hand so we apply
		-- a little bit of air resistance. If no keys are down we apply
		-- more resistance so we slow down more.
		--
 		-- if ( math.abs(mv:GetForwardSpeed()) + math.abs(mv:GetSideSpeed()) + math.abs(mv:GetUpSpeed()) < 0.1 ) then
		-- 	vel = vel * 0.90
		-- else
		-- 	vel = vel * 0.99
		-- end

		--
		-- Add the velocity to the position (this is the movement)
		--
		-- pos = pos + vel

		--
		-- We don't set the newly calculated values on the entity itself
		-- we instead store them in the movedata. These get applied in F inishMove.
		--
		mv:SetVelocity( vel )
		-- mv:SetOrigin( pos )
	end,

	--
	-- The move is finished. Use mv to set the new positions
	-- on your entities/players.
	--
	FinishMove =  function( self, mv )
		--
		-- Update our entity!
		--
		-- self.Entity:SetNetworkOrigin( mv:GetOrigin() )
		-- self.Entity:SetVelocity( mv:GetVelocity() )
        -- print( self.Entity:GetVelocity() )
		-- self.Entity:SetAngles( mv:GetMoveAngles() )
        -- self.Entity:SetNetworkOrigin( mv:GetOrigin() )
		-- self.Entity:SetAbsVelocity( mv:GetVelocity() )

		--
		-- If we have a physics object update that too. But only on the server.
		--
		-- if( CLIENT and IsValid( self.Entity:GetPhysicsObject() ) ) then
		-- 	-- self.Entity:GetPhysicsObject():SetVelocity( mv:GetVelocity() )
        --     self.Entity:SetVelocity( mv:GetVelocity() )
		-- end

        		--
		-- Update our entity!
		--
		-- self.Entity:SetNetworkOrigin( mv:GetOrigin() )
		-- self.Entity:SetAbsVelocity( mv:GetVelocity() )
		-- self.Entity:SetAngles( mv:GetMoveAngles() )

		--
		-- If we have a physics object update that too. But only on the server.
		--
		if( IsValid( self.Entity:GetPhysicsObject() ) ) then
			self.Entity:GetPhysicsObject():AddVelocity( mv:GetVelocity() )
            print( mv:GetVelocity() )
		end
	end,

} )