function fileExists(filename)
    local f=io.open(filename,"r") if (f~=nil) then io.close(f) return true else return false end
end
function getCWD(mod_name)
    if fileExists("bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "bin/x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "x64/plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("plugins/cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "plugins/cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("cyber_engine_tweaks/mods/"..mod_name.."/init.lua") then return "cyber_engine_tweaks/mods/"..mod_name.."/" elseif fileExists("mods/"..mod_name.."/init.lua") then return "mods/"..mod_name.."/" elseif  fileExists(mod_name.."/init.lua") then return mod_name.."/" elseif  fileExists("init.lua") then return "" end
end


CyberPsychoUI = {
    description = "CyberPsycho UI Component",
    rootPath = getCWD("CyberPsycho"),
    devMode = false,
    cursor = {
        submenu = "CyberPsycho",
        selected = "Player"
    },
    overlayOpen = false,
    x = nil,
    y = nil,
    pendingPopup = { alive = false },
    popupTimeout = 0,
    menu = {
        ["CyberPsycho"] = {
            type = "section",
            maxIndex = 1,
            ["Player Options"] = {
				index = 1,
				type = "section",
				maxIndex = 2,
				["GodMode"] = {
					index = 1,
					type = "toggle",
					var = "Player.godMode",
					callback = "Player.updateGodMode"
				},
				["Infinite Stamina"] = {
					index = 2,
					type = "toggle",
					var = "Player.infStamina",
					callback = "Player.updateInfStamina",
				}
			}
        }
    }
}

-- Hack: Multiple string subindexes with . like CyberPsycho["Cheats.noClip"], thanks NonameNonumber !
setmetatable(CyberPsychoUI.menu, {
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

CyberPsychoUI.Theme = require(CyberPsychoUI.rootPath .. "modules/theme")

function CyberPsychoUI.ListMenuInteractions(CyberPsycho, action)

    if not CyberPsycho.Data.clickGUI and CyberPsycho.drawWindow and not CyberPsychoUI.pendingPopup.alive and CyberPsychoUI.popupTimeout == 0 then
        item = CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu .. "." .. CyberPsychoUI.cursor.selected]
        submenu = CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu]
        if action == "select" then
            if submenu.type == "combo" then
                if submenu.itemsSubVar then
                    CyberPsycho[submenu.var] = (CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], CyberPsychoUI.cursor.selected) - 1) or 0
                else
                    CyberPsycho[submenu.var] = (CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items], CyberPsychoUI.cursor.selected) - 1) or 0
                end
                CyberPsychoUI.cursor.selected = CyberPsychoUI.cursor.submenu:sub(#CyberPsychoUI.cursor.submenu - CyberPsychoUI.cursor.submenu:reverse():find("%.")+2)
                CyberPsychoUI.cursor.submenu = CyberPsychoUI.cursor.submenu:sub(1, #CyberPsychoUI.cursor.submenu - CyberPsychoUI.cursor.submenu:reverse():find("%."))
            elseif item.type == "section" then
                CyberPsychoUI.cursor.submenu = CyberPsychoUI.cursor.submenu .. "." .. CyberPsychoUI.cursor.selected
                CyberPsychoUI.cursor.selected = CyberPsychoUI.GetNameFromIndex(CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu], 1)
            elseif item.type == "combo" then
                CyberPsychoUI.cursor.submenu = CyberPsychoUI.cursor.submenu .. "." .. CyberPsychoUI.cursor.selected
                if item.itemsSubVar then
                    CyberPsychoUI.cursor.selected = CyberPsycho[item.items][CyberPsycho[item.itemsSubVar] + tonumber(item.itemsSubVarMod)][CyberPsycho[item.var]+1] or ""
                else
                    CyberPsychoUI.cursor.selected = CyberPsycho[item.items][CyberPsycho[item.var]+1] or ""
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
                CyberPsychoUI.pendingPopup = {
                    alive = true,
                    type = "int",
                    name = CyberPsychoUI.cursor.selected,
                    var = item.var,
                    callback = item.callback,
                    min = item.min,
                    max = item.max
                }
            elseif item.type == "text" then
                CyberPsychoUI.pendingPopup = {
                    alive = true,
                    type = "text",
                    name = CyberPsychoUI.cursor.selected,
                    var = item.var
                }
            end
        elseif action == "back" then
            if CyberPsychoUI.cursor.submenu:find("%.") then
                CyberPsychoUI.cursor.selected = CyberPsychoUI.cursor.submenu:sub(#CyberPsychoUI.cursor.submenu - CyberPsychoUI.cursor.submenu:reverse():find("%.")+2)
                CyberPsychoUI.cursor.submenu = CyberPsychoUI.cursor.submenu:sub(1, #CyberPsychoUI.cursor.submenu - CyberPsychoUI.cursor.submenu:reverse():find("%."))
            else
                CyberPsycho.drawWindow = false
            end
        elseif action == "up" then
            if submenu.type == "section" then
                curIndex = item.index
                maxIndex = submenu.maxIndex
                if curIndex > 1 then
                    CyberPsychoUI.cursor.selected = CyberPsychoUI.GetNameFromIndex(submenu, curIndex - 1)
                else
                    CyberPsychoUI.cursor.selected = CyberPsychoUI.GetNameFromIndex(submenu, maxIndex)
                end
            elseif submenu.type == "combo" then
                if #CyberPsycho[submenu.items] ~= 0 then
                    if submenu.itemsSubVar then
                        curIndex = CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], CyberPsychoUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)]
                        if curIndex > 1 then
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][curIndex-1]
                        else
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][maxIndex]
                        end
                    else
                        curIndex = CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items], CyberPsychoUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items]
                        if curIndex > 1 then
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][curIndex-1]
                        else
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][maxIndex]
                        end
                    end
                end
            end
        elseif action == "down" then
            if submenu.type == "section" then
                curIndex = item.index
                maxIndex = submenu.maxIndex
                if curIndex < maxIndex then
                    CyberPsychoUI.cursor.selected = CyberPsychoUI.GetNameFromIndex(submenu, curIndex + 1)
                else
                    CyberPsychoUI.cursor.selected = CyberPsychoUI.GetNameFromIndex(submenu, 1)
                end
            elseif submenu.type == "combo" then
                if #CyberPsycho[submenu.items] ~= 0 then
                    if submenu.itemsSubVar then
                        curIndex = CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)], CyberPsychoUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)]
                        if curIndex < maxIndex then
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][curIndex+1]
                        else
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][CyberPsycho[submenu.itemsSubVar] + tonumber(submenu.itemsSubVarMod)][1]
                        end
                    else
                        curIndex = CyberPsychoUI.GetIndexFromName(CyberPsycho[submenu.items], CyberPsychoUI.cursor.selected)
                        maxIndex = #CyberPsycho[submenu.items]
                        if curIndex < maxIndex then
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][curIndex+1]
                        else
                            CyberPsychoUI.cursor.selected = CyberPsycho[submenu.items][1]
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


