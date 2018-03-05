function checkAnotherIPInString(theString)
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

				if (checkAnotherIPInSubstringStatus == true) then 
					if (checkAnotherIPInSubstringResult == true) then
						outputServerLog("ANOTHER IP CHECKED! STRING: " .. theString)
					
						return true
					end
				else
					error({code=(1+checkAnotherIPInSubstringResult.code)})
				end
			end
		else
			error({code=1})
		end
	end
	
	return false
end

function checkAnotherIPInSubstring(NotDgitsWordsData, DigitsWordsData)
	for j = 1, 4 do
		if (string.len(NotDgitsWordsData[j]) > CAIPSettings.NotDgitsWordsMaxLength) then
			error({code=1})
		end
	end

	if ((DigitsWordsData[1] < CAIPSettings.FirstIPNumberMinRange) or (DigitsWordsData[1] > CAIPSettings.FirstIPNumberMaxRange)) then
		error({code=2})
	elseif ((DigitsWordsData[2] < CAIPSettings.SecondIPNumberMinRange) or (DigitsWordsData[2] > CAIPSettings.SecondIPNumberMaxRange)) then
		error({code=2})
	elseif ((DigitsWordsData[3] < CAIPSettings.ThirdIPNumberMinRange) or (DigitsWordsData[3] > CAIPSettings.ThirdIPNumberMaxRange)) then
		error({code=4})
	elseif ((DigitsWordsData[4] < CAIPSettings.FourthIPNumberMinRange) or (DigitsWordsData[4] > CAIPSettings.FourthIPNumberMaxRange)) then
		error({code=5})
	elseif ((DigitsWordsData[5] < CAIPSettings.PortMinRange) or (DigitsWordsData[5] > CAIPSettings.PortMaxRange)) then
		error({code=6})
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