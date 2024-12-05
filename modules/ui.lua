function fileExists(filename)
    local f=io.open(filename,"r") if (f~=nil) then io.close(f) return true else return false end
end
function getCWD(mod_name)
    if fileExists("bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("mods/"..mod_name.."/init.lua") then return "mods/"..mod_name.."/" elseif  fileExists(mod_name.."/init.lua") then return mod_name.."/" elseif  fileExists("init.lua") then return "" end
end


Str8upUI = {
    description = "Str8up UI Component",
    rootPath = getCWD("CyberPsycho"),
    devMode = false,
    cursor = {
        submenu = "CyberPsycho",
        selected = "Cheats"
    },
    overlayOpen = false,
    x = nil,
    y = nil,
    pendingPopup = { alive = false },
    popupTimeout = 0,
    menu = {
        ["CyberPsycho"] = {
            type = "section",
            maxIndex = 7,
            ["Cheats"] = {
                index = 1,
                type = "section",
                maxIndex = 9,
                ["Money"] = {
                    index = 1,
                    type = "section",
                    maxIndex = 2,
                    ["Amount"] = {
                        index = 1,
                        type = "int",
                        var = "Cheats.moneyToAdd",
                        min = 0,
                        max = 999999999
                    },
                    ["Add"] = {
                        index = 2,
                        type = "button",
                        callback = "Cheats.addMoney"
                    }
                },
                ["Components"] = {
                    index = 2,
                    type = "section",
                    maxIndex = 3,
                    ["Type"] = {
                        index = 1,
                        type = "combo",
                        var = "Cheats.componentToAdd",
                        items = "Cheats.componentNames"
                    },
                    ["Amount"] = {
                        index = 2,
                        type = "int",
                        var = "Cheats.componentAmount",
                        min = 0,
                        max = 999999999
                    },
                    ["Add"] = {
                        index = 3,
                        type = "button",
                        callback = "Cheats.addComponents"
                    }
                },
                ["Items"] = {
                    index = 3,
                    type = "section",
                    maxIndex = 3,
                    ["Name"] = {
                        index = 1,
                        type = "text",
                        var = "Cheats.itemToAdd"
                    },
                    ["Amount"] = {
                        index = 2,
                        type = "int",
                        var = "Cheats.itemAmount",
                        min = 0,
                        max = 999999999
                    },
                    ["Add"] = {
                        index = 3,
                        type = "button",
                        callback = "Cheats.addItems"
                    }
                },
                ["GodMode"] = {
                    index = 4,
                    type = "toggle",
                    var = "Cheats.godMode",
                    callback = "Cheats.updateGodMode"
                },
                ["Infinite Stamina"] = {
                    index = 5,
                    type = "toggle",
                    var = "Cheats.infStamina",
                    callback = "Cheats.updateInfStamina"
                },
                ["Disable Police"] = {
                    index = 6,
                    type = "toggle",
                    var = "Cheats.disablePolice",
                    callback = "Cheats.updateDisablePolice"
                },
                ["No Fall"] = {
                    index = 7,
                    type = "toggle",
                    var = "Cheats.noFall"
                },
                ["NoClip"] = {
                    index = 8,
                    type = "toggle",
                    var = "Cheats.noClip",
                    callback = "Cheats.updateNoClip"
                },
                ["NoClip Speed"] = {
                    index = 9,
                    type = "int",
                    var = "Cheats.noClipSpeed",
                    min = 1,
                    max = 20
                }
            },
            ["Time Warp"] = {
                index = 2,
                type = "section",
                maxIndex = 8,
                ["Hours"] = {
                    index = 1,
                    type = "int",
                    var = "Time.h",
                    callback = "Time.setTime",
                    min = 0,
                    max = 23
                },
                ["Minutes"] = {
                    index = 2,
                    type = "int",
                    var = "Time.m",
                    callback = "Time.setTime",
                    min = 0,
                    max = 59
                },
                ["Seconds"] = {
                    index = 3,
                    type = "int",
                    var = "Time.s",
                    callback = "Time.setTime",
                    min = 0,
                    max = 59
                },
                ["Set Time"] = {
                    index = 4,
                    type = "button",
                    callback = "Time.setTime"
                },
                ["_1"] = {
                    index = 5,
                    type = "spacing"
                },
                ["Stop Time Cycle"] = {
                    index = 6,
                    type = "toggle",
                    var = "Time.stopTime",
                    callback = "Time.updateStopTimeValue"
                },
                ["SuperHot Mode"] = {
                    index = 7,
                    type = "toggle",
                    var = "Time.superHot",
                    callback = "Time.updateSuperHot"
                },
                ["Time Multiplier"] = {
                    index = 8,
                    type = "int",
                    var = "Time.timeMultiplier",
                    min = 1,
                    max = 100
                }
            },
            ["Vehicle"] = {
                index = 3,
                type = "section",
                maxIndex = 3,
                ["Auto Fix Vehicle"] = {
                    index = 1,
                    type = "toggle",
                    var = "Vehicle.autoFixVehicle",
                    callback = "Vehicle.fixVehicle"
                },
                ["Fix Vehicle"] = {
                    index = 2,
                    type = "button",
                    callback = "Vehicle.fixVehicle"
                },
                ["Toggle Summon Mode"] = {
                    index = 3,
                    type = "button",
                    callback = "Vehicle.toggleSummonMode"
                }
            },
            ["Teleport"] = {
                index = 4,
                type = "section",
                maxIndex = 4,
                ["TP to Quest"] = {
                    index = 1,
                    type = "button",
                    callback = "Teleport.tpToQuest"
                },
                ["Special"] = {
                    index = 2,
                    type = "section",
                    maxIndex = 2,
                    ["Dest"] = {
                        index = 1,
                        type = "combo",
                        var = "Teleport.specialTpSelection",
                        items = "Teleport.specialTpNames"
                    },
                    ["Teleport"] = {
                        index = 2,
                        type = "button",
                        callback = "Teleport.specialTp"
                    }
                },
                ["Fast Travel"] = {
                    index = 3,
                    type = "section",
                    maxIndex = 3,
                    ["Area"] = {
                        index = 1,
                        type = "combo",
                        var = "Teleport.fastTravelAreaSelection",
                        items = "Teleport.fastTravelAreaNames"
                    },
                    ["Dest"] = {
                        index = 2,
                        type = "combo",
                        var = "Teleport.fastTravelDestinationSelection",
                        items = "Teleport.fastTravelDestinationNames",
                        itemsSubVar = "Teleport.fastTravelAreaSelection",
                        itemsSubVarMod = "+1"
                    },
                    ["Teleport"] = {
                        index = 3,
                        type = "button",
                        callback = "Teleport.fastTravelTp"
                    }
                },
                ["Warps"] = {
                    index = 4,
                    type = "section",
                    maxIndex = 6,
                    ["Warp"] = {
                        index = 1,
                        type = "combo",
                        var = "Teleport.warpSelection",
                        items = "Data.warpsNames"
                    },
                    ["Warp To"] = {
                        index = 2,
                        type = "button",
                        objCallback = "Teleport.tpToWarp"
                    },
                    ["Remove"] = {
                        index = 3,
                        type = "button",
                        objCallback = "Teleport.removeWarp"
                    },
                    ["_1"] = {
                        index = 4,
                        type = "spacing"
                    },
                    ["New Name"] = {
                        index = 5,
                        type = "text",
                        var = "Teleport.newWarpName"
                    },
                    ["Add Warp"] = {
                        index = 6,
                        type = "button",
                        objCallback = "Teleport.addWarp"
                    }
                }
            },
            ["Player"] = {
                index = 5,
                type = "section",
                maxIndex = 4,
                ["Loadouts"] = {
                    index = 1,
                    type = "section",
                    maxIndex = 6,
                    ["Loadout"] = {
                        index = 1,
                        type = "combo",
                        var = "Player.loadoutSelection",
                        items = "Data.loadoutNames"
                    },
                    ["Load"] = {
                        index = 2,
                        type = "button",
                        objCallback = "Player.loadLoadout"
                    },
                    ["Remove"] = {
                        index = 3,
                        type = "button",
                        objCallback = "Player.removeLoadout"
                    },
                    ["_1"] = {
                        index = 4,
                        type = "spacing"
                    },
                    ["New Name"] = {
                        index = 5,
                        type = "text",
                        var = "Player.newLoadoutName"
                    },
                    ["Add Loadout"] = {
                        index = 6,
                        type = "button",
                        objCallback = "Player.addLoadout"
                    }
                },
                ["Undress"] = {
                    index = 2,
                    type = "button",
                    callback = "Player.undress"
                },
                ["Toggle Bra"] = {
                    index = 3,
                    type = "button",
                    callback = "Player.toggleBra"
                },
                ["Toggle Panties"] = {
                    index = 4,
                    type = "button",
                    callback = "Player.togglePanties"
                }
            },
            ["Utilities"] = {
                index = 6,
                type = "section",
                maxIndex = 3,
                ["Toggle Quest for Equip Items "] = {
                    index = 1,
                    type = "button",
                    callback = "Utilities.toggleQuestItems"
                },
                ["Untrack Quest"] = {
                    index = 2,
                    type = "button",
                    callback = "Utilities.untrackQuest"
                },
                ["Stop Fall"] = {
                    index = 3,
                    type = "button",
                    callback = "Utilities.stopFall"
                }
            },
            ["Settings"] = {
                index = 7,
                type = "section",
                maxIndex = 1,
                ["ClickGUI"] = {
                    index = 1,
                    type = "toggle",
                    var = "Data.json.clickGUI",
                    callback = "Data.Save"
                }
            }
        }
    }
}

-- Hack: Multiple string subindexes with . like CyberPsycho["Cheats.noClip"], thanks NonameNonumber !
setmetatable(Str8upUI.menu, {
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

Str8upUI.Theme = require(Str8upUI.rootPath .. "modules/theme")

function Str8upUI.ListMenuInteractions(CyberPsycho, action)

    if not CyberPsycho.Data.clickGUI and CyberPsycho.drawWindow and not Str8upUI.pendingPopup.alive and Str8upUI.popupTimeout == 0 then
        item = Str8upUI.menu[Str8upUI.cursor.submenu .. "." .. Str8upUI.cursor.selected]
        submenu = Str8upUI.menu[Str8upUI.cursor.submenu]
        if action == "select" then
            if submenu.type == "combo" then
                if submenu.itemsSubVar then
                    CyberPsycho[submenu.var] = (Str8upUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], Str8upUI.cursor.selected) - 1) or 0
                else
                    CyberPsycho[submenu.var] = (Str8upUI.GetIndexFromName(CyberPsycho[submenu.items], Str8upUI.cursor.selected) - 1) or 0
                end
                Str8upUI.cursor.selected = Str8upUI.cursor.submenu:sub(#Str8upUI.cursor.submenu - Str8upUI.cursor.submenu:reverse():find("%.")+2)
                Str8upUI.cursor.submenu = Str8upUI.cursor.submenu:sub(1, #Str8upUI.cursor.submenu - Str8upUI.cursor.submenu:reverse():find("%."))
            elseif item.type == "section" then
                Str8upUI.cursor.submenu = Str8upUI.cursor.submenu .. "." .. Str8upUI.cursor.selected
                Str8upUI.cursor.selected = Str8upUI.GetNameFromIndex(Str8upUI.menu[Str8upUI.cursor.submenu], 1)
            elseif item.type == "combo" then
                Str8upUI.cursor.submenu = Str8upUI.cursor.submenu .. "." .. Str8upUI.cursor.selected
                if item.itemsSubVar then
                    Str8upUI.cursor.selected = CyberPsycho[item.items][CyberPsycho[item.itemsSubVar] + tonumber(item.itemsSubVarMod)][CyberPsycho[item.var]+1] or ""
                else
                    Str8upUI.cursor.selected = CyberPsycho[item.items][CyberPsycho[item.var]+1] or ""
                end
            elseif item.type == "button" then
                if item.callback then
                    CyberPsycho[item.callback]()
                end
                if item.objCallback then
                    CyberPsycho[item.objCallback](CyberPsycho)
                end
            elseif item.type == "toggle" then
                CyberPsycho[item.var] = not CyberPsycho[item.var]
                if item.callback then
                    CyberPsycho[item.callback]()
                end
            elseif item.type == "int" then
                Str8upUI.pendingPopup = {
                    alive = true,
                    type = "int",
                    name = Str8upUI.cursor.selected,
                    var = item.var,
                    callback = item.callback,
                    min = item.min,
                    max = item.max
                }
            elseif item.type == "text" then
                Str8upUI.pendingPopup = {
                    alive = true,
                    type = "text",
                    name = Str8upUI.cursor.selected,
                    var = item.var
                }
            end
        elseif action == "back" then
            if Str8upUI.cursor.submenu:find("%.") then
                Str8upUI.cursor.selected = Str8upUI.cursor.submenu:sub(#Str8upUI.cursor.submenu - Str8upUI.cursor.submenu:reverse():find("%.")+2)
                Str8upUI.cursor.submenu = Str8upUI.cursor.submenu:sub(1, #Str8upUI.cursor.submenu - Str8upUI.cursor.submenu:reverse():find("%."))
            else
                CyberPsycho.drawWindow = false
            end
        elseif action == "up" then
            if submenu.type == "section" then
                curIndex = item.index
                maxIndex = submenu.maxIndex
                if curIndex > 1 then
                    Str8upUI.cursor.selected = Str8upUI.GetNameFromIndex(submenu, curIndex - 1)
                else
                    Str8upUI.cursor.selected = Str8upUI.GetNameFromIndex(submenu, maxIndex)
                end
            elseif submenu.type == "combo" then
                if #CyberPsycho[submenu.items] ~= 0 then
                    if submenu.itemsSubVar then
                        curIndex = Str8upUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], Str8upUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)]
                        if curIndex > 1 then
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][curIndex-1]
                        else
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][maxIndex]
                        end
                    else
                        curIndex = Str8upUI.GetIndexFromName(CyberPsycho[submenu.items], Str8upUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items]
                        if curIndex > 1 then
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][curIndex-1]
                        else
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][maxIndex]
                        end
                    end
                end
            end
        elseif action == "down" then
            if submenu.type == "section" then
                curIndex = item.index
                maxIndex = submenu.maxIndex
                if curIndex < maxIndex then
                    Str8upUI.cursor.selected = Str8upUI.GetNameFromIndex(submenu, curIndex + 1)
                else
                    Str8upUI.cursor.selected = Str8upUI.GetNameFromIndex(submenu, 1)
                end
            elseif submenu.type == "combo" then
                if #CyberPsycho[submenu.items] ~= 0 then
                    if submenu.itemsSubVar then
                        curIndex = Str8upUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], Str8upUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)]
                        if curIndex < maxIndex then
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][curIndex+1]
                        else
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][1]
                        end
                    else
                        curIndex = Str8upUI.GetIndexFromName(CyberPsycho[submenu.items], Str8upUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items]
                        if curIndex < maxIndex then
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][curIndex+1]
                        else
                            Str8upUI.cursor.selected = CyberPsycho[submenu.items][1]
                        end
                    end
                end
            end
        elseif action == "left" then
            if item.type == "int" then
                if CyberPsycho[item.var] > item.min then
                    CyberPsycho[item.var] = CyberPsycho[item.var] - 1
                else
                    CyberPsycho[item.var] = item.max
                end
                if item.callback then
                    CyberPsycho[item.callback]()
                end
            elseif item.type == "combo" then
                if #CyberPsycho[item.items] ~= 0 then
                    if CyberPsycho[item.var] > 0 then
                        CyberPsycho[item.var] = CyberPsycho[item.var] - 1
                    else
                        if item.itemsSubVar then
                            CyberPsycho[item.var] = #CyberPsycho[item.items][CyberPsycho[item.itemsSubVar] + tonumber(item.itemsSubVarMod)] - 1
                        else
                            CyberPsycho[item.var] = #CyberPsycho[item.items] - 1
                        end
                    end
                    if item.callback then
                        CyberPsycho[item.callback]()
                    end
                end
            end
        elseif action == "right" then
            if item.type == "int" then
                if CyberPsycho[item.var] < item.max then
                    CyberPsycho[item.var] = CyberPsycho[item.var] + 1
                else
                    CyberPsycho[item.var] = item.min
                end
                if item.callback then
                    CyberPsycho[item.callback]()
                end
            elseif item.type == "combo" then
                if #CyberPsycho[item.items] ~= 0 then
                    if item.itemsSubVar then
                        if CyberPsycho[item.var] < (#CyberPsycho[item.items][CyberPsycho[item.itemsSubVar] + tonumber(item.itemsSubVarMod)] - 1) then
                            CyberPsycho[item.var] = CyberPsycho[item.var] + 1
                        else
                            CyberPsycho[item.var] = 0
                        end
                        if item.callback then
                            CyberPsycho[item.callback]()
                        end
                    else
                        if CyberPsycho[item.var] < (#CyberPsycho[item.items] - 1) then
                            CyberPsycho[item.var] = CyberPsycho[item.var] + 1
                        else
                            CyberPsycho[item.var] = 0
                        end
                        if item.callback then
                            CyberPsycho[item.callback]()
                        end
                    end
                end
            end
        end
    end

end


function Str8upUI.ColoredText(text, color)

    ImGui.TextColored(color[1], color[2], color[3], color[4], text)

end


function Str8upUI.DrawCursorRect(name)

    _, cursorY = ImGui.GetCursorScreenPos()
    windowX, _ = ImGui.GetWindowPos()
    windowW, _ = ImGui.GetWindowSize()
    _, textY = ImGui.CalcTextSize("I")
    ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.00, 0.94, 1.00, 0.26)
    ImGui.PushStyleColor(ImGuiCol.Border, 0.00, 0.00, 0.00, 0.00)
    ImGui.SetNextWindowPos(windowX + 1, cursorY - 1)
    ImGui.SetNextWindowSize(windowW - 2, textY + 5)
    -- if not Str8upUI.overlayOpen and not Str8upUI.pendingPopup.alive and Str8upUI.popupTimeout == 0 then
    --     ImGui.SetNextWindowFocus()
    -- end
    ImGui.Begin(name .. ".Cursor", true, bit32.bor(ImGuiWindowFlags.NoTitleBar, ImGuiWindowFlags.NoMove, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.AlwaysAutoResize, ImGuiWindowFlags.NoResize))
    ImGui.End()
    ImGui.PopStyleColor(2)

end


function Str8upUI.Section(name)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    Str8upUI.ColoredText(" " .. name, color)
    xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize(">  ")
    ImGui.SameLine(xOffset)
    Str8upUI.ColoredText(">", color)

end


function Str8upUI.ComboItem(name)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    Str8upUI.ColoredText(" " .. name, color)

end


function Str8upUI.Toggle(name, status)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    Str8upUI.ColoredText(" " .. name, color)
    if status == true then
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("ON  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText("ON", { 0.00, 1.00, 0.00, 1.00 })
    else
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("OFF  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText("OFF", { 1.00, 0.00, 0.00, 1.00 })
    end

end


function Str8upUI.Int(name, value)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
        Str8upUI.ColoredText(" " .. name, color)
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("<" .. tostring(value) .. ">  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText("<" .. tostring(value) .. ">", color)
    else
        color = { 0.69, 0.69, 0.69, 1 }
        Str8upUI.ColoredText(" " .. name, color)
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize(tostring(value) .. "  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText(tostring(value), color)
    end

end


function Str8upUI.Combo(CyberPsycho, item)

    if Str8upUI.cursor.selected == item[1] then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(item[1])
        Str8upUI.ColoredText(" " .. item[1], color)  -- fix index higher than max
        if item[2].itemsSubVar then
            if ( CyberPsycho[item[2].var] + 1) > #CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)] then
                CyberPsycho[item[2].var] = #CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)] -1
            end
            value = CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)][CyberPsycho[item[2].var]+1] or ""
        else
            if ( CyberPsycho[item[2].var] + 1) > #CyberPsycho[item[2].items] then
                CyberPsycho[item[2].var] = #CyberPsycho[item[2].items] -1
            end
            value = CyberPsycho[item[2].items][CyberPsycho[item[2].var]+1] or ""
        end
        if #value > 11 then
            value = value:sub(1, 8) .. "..."
        end
        if value == "" then
            value = "   "
        end
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("<" .. value .. ">  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText("<" .. value .. ">", color)
    else
        color = { 0.69, 0.69, 0.69, 1 }
        Str8upUI.ColoredText(" " .. item[1], color)
        if item[2].itemsSubVar then
            if ( CyberPsycho[item[2].var] + 1) > #CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)] then
                CyberPsycho[item[2].var] = #CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)] -1
            end
            value = CyberPsycho[item[2].items][CyberPsycho[item[2].itemsSubVar] + tonumber(item[2].itemsSubVarMod)][CyberPsycho[item[2].var]+1] or ""
        else
            if ( CyberPsycho[item[2].var] + 1) > #CyberPsycho[item[2].items] then
                CyberPsycho[item[2].var] = #CyberPsycho[item[2].items] -1
            end
            value = CyberPsycho[item[2].items][CyberPsycho[item[2].var]+1] or ""
        end
        if #value > 13 then
            value = value:sub(1, 10) .. "..."
        end
        if value == "" then
            value = "   "
        end
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize(value .. "  ")
        ImGui.SameLine(xOffset)
        Str8upUI.ColoredText(value, color)
    end

end


function Str8upUI.Text(name, value)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    if #value > 11 then
        value = value:sub(1, 8) .. "..."
    end
    Str8upUI.ColoredText(" " .. name, color)
    xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize('"' .. value .. '"' .. "  ")
    ImGui.SameLine(xOffset)
    Str8upUI.ColoredText('"' .. value .. '"', color)

end


function Str8upUI.Button(name)

    if Str8upUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        Str8upUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    Str8upUI.ColoredText(" " .. name, color)

end


function Str8upUI.Spacing(name)

    if Str8upUI.cursor.selected == name then
        Str8upUI.DrawCursorRect(name)
    end
    color = { 0, 0, 0, 0 }
    Str8upUI.ColoredText(" ", color)

end


function Str8upUI.CheckIgnoreValue(name)

    local ignored = { "index", "type", "maxIndex", "var", "vallback", "min", "max" }
    for _, v in pairs(ignored) do
        if v == name then
            return true
        end
    end
    return false

end


function Str8upUI.SortItems(input)

    local items = {}
    for item, content in pairs(input) do
        if not Str8upUI.CheckIgnoreValue(item) then
            table.insert(items, {item, content})
        end
    end
    table.sort(items, function(left, right)
        return left[2].index < right[2].index
    end)
    return items

end


function Str8upUI.GetNameFromIndex(submenu, index)

    for name, content in pairs(submenu) do
        if not Str8upUI.CheckIgnoreValue(name) then
            if content.index == index then
                return name
            end
        end
    end
    return nil

end


function Str8upUI.GetIndexFromName(submenu, name)

    if submenu.type == "section" then
        for index, item in pairs(submenu) do
            if not Str8upUI.CheckIgnoreValue(name) then
                if item == name then
                    return index
                end
            end
        end
    elseif type(submenu) == "table" then
        for index, item in pairs(submenu) do
            if item == name then
                return index
            end
        end
    end
    return nil

end


function Str8upUI.Draw(CyberPsycho)

    Str8upUI.Theme.ApplyTheme()

    listThemeApplied = false
    if not CyberPsycho.Data.json.clickGUI then
        listThemeApplied = true
        ImGui.PushStyleColor(ImGuiCol.Border, 0.99, 0.93, 0.04, 0.69)
        ImGui.PushStyleColor(ImGuiCol.TitleBg, 0.99, 0.93, 0.04, 0.69)
    end

    if Str8upUI.devMode and not Str8upUI.menu["CyberPsycho"]["Developer"] then
        Str8upUI.menu["CyberPsycho"].maxIndex = Str8upUI.menu["CyberPsycho"].maxIndex + 1
        Str8upUI.menu["CyberPsycho"]["Developer"] = {
            index = Str8upUI.menu["CyberPsycho"].maxIndex,
            type = "section",
            maxIndex = 1,
            ["Run Dev Script"] = {
                index = 1,
                type = "button",
                objCallback = "Dev.Run"
            }
        }
    elseif not Str8upUI.devMode and Str8upUI.menu["CyberPsycho"]["Developer"] then
        Str8upUI.menu["CyberPsycho"].maxIndex = Str8upUI.menu["CyberPsycho"].maxIndex - 1
        Str8upUI.menu["CyberPsycho"]["Developer"] = nil
    end

    -- Hack: catch errors in gui to ensure theme vars bleeding is avoided
    pcall(function()

        if Str8upUI.pendingPopup.alive then
            ImGui.OpenPopup("Set Value")
            if ImGui.BeginPopupModal("Set Value", bit32.bor(ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.NoScrollWithMouse, ImGuiWindowFlags.NoCollapse)) then
                ImGui.SetWindowFontScale(1.0)
                screenX, screenY = GetDisplayResolution()
                ImGui.SetWindowSize(260, 76)
                ImGui.SetWindowPos((screenX-260)/2, (screenY-76)/2)
                xOffset = ( ImGui.GetWindowWidth() - ImGui.CalcTextSize(Str8upUI.pendingPopup.name) ) / 2
                ImGui.SameLine(xOffset)
                ImGui.Text(Str8upUI.pendingPopup.name)
                ImGui.Spacing()
                ImGui.PushItemWidth(244)
                ImGui.SetKeyboardFocusHere()
                if Str8upUI.pendingPopup.type == "text" then
                    CyberPsycho[Str8upUI.pendingPopup.var], popupConfirmed = ImGui.InputText("", CyberPsycho[Str8upUI.pendingPopup.var], 100, ImGuiInputTextFlags.EnterReturnsTrue)
                elseif Str8upUI.pendingPopup.type == "int" then
                    popupOutput, popupConfirmed = ImGui.InputText("", tostring(CyberPsycho[Str8upUI.pendingPopup.var]), 100, bit32.bor(ImGuiInputTextFlags.EnterReturnsTrue, ImGuiInputTextFlags.CharsDecimal))
                    if popupOutput == "" then
                        popupOutput = Str8upUI.pendingPopup.min
                    end
                    popupOutput = tonumber(popupOutput)
                    if popupOutput > Str8upUI.pendingPopup.max then
                        popupOutput = Str8upUI.pendingPopup.max
                    elseif popupOutput < Str8upUI.pendingPopup.min then
                        popupOutput = Str8upUI.pendingPopup.min
                    end
                    CyberPsycho[Str8upUI.pendingPopup.var] = popupOutput
                end
                if popupConfirmed then
                    ImGui.CloseCurrentPopup()
                    Str8upUI.pendingPopup.alive = false
                    Str8upUI.popupTimeout = 0.2
                end
            end
            ImGui.EndPopup()
        end

        if not CyberPsycho.Data.json.clickGUI then
            title = Str8upUI.cursor.submenu
            if title:find("%.") then
                title = title:gsub("%.", "/")
                title = title:gsub("CyberPsycho/", "")
            end
            if ImGui.Begin(title, bit32.bor(ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.NoScrollWithMouse, ImGuiWindowFlags.NoCollapse, ImGuiWindowFlags.AlwaysAutoResize)) then
                ImGui.SetWindowSize(10, 10)
                if Str8upUI.x and Str8upUI.y and not Str8upUI.overlayOpen then
                    ImGui.SetWindowPos(Str8upUI.x, Str8upUI.y)
                end
                ImGui.SetWindowFontScale(1.2)
                ImGui.SetCursorPosY(12)
                ImGui.Text("                        ")  -- set minimum menu width
                if Str8upUI.menu[Str8upUI.cursor.submenu].type == "section" then
                    items = Str8upUI.SortItems(Str8upUI.menu[Str8upUI.cursor.submenu])
                    for _, item in pairs(items) do
                        if item[2].type == "section" then
                            Str8upUI.Section(item[1])
                        elseif item[2].type == "combo" then
                            Str8upUI.Combo(CyberPsycho, item)
                        elseif item[2].type == "toggle" then
                            Str8upUI.Toggle(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "int" then
                            Str8upUI.Int(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "text" then
                            Str8upUI.Text(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "button" then
                            Str8upUI.Button(item[1])
                        elseif item[2].type == "spacing" then
                            Str8upUI.Spacing(item[1])
                        end
                    end
                elseif Str8upUI.menu[Str8upUI.cursor.submenu].type == "combo" then
                    if Str8upUI.menu[Str8upUI.cursor.submenu].itemsSubVar then
                        items = CyberPsycho[Str8upUI.menu[Str8upUI.cursor.submenu].items][CyberPsycho[Str8upUI.menu[Str8upUI.cursor.submenu].itemsSubVar] + tonumber(Str8upUI.menu[Str8upUI.cursor.submenu].itemsSubVarMod)]
                    else
                        items = CyberPsycho[Str8upUI.menu[Str8upUI.cursor.submenu].items]
                    end
                    if #items == 0 then
                        color = { 0.69, 0.69, 0.69, 1 }
                        Str8upUI.ColoredText(" There's nothing here..", color)
                    else
                        for _, name in pairs(items) do
                            Str8upUI.ComboItem(name)
                        end
                    end
                end
                ImGui.Spacing()
                Str8upUI.x, Str8upUI.y = ImGui.GetWindowPos()
            end
            ImGui.End()
        else
            if ImGui.Begin("CyberPsycho") then
                ImGui.SetWindowFontScale(1.0)
                if ImGui.BeginTabBar("Tabs") then

                    if ImGui.BeginTabItem("Cheats") then
                        ImGui.SetWindowSize(430, 173)
                        ImGui.Spacing()

                        ImGui.PushItemWidth(150)
                        CyberPsycho.Cheats.moneyToAdd = ImGui.InputInt("##Money Amount", CyberPsycho.Cheats.moneyToAdd, 1000, 10000)
                        ImGui.SameLine(162)
                        if ImGui.Button("Add Money", 75, 19) then
                            CyberPsycho.Cheats.addMoney()
                        end

                        ImGui.PushItemWidth(104)
                        CyberPsycho.Cheats.componentAmount = ImGui.InputInt("##Component Amount", CyberPsycho.Cheats.componentAmount, 10, 100)
                        ImGui.SameLine(116)
                        ImGui.PushItemWidth(154)
                        CyberPsycho.Cheats.componentToAdd = ImGui.Combo("##Component Name", CyberPsycho.Cheats.componentToAdd, CyberPsycho.Cheats.componentNames, #CyberPsycho.Cheats.componentNames, #CyberPsycho.Cheats.componentNames)
                        ImGui.SameLine(274)
                        if ImGui.Button("Add Components") then
                            CyberPsycho.Cheats.addComponents()
                        end

                        ImGui.PushItemWidth(229)
                        CyberPsycho.Cheats.itemToAdd = ImGui.InputText("##Item Code", CyberPsycho.Cheats.itemToAdd, 100)
                        ImGui.PushItemWidth(75)
                        ImGui.SameLine(241)
                        CyberPsycho.Cheats.itemAmount = ImGui.InputInt("##Item Amount", CyberPsycho.Cheats.itemAmount, 1, 10)
                        ImGui.SameLine(320)
                        if ImGui.Button("Add Items") then
                            CyberPsycho.Cheats.addItems()
                        end

                        CyberPsycho.Cheats.godMode, godModeChanged = ImGui.Checkbox("GodMode", CyberPsycho.Cheats.godMode)
                        if godModeChanged then
                            CyberPsycho.Cheats.updateGodMode()
                        end

                        ImGui.SameLine()
                        CyberPsycho.Cheats.infStamina, infStaminaChanged = ImGui.Checkbox("Inf Stamina", CyberPsycho.Cheats.infStamina)
                        if infStaminaChanged then
                            CyberPsycho.Cheats.updateInfStamina()
                        end

                        ImGui.SameLine()
                        CyberPsycho.Cheats.disablePolice, disablePoliceChanged = ImGui.Checkbox("Disable Police", CyberPsycho.Cheats.disablePolice)
                        if disablePoliceChanged then
                            CyberPsycho.Cheats.updateDisablePolice()
                        end

                        ImGui.SameLine()
                        CyberPsycho.Cheats.noFall, noFallChanged = ImGui.Checkbox("No Fall", CyberPsycho.Cheats.noFall)

                        CyberPsycho.Cheats.noClip, noClipChanged = ImGui.Checkbox("NoClip - Speed", CyberPsycho.Cheats.noClip)
                        if noClipChanged then
                            if CyberPsycho.Cheats.noClip and CyberPsycho.Time.superHot then
                                CyberPsycho.Time.superHot = not CyberPsycho.Time.superHot
                                CyberPsycho.Time.updateSuperHot()
                            end
                            CyberPsycho.Cheats.updateNoClip()
                        end
                        ImGui.SameLine()
                        ImGui.PushItemWidth(255)
                        CyberPsycho.Cheats.noClipSpeed = ImGui.SliderInt("##NoClip Speed", CyberPsycho.Cheats.noClipSpeed, 1, 20, "%dx")

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Time") then
                        ImGui.SetWindowSize(430, 150)
                        ImGui.Spacing()

                        ImGui.PushItemWidth(50)
                        CyberPsycho.Time.h, hChanged = ImGui.DragInt("##Hours", CyberPsycho.Time.h, 0.1, 0, 23, "H: %d")
                        ImGui.SameLine(62)
                        CyberPsycho.Time.m, mChanged = ImGui.DragInt("##Minutes", CyberPsycho.Time.m, 0.1, 0, 59, "M: %d")
                        ImGui.SameLine(116)
                        CyberPsycho.Time.s, sChanged = ImGui.DragInt("##Seconds", CyberPsycho.Time.s, 0.1, 0, 59, "S: %d")
                        ImGui.SameLine(170)
                        if ImGui.Button("Set Time") or hChanged or mChanged or sChanged then
                            CyberPsycho.Time.setTime()
                        end

                        CyberPsycho.Time.stopTime, stopTimeChanged = ImGui.Checkbox("Stop Time Cycle", CyberPsycho.Time.stopTime)
                        if stopTimeChanged then
                            CyberPsycho.Time.updateStopTimeValue()
                        end

                        CyberPsycho.Time.superHot, superHotChanged = ImGui.Checkbox("SuperHot Mode (Time Freeze)", CyberPsycho.Time.superHot)
                        if superHotChanged then
                            if CyberPsycho.Time.superHot and CyberPsycho.Cheats.noClip then
                                CyberPsycho.Cheats.noClip = not CyberPsycho.Cheats.noClip
                                CyberPsycho.Cheats.updateNoClip()
                            end
                            CyberPsycho.Time.updateSuperHot()
                        end

                        ImGui.PushItemWidth(250)
                        CyberPsycho.Time.timeMultiplier = ImGui.SliderInt("Time Multiplier", CyberPsycho.Time.timeMultiplier, 1, 100, "%dx")

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Vehicle") then
                        ImGui.SetWindowSize(430, 81)
                        ImGui.Spacing()

                        if ImGui.Button("Fix Vehicle", 115, 19) then
                            CyberPsycho.Vehicle.fixVehicle()
                        end
                        ImGui.SameLine()
                        CyberPsycho.Vehicle.autoFixVehicle = ImGui.Checkbox("Auto Fix Vehicle", CyberPsycho.Vehicle.autoFixVehicle)
                        ImGui.SameLine()
                        if ImGui.Button("Toggle Summon Mode", 148, 19) then
                            CyberPsycho.Vehicle.toggleSummonMode()
                        end

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Teleport") then
                        ImGui.SetWindowSize(430, 219)
                        ImGui.Spacing()

                        if ImGui.Button("TP to Quest", 202, 19) then
                            CyberPsycho.Teleport.tpToQuest()
                        end
                        ImGui.SameLine(214)
                        if ImGui.Button("TP to Waipoint (Coming Soon)", 202, 19) then
                            print("Not yet choom")
                        end

                        ImGui.Spacing()
                        ImGui.Text("Special")
                        ImGui.PushItemWidth(256)
                        CyberPsycho.Teleport.specialTpSelection = ImGui.Combo("##Special Teleport", CyberPsycho.Teleport.specialTpSelection, CyberPsycho.Teleport.specialTpNames, #CyberPsycho.Teleport.specialTpNames, #CyberPsycho.Teleport.specialTpNames)
                        ImGui.SameLine(268)
                        if ImGui.Button("Teleport") then
                            CyberPsycho.Teleport.specialTp()
                        end

                        ImGui.Text("Fast Travel Spots")
                        ImGui.PushItemWidth(154)
                        CyberPsycho.Teleport.fastTravelAreaSelection = ImGui.Combo("##Fast Travel Area", CyberPsycho.Teleport.fastTravelAreaSelection, CyberPsycho.Teleport.fastTravelAreaNames, #CyberPsycho.Teleport.fastTravelAreaNames, #CyberPsycho.Teleport.fastTravelAreaNames)
                        ImGui.SameLine(166)
                        ImGui.PushItemWidth(210)
                        CyberPsycho.Teleport.fastTravelDestinationSelection = ImGui.Combo("##Fast Travel Destination", CyberPsycho.Teleport.fastTravelDestinationSelection, CyberPsycho.Teleport.fastTravelDestinationNames[CyberPsycho.Teleport.fastTravelAreaSelection+1], #CyberPsycho.Teleport.fastTravelDestinationNames[CyberPsycho.Teleport.fastTravelAreaSelection+1], #CyberPsycho.Teleport.fastTravelDestinationNames[CyberPsycho.Teleport.fastTravelAreaSelection+1])
                        ImGui.SameLine(380)
                        if ImGui.Button(" Go ") then
                            CyberPsycho.Teleport.fastTravelTp()
                        end

                        ImGui.Spacing()
                        ImGui.Spacing()
                        ImGui.Text("Custom Warps")
                        ImGui.SameLine(166)
                        ImGui.PushItemWidth(210)
                        CyberPsycho.Teleport.newWarpName = ImGui.InputText("##New Warp Name", CyberPsycho.Teleport.newWarpName, 100)
                        ImGui.SameLine(380)
                        if ImGui.Button("Add##Warp", 36, 19) then
                            CyberPsycho.Teleport.addWarp(CyberPsycho)
                        end
                        if ImGui.Button("Remove##Warp") then
                            CyberPsycho.Teleport.removeWarp(CyberPsycho)
                        end
                        ImGui.SameLine(62)
                        ImGui.PushItemWidth(250)
                        CyberPsycho.Teleport.warpSelection = ImGui.Combo("##Custom Warp Selection", CyberPsycho.Teleport.warpSelection, CyberPsycho.Data.warpsNames, #CyberPsycho.Data.warpsNames)
                        ImGui.SameLine(316)
                        if ImGui.Button("Warp To", 100, 19) then
                            CyberPsycho.Teleport.tpToWarp(CyberPsycho)
                        end

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Player") then
                        ImGui.SetWindowSize(430, 131)
                        ImGui.Spacing()

                        if ImGui.Button("Undress", 133, 19) then
                            CyberPsycho.Player.undress()
                        end
                        ImGui.SameLine()
                        if ImGui.Button("Toggle Bra", 133, 19) then
                            CyberPsycho.Player.toggleBra()
                        end
                        ImGui.SameLine()
                        if ImGui.Button("Toggle Panties", 133, 19) then
                            CyberPsycho.Player.togglePanties()
                        end

                        ImGui.Spacing()
                        ImGui.Text("Custom Loadouts")
                        ImGui.SameLine(166)
                        ImGui.PushItemWidth(210)
                        CyberPsycho.Player.newLoadoutName = ImGui.InputText("##New Loadout Name", CyberPsycho.Player.newLoadoutName, 100)
                        ImGui.SameLine(380)
                        if ImGui.Button("Add##Loadout", 42, 19) then
                            CyberPsycho.Player.addLoadout(CyberPsycho)
                        end
                        if ImGui.Button("Remove##Loadout") then
                            CyberPsycho.Player.removeLoadout(CyberPsycho)
                        end
                        ImGui.SameLine(62)
                        ImGui.PushItemWidth(250)
                        CyberPsycho.Player.loadoutSelection = ImGui.Combo("##Custom Loadout Selection", CyberPsycho.Player.loadoutSelection, CyberPsycho.Data.loadoutNames, #CyberPsycho.Data.loadoutNames)
                        ImGui.SameLine(316)
                        if ImGui.Button("Load", 106, 19) then
                            CyberPsycho.Player.loadLoadout(CyberPsycho)
                        end

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Utils") then
                        ImGui.SetWindowSize(430, 104)
                        ImGui.Spacing()

                        if ImGui.Button("Toggle Quest Item (No Sell / Dismantle) for Equipped Items") then
                            CyberPsycho.Utilities.toggleQuestItems()
                        end

                        if ImGui.Button("Untrack Quest", 205, 19) then
                            CyberPsycho.Utilities.untrackQuest()
                        end

                        ImGui.SameLine(217)
                        if ImGui.Button("Stop Fall", 205, 19) then
                            CyberPsycho.Utilities.stopFall()
                        end

                        ImGui.EndTabItem()
                    end

                    if ImGui.BeginTabItem("Settings") then
                        ImGui.SetWindowSize(430, 81)
                        ImGui.Spacing()

                        CyberPsycho.Data.json.clickGUI, clickGUIChanged = ImGui.Checkbox("ClickGUI", CyberPsycho.Data.json.clickGUI)
                        if clickGUIChanged then
                            CyberPsycho.Data.Save()
                        end

                        ImGui.EndTabItem()
                    end

                    if Str8upUI.devMode then
                        if ImGui.BeginTabItem("Dev") then
                            ImGui.SetWindowSize(430, 81)
                            ImGui.Spacing()

                            if ImGui.Button("Run Dev Script", 415, 19) then
                                CyberPsycho.Dev.Run(CyberPsycho)
                            end

                            ImGui.EndTabItem()
                        end
                    end

                end
                ImGui.EndTabBar()
            end
            ImGui.End()
        end

    end)

    Str8upUI.Theme.RevertTheme()

    if listThemeApplied then
        ImGui.PopStyleColor(2)
    end

end

return Str8upUI