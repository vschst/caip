CAIPLoad = false
CAIPSettings = {}

addEventHandler("onResourceStart", getRootElement(),
	function(startedResource)
		if (startedResource == getThisResource()) then
			local loadCAIPSettingsStatus, loadCAIPSettingsResult  = pcall(loadCAIPSettings)

			if (loadCAIPSettingsStatus == true) then
				CAIPLoad = true
				
				outputServerLog("[CAIP] Resource was successfully loaded!")
			else
				outputServerLog("[CAIP] Failed to load settings! Error code: " .. loadCAIPSettingsResult)
			end
		end
	end
)

function loadCAIPSettings()
	local CAIPSettingsLoad = {
		ServerIP = get("ServerIP"),
		
		ServerPort = get("ServerPort"),
		
		NotDgitsWordsMaxLength = get("NotDgitsWordsMaxLength"),

		FirstIPNumberMinRange = get("FirstIPNumberMinRange"),

		FirstIPNumberMaxRange = get("FirstIPNumberMaxRange"),

		SecondIPNumberMinRange = get("SecondIPNumberMinRange"),

		SecondIPNumberMaxRange = get("SecondIPNumberMaxRange"),

		ThirdIPNumberMinRange = get("ThirdIPNumberMinRange"),

		ThirdIPNumberMaxRange = get("ThirdIPNumberMaxRange"),

		FourthIPNumberMinRange = get("FourthIPNumberMinRange"),

		FourthIPNumberMaxRange = get("FourthIPNumberMaxRange"),

		PortMinRange = get("PortMinRange"),

		PortMaxRange = get("PortMaxRange")
	}
	
	local caipSettingsAmount = 0
	
	for caipslKey, caipslValue in pairs(CAIPSettingsLoad) do
		caipSettingsAmount = caipSettingsAmount + 1
	
		if (caipslValue == false) then
			error((-1) * caipSettingsAmount)
		end
	end

	--Server IP
	CAIPSettings.ServerIP = {}

	for ipNumber in string.gmatch(CAIPSettingsLoad.ServerIP, "%d+") do
		table.insert(CAIPSettings.ServerIP, tonumber(ipNumber))
	end

	if (#CAIPSettings.ServerIP ~= 4) then
		error((-1) - caipSettingsAmount)
	end

	--Server Port
	CAIPSettings.ServerPort = tonumber(CAIPSettingsLoad.ServerPort)
		
	--Not digits words maximum length
	CAIPSettings.NotDgitsWordsMaxLength = tonumber(CAIPSettingsLoad.NotDgitsWordsMaxLength)
		
	if (CAIPSettings.NotDgitsWordsMaxLength <= 0) then
		error((-2) - caipSettingsAmount)
	end
		
	--First IP number settings
	--First IP number minimum range
	CAIPSettings.FirstIPNumberMinRange = tonumber(CAIPSettingsLoad.FirstIPNumberMinRange)
		
	if ((CAIPSettings.FirstIPNumberMinRange < 0) or (CAIPSettings.FirstIPNumberMinRange > 255)) then
		error((-3) - caipSettingsAmount)
	end

	--First IP number maximum range
	CAIPSettings.FirstIPNumberMaxRange = tonumber(CAIPSettingsLoad.FirstIPNumberMaxRange)

	if ((CAIPSettings.FirstIPNumberMaxRange < 0) or (CAIPSettings.FirstIPNumberMaxRange > 255)) then
		error((-4) - caipSettingsAmount)
	end

	--First IP number validating ranges
	if (CAIPSettings.FirstIPNumberMaxRange < CAIPSettings.FirstIPNumberMinRange) then
		error((-5) - caipSettingsAmount)
	end

	--Second IP number settings
	--Second IP number minimum range
	CAIPSettings.SecondIPNumberMinRange = tonumber(CAIPSettingsLoad.SecondIPNumberMinRange)

	if ((CAIPSettings.SecondIPNumberMinRange < 0) or (CAIPSettings.SecondIPNumberMinRange > 255)) then
		error((-6) - caipSettingsAmount)
	end

	--Second IP number maximum range
	CAIPSettings.SecondIPNumberMaxRange = tonumber(CAIPSettingsLoad.SecondIPNumberMaxRange)

	if ((CAIPSettings.SecondIPNumberMaxRange < 0) or (CAIPSettings.SecondIPNumberMaxRange > 255)) then
		error((-7) - caipSettingsAmount)
	end

	--Second IP number validating ranges
	if (CAIPSettings.SecondIPNumberMaxRange < CAIPSettings.SecondIPNumberMinRange) then
		error((-8) - caipSettingsAmount)
	end

	--Third IP number settings
	--Third IP number minimum range
	CAIPSettings.ThirdIPNumberMinRange = tonumber(CAIPSettingsLoad.ThirdIPNumberMinRange)

	if ((CAIPSettings.ThirdIPNumberMinRange < 0) or (CAIPSettings.ThirdIPNumberMinRange > 255)) then
		error((-9) - caipSettingsAmount)
	end

	--Third IP number maximum range
	CAIPSettings.ThirdIPNumberMaxRange = tonumber(CAIPSettingsLoad.ThirdIPNumberMaxRange)

	if ((CAIPSettings.ThirdIPNumberMaxRange < 0) or (CAIPSettings.ThirdIPNumberMaxRange > 255)) then
		error((-10) - caipSettingsAmount)
	end

	--Third IP number validating ranges
	if (CAIPSettings.ThirdIPNumberMaxRange < CAIPSettings.ThirdIPNumberMinRange) then
		error((-11) - caipSettingsAmount)
	end

	--Fourth IP number settings
	--Fourth IP number minimum range
	CAIPSettings.FourthIPNumberMinRange = tonumber(CAIPSettingsLoad.FourthIPNumberMinRange)

	if ((CAIPSettings.FourthIPNumberMinRange < 0) or (CAIPSettings.FourthIPNumberMinRange > 255)) then
		error((-12) - caipSettingsAmount)
	end

	--Fourth IP number maximum range
	CAIPSettings.FourthIPNumberMaxRange = tonumber(CAIPSettingsLoad.FourthIPNumberMaxRange)

	if ((CAIPSettings.FourthIPNumberMaxRange < 0) or (CAIPSettings.FourthIPNumberMaxRange > 255)) then
		error((-13) - caipSettingsAmount)
	end

	--Fourth IP number validating ranges
	if (CAIPSettings.FourthIPNumberMaxRange < CAIPSettings.FourthIPNumberMinRange) then
		error((-14) - caipSettingsAmount)
	end

	--Port settings
	--Port minimum range
	CAIPSettings.PortMinRange = tonumber(CAIPSettingsLoad.PortMinRange)
		
	if (CAIPSettings.PortMinRange <= 0) then
		error((-15) - caipSettingsAmount)
	end
		
	--Port maximum range
	CAIPSettings.PortMaxRange = tonumber(CAIPSettingsLoad.PortMaxRange)
		
	if (CAIPSettings.PortMaxRange <= 0) then
		error((-16) - caipSettingsAmount)
	end

	--Port validating ranges
	if (CAIPSettings.PortMaxRange < CAIPSettings.PortMinRange) then
		error((-17) - caipSettingsAmount)
	end
end