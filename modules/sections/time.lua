
CyberPsychoTime = {
    description = "CyberPsycho Time Component",
    h = 0,
    m = 0,
    s = 0,
    stopTime = false,
    stopTimeValue = false,
    superHot = false,
    timeMultiplier = 1
}


function CyberPsychoTime.setTime()

    Game.GetTimeSystem():SetGameTimeByHMS(CyberPsychoTime.h, CyberPsychoTime.m, CyberPsychoTime.s)

end


function CyberPsychoTime.updateStopTimeValue()

    if CyberPsychoTime.stopTime then
        times = Game.GetTimeSystem()
        CyberPsychoTime.stopTimeValue = math.floor(times:GetGameTimeStamp())
    end

end


function CyberPsychoTime.updateSuperHot()

    if CyberPsychoTime.superHot then
        Game.GetTimeSystem():SetIgnoreTimeDilationOnLocalPlayerZero(true)
        Game.SetTimeDilation(0.0000000000001)
    else
        Game.GetTimeSystem():SetIgnoreTimeDilationOnLocalPlayerZero(false)
        Game.SetTimeDilation(0)
    end

end

return CyberPsychoTime