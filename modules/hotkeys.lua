
CyberPsychoHotkeys = {
    description = "CyberPsycho Hotkeys Component"
}


function CyberPsychoHotkeys.SetupHotkeys(CyberPsycho)

    registerForEvent('onInit', function()
        ListenerAction = GetSingleton('gameinputScriptListenerAction')

        Observe('PlayerPuppet', 'OnAction', function(self, action)

            actionName = Game.NameToString(ListenerAction:GetName(action))
            actionType = ListenerAction:GetType(action).value
            actionValue = ListenerAction:GetValue(action)

            -- List menu controls
            elseif actionName == 'Keyboard_0' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.drawWindow = not CyberPsycho.drawWindow
                end
            elseif actionName == 'up_button' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "up")
                end
            elseif actionName == 'down_button' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "down")
                end
            elseif actionName == 'left_button' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "left")
                end
            elseif actionName == 'right_button' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "right")
                end
            elseif actionName == 'UI_Apply' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "select")
                end
            elseif actionName == 'Sprint' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "back")
                end
            end

        end)
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_GUI", "Toggle GUI", function()
        CyberPsycho.drawWindow = not CyberPsycho.drawWindow
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Select", "List Menu Select", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "select")
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Back", "List Menu Back", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "back")
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Up", "List Menu Up", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "up")
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Down", "List Menu Down", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "down")
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Left", "List Menu Left", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "left")
    end)

    registerHotkey("CyberPsycho_Menu_List_Menu_Right", "List Menu Right", function()
        CyberPsycho.UI.ListMenuInteractions(CyberPsycho, "right")
    end)

end

return CyberPsychoHotkeys