function CyberPsychoUI.ColoredText(text, color)

    ImGui.TextColored(color[1], color[2], color[3], color[4], text)

end


function CyberPsychoUI.DrawCursorRect(name)

    _, cursorY = ImGui.GetCursorScreenPos()
    windowX, _ = ImGui.GetWindowPos()
    windowW, _ = ImGui.GetWindowSize()
    _, textY = ImGui.CalcTextSize("I")
    ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.00, 0.94, 1.00, 0.26)
    ImGui.PushStyleColor(ImGuiCol.Border, 0.00, 0.00, 0.00, 0.00)
    ImGui.SetNextWindowPos(windowX + 1, cursorY - 1)
    ImGui.SetNextWindowSize(windowW - 2, textY + 5)
    -- if not CyberPsychoUI.overlayOpen and not CyberPsychoUI.pendingPopup.alive and CyberPsychoUI.popupTimeout == 0 then
    --     ImGui.SetNextWindowFocus()
    -- end
    ImGui.Begin(name .. ".Cursor", true, bit32.bor(ImGuiWindowFlags.NoTitleBar, ImGuiWindowFlags.NoMove, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.AlwaysAutoResize, ImGuiWindowFlags.NoResize))
    ImGui.End()
    ImGui.PopStyleColor(2)

end


function CyberPsychoUI.Section(name)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    CyberPsychoUI.ColoredText(" " .. name, color)
    xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize(">  ")
    ImGui.SameLine(xOffset)
    CyberPsychoUI.ColoredText(">", color)

end


function CyberPsychoUI.ComboItem(name)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    CyberPsychoUI.ColoredText(" " .. name, color)

end


function CyberPsychoUI.Toggle(name, status)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    CyberPsychoUI.ColoredText(" " .. name, color)
    if status == true then
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("ON  ")
        ImGui.SameLine(xOffset)
        CyberPsychoUI.ColoredText("ON", { 0.00, 1.00, 0.00, 1.00 })
    else
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("OFF  ")
        ImGui.SameLine(xOffset)
        CyberPsychoUI.ColoredText("OFF", { 1.00, 0.00, 0.00, 1.00 })
    end

end


function CyberPsychoUI.Int(name, value)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
        CyberPsychoUI.ColoredText(" " .. name, color)
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize("<" .. tostring(value) .. ">  ")
        ImGui.SameLine(xOffset)
        CyberPsychoUI.ColoredText("<" .. tostring(value) .. ">", color)
    else
        color = { 0.69, 0.69, 0.69, 1 }
        CyberPsychoUI.ColoredText(" " .. name, color)
        xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize(tostring(value) .. "  ")
        ImGui.SameLine(xOffset)
        CyberPsychoUI.ColoredText(tostring(value), color)
    end

