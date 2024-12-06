function fileExists(filename)
    local f=io.open(filename,"r") if (f~=nil) then io.close(f) return true else return false end
end
function getCWD(mod_name)
    if fileExists("bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("mods/"..mod_name.."/init.lua") then return "mods/"..mod_name.."/" elseif  fileExists(mod_name.."/init.lua") then return mod_name.."/" elseif  fileExists("init.lua") then return "" end
end


CyberPsychoData = {
    description = "CyberPsycho Data Component",
    rootPath = getCWD("CyberPsycho")
}

CyberPsychoData.dataPath = CyberPsychoData.rootPath .. "CyberPsycho_data.json"

function CyberPsychoData.Load()

    if fileExists(CyberPsychoData.dataPath) then
        f = io.open(CyberPsychoData.dataPath, "r")
        CyberPsychoData.json = json.decode(f:read("*all"))
        io.close(f)
    else
        f = io.open(CyberPsychoData.dataPath, "w")
        f:write("{\"loadouts\":{},\"warps\":{}")
        io.close(f)
        f = io.open(CyberPsychoData.dataPath, "r")
        CyberPsychoData.json = json.decode(f:read("*all"))
        io.close(f)
    end

    CyberPsychoData.warpsNames = {}
    for warp, _ in pairs(CyberPsychoData.json.warps) do
        table.insert(CyberPsychoData.warpsNames, warp)
    end
    CyberPsychoData.loadoutNames = {}
    for loadout, _ in pairs(CyberPsychoData.json.loadouts) do
        table.insert(CyberPsychoData.loadoutNames, loadout)
    end

end


function CyberPsychoData.Save()

    f = io.open(CyberPsychoData.dataPath, "w+")
    f:write(json.encode(CyberPsychoData.json))
    io.close(f)

end

return CyberPsychoData