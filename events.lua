addEvent("onAnotherIPInChat", true)

addEventHandler("onPlayerChat", getRootElement(),
    function(message)
        local playerName = getPlayerName(source)

        if (playerName ~= false) then
            local CheckStatus = {
                Name = checkAnotherIP(playerName),

                Message = checkAnotherIP(message),

                NameMessage = checkAnotherIP(playerName .. " " .. message)
            }

            if ((CheckStatus.Name.ErrorCode == 0) and (CheckStatus.Name.Checked == true)) then
                triggerEvent("onAnotherIPInChat", source, CheckStatus.Name.IP, CheckStatus.Name.Port)

                outputServerLog("ANOTHER IP CHECKED! PLAYER NAME: " .. playerName)

                cancelEvent()
            elseif ((CheckStatus.Message.ErrorCode == 0) and (CheckStatus.Message.Checked == true)) then
                triggerEvent("onAnotherIPInChat", source, CheckStatus.Message.IP, CheckStatus.Message.Port)

                outputServerLog("ANOTHER IP CHECKED! CHAT MESSAGE: " .. message)

                cancelEvent()
            elseif ((CheckStatus.NameMessage.ErrorCode == 0) and (CheckStatus.NameMessage.Checked == true)) then
                triggerEvent("onAnotherIPInChat", source, CheckStatus.NameMessage.IP, CheckStatus.NameMessage.Port)

                outputServerLog("ANOTHER IP CHECKED! PLAYER NAME: " .. playerName .. " CHAT MESSAGE: " .. message)

                cancelEvent()
            end
        end
    end
)