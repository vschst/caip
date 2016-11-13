CAIPLoad = true
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


function checkAnotherIP(theString)
	local returnTable = {ErrorCode = 0, Checked = false}
	
	if (CAIPLoad == true) then
		local stringToCheck = string.match(string.gsub(theString, '#%x%x%x%x%x%x', ''), "^%s*(.*)%s*$")

		local StringDigitsWordsData = {Digits = {Words = {}, Counter = 0}, NotDigits = {Words = {}, Counter = 0}}

		for digitsWord in string.gmatch(stringToCheck, "%d+") do
			table.insert(StringDigitsWordsData.Digits.Words, digitsWord)

			if (StringDigitsWordsData.Digits.Counter > 0) then
				local notDigitsWord = string.match(stringToCheck, StringDigitsWordsData.Digits.Words[StringDigitsWordsData.Digits.Counter] .. "([^%d]+)" .. digitsWord)

				if (notDigitsWord ~= nil) then
					table.insert(StringDigitsWordsData.NotDigits.Words, notDigitsWord)

					StringDigitsWordsData.NotDigits.Counter = StringDigitsWordsData.NotDigits.Counter + 1
				end
			end

			StringDigitsWordsData.Digits.Counter = StringDigitsWordsData.Digits.Counter + 1
		end

		if (StringDigitsWordsData.Digits.Counter >= 5) then
			if (StringDigitsWordsData.Digits.Counter == (StringDigitsWordsData.NotDigits.Counter + 1)) then
				for i = 1, (StringDigitsWordsData.Digits.Counter - 4) do
					local checkAnotherIPInSubstringStatus, checkAnotherIPInSubstringResult = pcall(checkAnotherIPInSubstring,
						{
							[1] = StringDigitsWordsData.NotDigits.Words[i],
							[2] = StringDigitsWordsData.NotDigits.Words[(i + 1)],
							[3] = StringDigitsWordsData.NotDigits.Words[(i + 2)],
							[4] = StringDigitsWordsData.NotDigits.Words[(i + 3)]
						},
						{
							[1] = tonumber(StringDigitsWordsData.Digits.Words[i]),
							[2] = tonumber(StringDigitsWordsData.Digits.Words[(i + 1)]),
							[3] = tonumber(StringDigitsWordsData.Digits.Words[(i + 2)]),
							[4] = tonumber(StringDigitsWordsData.Digits.Words[(i + 3)]),
							[5] = tonumber(StringDigitsWordsData.Digits.Words[(i + 4)])
						})

					if ((checkAnotherIPInSubstringStatus == true) and (checkAnotherIPInSubstringResult == true)) then
						outputServerLog("ANOTHER IP CHECKED! STRING: " .. theString)

						returnTable.Checked = true

						break
					end
				end
			else
				returnTable.ErrorCode = (-2)
			end
		end
	else
		returnTable.ErrorCode = (-1)
	end

	return returnTable
end


function checkAnotherIPInSubstring(NotDgitsWordsData, DigitsWordsData)
	for j = 1, 4 do
		if (string.len(NotDgitsWordsData[j]) > CAIPSettings.NotDgitsWordsMaxLength) then
			error(-1)
		end
	end

	if ((DigitsWordsData[1] < CAIPSettings.FirstIPNumberMinRange) or (DigitsWordsData[1] > CAIPSettings.FirstIPNumberMaxRange)) then
		error(-2)
	elseif ((DigitsWordsData[2] < CAIPSettings.SecondIPNumberMinRange) or (DigitsWordsData[2] > CAIPSettings.SecondIPNumberMaxRange)) then
		error(-3)
	elseif ((DigitsWordsData[3] < CAIPSettings.ThirdIPNumberMinRange) or (DigitsWordsData[3] > CAIPSettings.ThirdIPNumberMaxRange)) then
		error(-4)
	elseif ((DigitsWordsData[4] < CAIPSettings.FourthIPNumberMinRange) or (DigitsWordsData[4] > CAIPSettings.FourthIPNumberMaxRange)) then
		error(-5)
	elseif ((DigitsWordsData[5] < CAIPSettings.PortMinRange) or (DigitsWordsData[5] > CAIPSettings.PortMaxRange)) then
		error(-6)
	end

	local anotherIP = false

	for j = 1, 4 do
		if (CAIPSettings.ServerIP[j] ~= DigitsWordsData[j]) then
			anotherIP = true

			break
		end
	end

	if ((anotherIP == false) and (DigitsWordsData[5] == CAIPSettings.ServerPort)) then
		return false
	else
		return true
	end
