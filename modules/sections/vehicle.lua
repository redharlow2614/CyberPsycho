
CyberPsychoVehicle = {
    description = "CyberPsycho Vehicle Component",
    autoFixVehicle = false
}


function CyberPsychoVehicle.fixVehicle()

    if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
        veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
        if veh then
            vehPS = veh:GetVehiclePS()
            vehVC = veh:GetVehicleComponent()
            veh:DestructionResetGrid()
            veh:DestructionResetGlass()
            vehVC:RepairVehicle()
            vehPS:ForcePersistentStateChanged()
        end
    end

end


function CyberPsychoVehicle.toggleSummonMode()

    Game.GetVehicleSystem():ToggleSummonMode()

end

return CyberPsychoVehicle