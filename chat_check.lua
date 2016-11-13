addEventHandler("onPlayerChat", getRootElement(),
    function(message)
        local checkAnotherIPStatus = checkAnotherIP(message)

        if (checkAnotherIPStatus.ErrorCode == 0) then
            if (checkAnotherIPStatus.Checked == true) then
                outputChatBox("ip:port found!")
            else
                outputChatBox("ip:port not found!")
            end
        end
    end
)