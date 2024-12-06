
CyberPsychoCheats = {
    description = "CyberPsycho Cheats Component",
    moneyToAdd = 0,
    componentAmount = 0,
    componentToAdd = 0,
    componentNames = { "Crafting Legendary", "Crafting Epic", "Crafting Rare", "Crafting Uncommon", "Crafting Common", "Upgrade Legendary", "Upgrade Epic", "Upgrade Rare", "QHack Legendary", "Qhack Epic", "QHack Rare", "QHack Uncommon" },
    componentIDs = { "Items.LegendaryMaterial1", "Items.EpicMaterial1", "Items.RareMaterial1", "Items.UncommonMaterial1", "Items.CommonMaterial1", "Items.LegendaryMaterial2", "Items.EpicMaterial2", "Items.RareMaterial2", "Items.QuickHackLegendaryMaterial1", "Items.QuickHackEpicMaterial1", "Items.QuickHackRareMaterial1", "Items.QuickHackUncommonMaterial1" },
    itemToAdd = "Items.",
    itemAmount = 1,
    godMode = false,
    infStamina = false,
    disablePolice = false,
    noFall = false,
    noClip = false,
    noClipSpeed = 1,
    noClipControls = {
        forward = false,
        backward = false,
        left = false,
        right = false,
        up = false,
        down = false
    }
}


function CyberPsychoCheats.addMoney()

    Game.AddToInventory("Items.money", CyberPsychoCheats.moneyToAdd)

end


function CyberPsychoCheats.addComponents()

    Game.AddToInventory(CyberPsychoCheats.componentIDs[CyberPsychoCheats.componentToAdd+1], CyberPsychoCheats.componentAmount)

end


function CyberPsychoCheats.addItems()

    CyberPsychoCheats.itemToAdd = CyberPsychoCheats.itemToAdd:gsub("Items.", "")
    CyberPsychoCheats.itemToAdd = CyberPsychoCheats.itemToAdd:gsub("Game.AddToInventory[(]\"", "")
    CyberPsychoCheats.itemToAdd = CyberPsychoCheats.itemToAdd:gsub("\",1[)]", "")
    Game.AddToInventory("Items." .. CyberPsychoCheats.itemToAdd, CyberPsychoCheats.itemAmount)

end


function CyberPsychoCheats.updateGodMode()

    if CyberPsychoCheats.godMode then
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


function CyberPsychoCheats.updateInfStamina()

    Game.InfiniteStamina(CyberPsychoCheats.infStamina)

end


function CyberPsychoCheats.updateDisablePolice()

    if CyberPsychoCheats.disablePolice then
        Game.PrevSys_off()
    else
        Game.PrevSys_on()
    end

end


function CyberPsychoCheats.updateNoClip()

    if CyberPsychoCheats.noClip then
        times = Game.GetTimeSystem()
        times:SetIgnoreTimeDilationOnLocalPlayerZero(false)
        Game.SetTimeDilation(0.0000000000001)
    else
        Game.SetTimeDilation(0)
    end

end


function CyberPsychoCheats.noClipTp(direction)

    if CyberPsychoCheats.noClip then
        if direction == "forward" or direction == "backward" then
            dir = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" then
            dir = Game.GetCameraSystem():GetActiveCameraRight()
        end
        pos = Game.GetPlayer():GetWorldPosition()
        if direction == "forward" or direction == "right" then
            xNew = pos.x + (dir.x * CyberPsychoCheats.noClipSpeed)
            yNew = pos.y + (dir.y * CyberPsychoCheats.noClipSpeed)
            zNew = pos.z + (dir.z * CyberPsychoCheats.noClipSpeed)
        elseif direction == "backward" or direction == "left" then
            xNew = pos.x - (dir.x * CyberPsychoCheats.noClipSpeed)
            yNew = pos.y - (dir.y * CyberPsychoCheats.noClipSpeed)
            zNew = pos.z - (dir.z * CyberPsychoCheats.noClipSpeed)
        elseif direction == "up" then
            xNew = pos.x
            yNew = pos.y
            zNew = pos.z + (0.5 * CyberPsychoCheats.noClipSpeed)
        elseif direction == "down" then
            xNew = pos.x
            yNew = pos.y
            zNew = pos.z - (0.5 * CyberPsychoCheats.noClipSpeed)
        end
        tpTo = Vector4.new(xNew,yNew,zNew,pos.w)
        Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), tpTo , EulerAngles.new(0,0,Game.GetPlayer():GetWorldYaw()))
        Game.Heal("100000", "0")
    end

end

return CyberPsychoCheats