end


function CyberPsychoUI.Combo(CyberPsycho, item)

    if CyberPsychoUI.cursor.selected == item[1] then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(item[1])
        CyberPsychoUI.ColoredText(" " .. item[1], color)  -- fix index higher than max
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
        CyberPsychoUI.ColoredText("<" .. value .. ">", color)
    else
        color = { 0.69, 0.69, 0.69, 1 }
        CyberPsychoUI.ColoredText(" " .. item[1], color)
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
        CyberPsychoUI.ColoredText(value, color)
    end

end


function CyberPsychoUI.Text(name, value)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    if #value > 11 then
        value = value:sub(1, 8) .. "..."
    end
    CyberPsychoUI.ColoredText(" " .. name, color)
    xOffset = ImGui.GetWindowWidth() - ImGui.CalcTextSize('"' .. value .. '"' .. "  ")
    ImGui.SameLine(xOffset)
    CyberPsychoUI.ColoredText('"' .. value .. '"', color)

end


function CyberPsychoUI.Button(name)

    if CyberPsychoUI.cursor.selected == name then
        color = { 0.00, 0.90, 1.00, 1 }
        CyberPsychoUI.DrawCursorRect(name)
    else
        color = { 0.69, 0.69, 0.69, 1 }
    end
    CyberPsychoUI.ColoredText(" " .. name, color)

end


function CyberPsychoUI.Spacing(name)

    if CyberPsychoUI.cursor.selected == name then
        CyberPsychoUI.DrawCursorRect(name)
    end
    color = { 0, 0, 0, 0 }
    CyberPsychoUI.ColoredText(" ", color)

end


function CyberPsychoUI.CheckIgnoreValue(name)

    local ignored = { "index", "type", "maxIndex", "var", "vallback", "min", "max" }
    for _, v in pairs(ignored) do
        if v == name then
            return true
        end
    end
    return false

end


function CyberPsychoUI.SortItems(input)

    local items = {}
    for item, content in pairs(input) do
        if not CyberPsychoUI.CheckIgnoreValue(item) then
            table.insert(items, {item, content})
        end
    end
    table.sort(items, function(left, right)
        return left[2].index < right[2].index
    end)
    return items

end


function CyberPsychoUI.GetNameFromIndex(submenu, index)

    for name, content in pairs(submenu) do
        if not CyberPsychoUI.CheckIgnoreValue(name) then
            if content.index == index then
                return name
            end
        end
    end
    return nil

end


function CyberPsychoUI.GetIndexFromName(submenu, name)

    if submenu.type == "section" then
        for index, item in pairs(submenu) do
            if not CyberPsychoUI.CheckIgnoreValue(name) then
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


