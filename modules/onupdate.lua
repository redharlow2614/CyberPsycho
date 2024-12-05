
Str8upOnUpdate = {
    description = "Str8up OnUpdate Component",
    timers = {
        t0125s = 0,
        t2s = 0
    }
}


function Str8upOnUpdate.Run(CyberPsycho, deltaTime)

    if CyberPsycho.UI.popupTimeout ~= 0 then
        CyberPsycho.UI.popupTimeout = CyberPsycho.UI.popupTimeout - deltaTime
        if CyberPsycho.UI.popupTimeout < 0 then
            CyberPsycho.UI.popupTimeout = 0
        end
    end

    Str8upOnUpdate.timers.t0125s = Str8upOnUpdate.timers.t0125s + deltaTime
    if Str8upOnUpdate.timers.t0125s > 0.125 then
        Str8upOnUpdate.timers.t0125s = Str8upOnUpdate.timers.t0125s - 0.125
        if CyberPsycho.Time.stopTime then
            times = Game.GetTimeSystem()
            times:SetGameTimeBySeconds(CyberPsycho.Time.stopTimeValue)
        elseif CyberPsycho.Time.timeMultiplier ~= 1 then
            times = Game.GetTimeSystem()
            if not times:IsPausedState() then
                times:SetGameTimeBySeconds(math.floor(times:GetGameTimeStamp())+((CyberPsycho.Time.timeMultiplier-1)))
            end
        end
    end

    Str8upOnUpdate.timers.t2s = Str8upOnUpdate.timers.t2s + deltaTime
    if Str8upOnUpdate.timers.t2s > 2 then
        Str8upOnUpdate.timers.t2s = Str8upOnUpdate.timers.t2s - 2
        if CyberPsycho.Vehicle.autoFixVehicle then
            CyberPsycho.Vehicle.fixVehicle()
        end
        if CyberPsycho.Cheats.godMode then
            CyberPsycho.Cheats.updateGodMode()
        end
    end

    if CyberPsycho.Cheats.noFall then
        vel = Game.GetPlayer():GetVelocity().z
        if vel < -15 then
            pos = Game.GetPlayer():GetWorldPosition()
            closeToGround = not Game.GetSenseManager():IsPositionVisible(pos, Vector4.new(pos.x, pos.y, pos.z + (vel * deltaTime) - 1, pos.w))
            if closeToGround then
                CyberPsycho.Utilities.stopFall()
            end
        end
    end

    if CyberPsycho.Cheats.noClip then
        if CyberPsycho.Cheats.noClipControls.forward then
            CyberPsycho.Cheats.noClipTp("forward")
        end
        if CyberPsycho.Cheats.noClipControls.backward then
            CyberPsycho.Cheats.noClipTp("backward")
        end
        if CyberPsycho.Cheats.noClipControls.left then
            CyberPsycho.Cheats.noClipTp("left")
        end
        if CyberPsycho.Cheats.noClipControls.right then
            CyberPsycho.Cheats.noClipTp("right")
        end
        if CyberPsycho.Cheats.noClipControls.up then
            CyberPsycho.Cheats.noClipTp("up")
        end
        if CyberPsycho.Cheats.noClipControls.down then
            CyberPsycho.Cheats.noClipTp("down")
        end
    end

end

return Str8upOnUpdate