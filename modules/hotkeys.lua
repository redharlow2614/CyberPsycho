
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

            -- NoClip movement
            if actionName == 'Forward' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.forward = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.forward = false
                end
            elseif actionName == 'Back' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.backward = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.backward = false
                end
            elseif actionName == 'Left' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.left = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.left = false
                end
            elseif actionName == 'Right' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.right = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.right = false
                end
            elseif actionName == 'Jump' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.up = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.up = false
                end
            elseif actionName == 'ToggleSprint' then
                if actionType == 'BUTTON_PRESSED' then
                    CyberPsycho.Cheats.noClipControls.down = true
                elseif actionType == 'BUTTON_RELEASED' then
                    CyberPsycho.Cheats.noClipControls.down = false
                end

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

    registerHotkey("CyberPsycho_Menu_Toggle_Infinite_Stamina", "Toggle Infinite Stamina", function()
        CyberPsycho.Cheats.infStamina = not CyberPsycho.Cheats.infStamina
        CyberPsycho.Cheats.updateInfStamina()
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_Disable_Police", "Toggle Disable Police", function()
        CyberPsycho.Cheats.disablePolice = not CyberPsycho.Cheats.disablePolice
        CyberPsycho.Cheats.updateDisablePolice()
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_NoClip", "Toggle Noclip", function()
        CyberPsycho.Cheats.noClip = not CyberPsycho.Cheats.noClip
        if CyberPsycho.Cheats.noClip and CyberPsycho.Time.superHot then
            CyberPsycho.Time.superHot = not CyberPsycho.Time.superHot
            CyberPsycho.Time.updateSuperHot()
        end
        CyberPsycho.Cheats.updateNoClip()
    end)

    registerHotkey("CyberPsycho_Menu_NoClip_Speed_Up", "Noclip Speed Up", function()
        if CyberPsycho.Cheats.noClipSpeed < 20 then
            CyberPsycho.Cheats.noClipSpeed = CyberPsycho.Cheats.noClipSpeed + 1
        end
    end)

    registerHotkey("CyberPsycho_Menu_NoClip_Speed_Down", "Noclip Speed Down", function()
        if CyberPsycho.Cheats.noClipSpeed > 1 then
            CyberPsycho.Cheats.noClipSpeed = CyberPsycho.Cheats.noClipSpeed - 1
        end
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_Stop_Time", "Toggle Stop Time", function()
        CyberPsycho.Time.stopTime = not CyberPsycho.Time.stopTime
        CyberPsycho.Time.updateStopTimeValue()
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_SuperHot_Mode", "Toggle SuperHot Mode", function()
        CyberPsycho.Time.superHot = not CyberPsycho.Time.superHot
        if CyberPsycho.Time.superHot and CyberPsycho.Cheats.noClip then
            CyberPsycho.Cheats.noClip = not CyberPsycho.Cheats.noClip
            CyberPsycho.Cheats.updateNoClip()
        end
        CyberPsycho.Time.updateSuperHot()
    end)

    registerHotkey("CyberPsycho_Menu_Fix_Vehicle", "Fix Vehicle", function()
        CyberPsycho.Vehicle.fixVehicle()
    end)

    registerHotkey("CyberPsycho_Menu_TP_to_Quest", "TP to Quest", function()
        CyberPsycho.Teleport.tpToQuest()
    end)

    registerHotkey("CyberPsycho_Menu_Toggle_Quest_Items", "Toggle Quest Items", function()
        CyberPsycho.Utilities.toggleQuestItems()
    end)

    registerHotkey("CyberPsycho_Menu_Untrack_Quest", "Untrack Quest", function()
        CyberPsycho.Utilities.untrackQuest()
    end)

    registerHotkey("CyberPsycho_Menu_Stop_Fall", "Stop Fall", function()
        CyberPsycho.Utilities.stopFall()
    end)

end

return CyberPsychoHotkeys