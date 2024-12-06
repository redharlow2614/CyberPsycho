function fileExists(filename)
    local f=io.open(filename,"r") if (f~=nil) then io.close(f) return true else return false end
end
function getCWD(mod_name)
    if fileExists("bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("mods/"..mod_name.."/init.lua") then return "mods/"..mod_name.."/" elseif  fileExists(mod_name.."/init.lua") then return mod_name.."/" elseif  fileExists("init.lua") then return "" end
end


CyberPsycho = {
    description = "CyberPsycho",
    version = "2.4h4",
    rootPath =  getCWD("CyberPsycho"),
    drawWindow = false,
    oldDrawWindow = false
}

-- Hack: Multiple string subindexes with . like CyberPsycho["Cheats.noClip"], thanks NonameNonumber !
setmetatable(CyberPsycho, {
    __index = function(the_table, key)
        while key:find("%.") do
            the_table = rawget(the_table, key:sub(1, key:find("%.")-1))
            key = key:sub(key:find("%.")+1)
        end
        return rawget(the_table, key)
    end,
    __newindex = function(the_table, key, value)
        while key:find("%.") do
            the_table = rawget(the_table, key:sub(1, key:find("%.")-1))
            key = key:sub(key:find("%.")+1)
        end
        rawset(the_table, key, value)
    end
})


-- Imports
CyberPsycho.Data      = require(CyberPsycho.rootPath .. "modules/data")
CyberPsycho.Player    = require(CyberPsycho.rootPath .. "modules/sections/player")
CyberPsycho.UI        = require(CyberPsycho.rootPath .. "modules/ui")
CyberPsycho.OnUpdate  = require(CyberPsycho.rootPath .. "modules/onupdate")
CyberPsycho.Hotkeys   = require(CyberPsycho.rootPath .. "modules/hotkeys")


-- Load Data
CyberPsycho.Data.Load()


-- Hotkeys
CyberPsycho.Hotkeys.SetupHotkeys(CyberPsycho)


-- Events
registerForEvent("onUpdate", function(deltaTime)
    CyberPsycho.OnUpdate.Run(CyberPsycho, deltaTime)
end)

registerForEvent("onOverlayOpen", function()
    CyberPsycho.oldDrawWindow = CyberPsycho.drawWindow
    CyberPsycho.drawWindow = true
    CyberPsycho.UI.overlayOpen = true
end)

registerForEvent("onOverlayClose", function()
    CyberPsycho.drawWindow = CyberPsycho.oldDrawWindow
    CyberPsycho.UI.overlayOpen = false
end)

registerForEvent("onDraw", function()
    if CyberPsycho.drawWindow then
        CyberPsycho.UI.Draw(CyberPsycho)
    end
end)

print("CyberPsycho v" .. CyberPsycho.version .. " loaded! Configure Hotkeys from CET's overlay! ")


return CyberPsycho