end


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
		error((-1) * (caipSettingsAmount + 1))
	end

	--Server Port
	CAIPSettings.ServerPort = tonumber(CAIPSettingsLoad.ServerPort)
		
	--Not digits words maximum length
	CAIPSettings.NotDgitsWordsMaxLength = tonumber(CAIPSettingsLoad.NotDgitsWordsMaxLength)
		
	if (CAIPSettings.NotDgitsWordsMaxLength <= 0) then
		error((-2) * (caipSettingsAmount + 1))
	end
		
	--First IP number settings
	--First IP number minimum range
	CAIPSettings.FirstIPNumberMinRange = tonumber(CAIPSettingsLoad.FirstIPNumberMinRange)
		
	if (CAIPSettings.FirstIPNumberMinRange < 0) then
		error((-3) * (caipSettingsAmount + 1))
	end

	--First IP number maximum range
	CAIPSettings.FirstIPNumberMaxRange = tonumber(CAIPSettingsLoad.FirstIPNumberMaxRange)

	if (CAIPSettings.FirstIPNumberMaxRange < 0) then
		error((-4) * (caipSettingsAmount + 1))
	end

	--First IP number validating ranges
	if (CAIPSettings.FirstIPNumberMaxRange < CAIPSettings.FirstIPNumberMinRange) then
		error((-5) * (caipSettingsAmount + 1))
	end

	--Second IP number settings
	--Second IP number minimum range
	CAIPSettings.SecondIPNumberMinRange = tonumber(CAIPSettingsLoad.SecondIPNumberMinRange)

	if (CAIPSettings.SecondIPNumberMinRange < 0) then
		error((-6) * (caipSettingsAmount + 1))
	end

	--Second IP number maximum range
	CAIPSettings.SecondIPNumberMaxRange = tonumber(CAIPSettingsLoad.SecondIPNumberMaxRange)

	if (CAIPSettings.SecondIPNumberMaxRange < 0) then
		error((-7) * (caipSettingsAmount + 1))
	end

	--Second IP number validating ranges
	if (CAIPSettings.SecondIPNumberMaxRange < CAIPSettings.SecondIPNumberMinRange) then
		error((-8) * (caipSettingsAmount + 1))
	end

	--Third IP number settings
	--Third IP number minimum range
	CAIPSettings.ThirdIPNumberMinRange = tonumber(CAIPSettingsLoad.ThirdIPNumberMinRange)

	if (CAIPSettings.ThirdIPNumberMinRange < 0) then
		error((-9) * (caipSettingsAmount + 1))
	end

	--Third IP number maximum range
	CAIPSettings.ThirdIPNumberMaxRange = tonumber(CAIPSettingsLoad.ThirdIPNumberMaxRange)

	if (CAIPSettings.ThirdIPNumberMaxRange < 0) then
		error((-10) * (caipSettingsAmount + 1))
	end

	--Third IP number validating ranges
	if (CAIPSettings.ThirdIPNumberMaxRange < CAIPSettings.ThirdIPNumberMinRange) then
		error((-11) * (caipSettingsAmount + 1))
	end

	--Fourth IP number settings
	--Fourth IP number minimum range
	CAIPSettings.FourthIPNumberMinRange = tonumber(CAIPSettingsLoad.FourthIPNumberMinRange)

	if (CAIPSettings.FourthIPNumberMinRange < 0) then
		error((-12) * (caipSettingsAmount + 1))
	end

	--Fourth IP number maximum range
	CAIPSettings.FourthIPNumberMaxRange = tonumber(CAIPSettingsLoad.FourthIPNumberMaxRange)

	if (CAIPSettings.FourthIPNumberMaxRange < 0) then
		error((-13) * (caipSettingsAmount + 1))
	end

	--Fourth IP number validating ranges
	if (CAIPSettings.FourthIPNumberMaxRange < CAIPSettings.FourthIPNumberMinRange) then
		error((-14) * (caipSettingsAmount + 1))
	end

	--Port settings
	--Port minimum range
	CAIPSettings.PortMinRange = tonumber(CAIPSettingsLoad.PortMinRange)
		
	if (CAIPSettings.PortMinRange <= 0) then
		error((-15) * (caipSettingsAmount + 1))
	end
		
	--Port maximum range
	CAIPSettings.PortMaxRange = tonumber(CAIPSettingsLoad.PortMaxRange)
		
	if (CAIPSettings.PortMaxRange <= 0) then
		error((-16) * (caipSettingsAmount + 1))
	end

	--Port validating ranges
	if (CAIPSettings.PortMaxRange < CAIPSettings.PortMinRange) then
		error((-17) * (caipSettingsAmount + 1))
	end
end