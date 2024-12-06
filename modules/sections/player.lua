CyberPsychoPlayer = {
    description = "CyberPsycho Player Component",
	godMode = false,
	infStamina = false,
}

function CyberPsychoPlayer.updateGodMode()
    if CyberPsychoPlayer.godMode then
        Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Invulnerable", CName.new("SecondHeart"))
        if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
            veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
            if veh then
                Game.GetGodModeSystem():AddGodMode(veh:GetEntityID(), "Invulnerable", CName.new("Default"))
            end
        end
    else
        ssc = Game.GetScriptableSystemsContainer()
        es = ssc:Get(CName.new('EquipmentSystem'))
        espd = es:GetPlayerData(Game.GetPlayer())
        espd['GetItemInEquipSlot2'] = espd['GetItemInEquipSlot;gamedataEquipmentAreaInt32']
        for i=0,2 do
            if espd:GetItemInEquipSlot2("CardiovascularSystemCW", i).tdbid.hash == 3619482064 then
                hasSecondHeart = true
            end
        end
        if hasSecondHeart then
            Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Immortal", CName.new("SecondHeart"))
        else
            Game.GetGodModeSystem():DisableOverride(Game.GetPlayer():GetEntityID(), CName.new("SecondHeart"))
        end
        if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
            veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
            if veh then
                Game.GetGodModeSystem():ClearGodMode(veh:GetEntityID(), CName.new("Default"))
            end
        end
    end
end

function CyberPsychoPlayer.updateInfStamina()
	Game.InfiniteStamina(CyberPsychoPlayer.infStamina)
end

return CyberPsychoPlayer