function CyberPsychoUI.Draw(CyberPsycho)

    CyberPsychoUI.Theme.ApplyTheme()

    listThemeApplied = false
    if not CyberPsycho.Data.json.clickGUI then
        listThemeApplied = true
        ImGui.PushStyleColor(ImGuiCol.Border, 0.99, 0.93, 0.04, 0.69)
        ImGui.PushStyleColor(ImGuiCol.TitleBg, 0.99, 0.93, 0.04, 0.69)
    end

    if CyberPsychoUI.devMode and not CyberPsychoUI.menu["CyberPsycho"]["Developer"] then
        CyberPsychoUI.menu["CyberPsycho"].maxIndex = CyberPsychoUI.menu["CyberPsycho"].maxIndex + 1
        CyberPsychoUI.menu["CyberPsycho"]["Developer"] = {
            index = CyberPsychoUI.menu["CyberPsycho"].maxIndex,
            type = "section",
            maxIndex = 1,
            ["Run Dev Script"] = {
                index = 1,
                type = "button",
                objCallback = "Dev.Run"
            }
        }
    elseif not CyberPsychoUI.devMode and CyberPsychoUI.menu["CyberPsycho"]["Developer"] then
        CyberPsychoUI.menu["CyberPsycho"].maxIndex = CyberPsychoUI.menu["CyberPsycho"].maxIndex - 1
        CyberPsychoUI.menu["CyberPsycho"]["Developer"] = nil
    end

    -- Hack: catch errors in gui to ensure theme vars bleeding is avoided
    pcall(function()

        if CyberPsychoUI.pendingPopup.alive then
            ImGui.OpenPopup("Set Value")
            if ImGui.BeginPopupModal("Set Value", bit32.bor(ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.NoScrollWithMouse, ImGuiWindowFlags.NoCollapse)) then
                ImGui.SetWindowFontScale(1.0)
                screenX, screenY = GetDisplayResolution()
                ImGui.SetWindowSize(260, 76)
                ImGui.SetWindowPos((screenX-260)/2, (screenY-76)/2)
                xOffset = ( ImGui.GetWindowWidth() - ImGui.CalcTextSize(CyberPsychoUI.pendingPopup.name) ) / 2
                ImGui.SameLine(xOffset)
                ImGui.Text(CyberPsychoUI.pendingPopup.name)
                ImGui.Spacing()
                ImGui.PushItemWidth(244)
                ImGui.SetKeyboardFocusHere()
                if CyberPsychoUI.pendingPopup.type == "text" then
                    CyberPsycho[CyberPsychoUI.pendingPopup.var], popupConfirmed = ImGui.InputText("", CyberPsycho[CyberPsychoUI.pendingPopup.var], 100, ImGuiInputTextFlags.EnterReturnsTrue)
                elseif CyberPsychoUI.pendingPopup.type == "int" then
                    popupOutput, popupConfirmed = ImGui.InputText("", tostring(CyberPsycho[CyberPsychoUI.pendingPopup.var]), 100, bit32.bor(ImGuiInputTextFlags.EnterReturnsTrue, ImGuiInputTextFlags.CharsDecimal))
                    if popupOutput == "" then
                        popupOutput = CyberPsychoUI.pendingPopup.min
                    end
                    popupOutput = tonumber(popupOutput)
                    if popupOutput > CyberPsychoUI.pendingPopup.max then
                        popupOutput = CyberPsychoUI.pendingPopup.max
                    elseif popupOutput < CyberPsychoUI.pendingPopup.min then
                        popupOutput = CyberPsychoUI.pendingPopup.min
                    end
                    CyberPsycho[CyberPsychoUI.pendingPopup.var] = popupOutput
                end
                if popupConfirmed then
                    ImGui.CloseCurrentPopup()
                    CyberPsychoUI.pendingPopup.alive = false
                    CyberPsychoUI.popupTimeout = 0.2
                end
            end
            ImGui.EndPopup()
        end

        if not CyberPsycho.Data.json.clickGUI then
            title = CyberPsychoUI.cursor.submenu
            if title:find("%.") then
                title = title:gsub("%.", "/")
                title = title:gsub("CyberPsycho/", "")
            end
            if ImGui.Begin(title, bit32.bor(ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoScrollbar, ImGuiWindowFlags.NoScrollWithMouse, ImGuiWindowFlags.NoCollapse, ImGuiWindowFlags.AlwaysAutoResize)) then
                ImGui.SetWindowSize(10, 10)
                if CyberPsychoUI.x and CyberPsychoUI.y and not CyberPsychoUI.overlayOpen then
                    ImGui.SetWindowPos(CyberPsychoUI.x, CyberPsychoUI.y)
                end
                ImGui.SetWindowFontScale(1.2)
                ImGui.SetCursorPosY(12)
                ImGui.Text("                        ")  -- set minimum menu width
                if CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].type == "section" then
                    items = CyberPsychoUI.SortItems(CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu])
                    for _, item in pairs(items) do
                        if item[2].type == "section" then
                            CyberPsychoUI.Section(item[1])
                        elseif item[2].type == "combo" then
                            CyberPsychoUI.Combo(CyberPsycho, item)
                        elseif item[2].type == "toggle" then
                            CyberPsychoUI.Toggle(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "int" then
                            CyberPsychoUI.Int(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "text" then
                            CyberPsychoUI.Text(item[1], CyberPsycho[item[2].var])
                        elseif item[2].type == "button" then
                            CyberPsychoUI.Button(item[1])
                        elseif item[2].type == "spacing" then
                            CyberPsychoUI.Spacing(item[1])
                        end
                    end
                elseif CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].type == "combo" then
                    if CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].itemsSubVar then
                        items = CyberPsycho[CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].items][CyberPsycho[CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].itemsSubVar] + tonumber(CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].itemsSubVarMod)]
                    else
                        items = CyberPsycho[CyberPsychoUI.menu[CyberPsychoUI.cursor.submenu].items]
                    end
                    if #items == 0 then
                        color = { 0.69, 0.69, 0.69, 1 }
                        CyberPsychoUI.ColoredText(" There's nothing here..", color)
                    else
                        for _, name in pairs(items) do
                            CyberPsychoUI.ComboItem(name)
                        end
                    end
                end
                ImGui.Spacing()
                CyberPsychoUI.x, CyberPsychoUI.y = ImGui.GetWindowPos()
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

                    if CyberPsychoUI.devMode then
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

    CyberPsychoUI.Theme.RevertTheme()

    if listThemeApplied then
        ImGui.PopStyleColor(2)
    end

end

return CyberPsychoUI