
CyberPsychoOnUpdate = {
    description = "CyberPsycho OnUpdate Component",
    timers = {
        t0125s = 0,
        t2s = 0
    }
}


function CyberPsychoOnUpdate.Run(CyberPsycho, deltaTime)

    if CyberPsycho.UI.popupTimeout ~= 0 then
        CyberPsycho.UI.popupTimeout = CyberPsycho.UI.popupTimeout - deltaTime
        if CyberPsycho.UI.popupTimeout < 0 then
            CyberPsycho.UI.popupTimeout = 0
        end
    end

    CyberPsychoOnUpdate.timers.t2s = CyberPsychoOnUpdate.timers.t2s + deltaTime
    if CyberPsychoOnUpdate.timers.t2s > 2 then
        CyberPsychoOnUpdate.timers.t2s = CyberPsychoOnUpdate.timers.t2s - 2
        if CyberPsycho.Player.godMode then
            CyberPsycho.Player.updateGodMode()
        end
    end

end

return CyberPsychoOnUpdate