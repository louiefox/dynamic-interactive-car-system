local ENTITY = FindMetaTable( "Entity" )

function ENTITY:IsDICSVehicle()
    return self:IsVehicle() and tobool( DICS.VEHICLECFG[self:GetVehicleClass()] )
end