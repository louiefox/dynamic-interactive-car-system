hook.Add( "HUDPaint", "DICS.HUDPaint.Main", function()
    surface.SetDrawColor( 255, 0, 0 )
    surface.DrawRect( 50, 50, 50, 50 )
end )