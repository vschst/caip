function checkAnotherIP(Strings)
	local returnTable = {ErrorCode = 0, Checked = false}
	
	if (CAIPLoad == true) then
		for i, theString in ipairs(Strings) do
			local status, result = pcall(checkAnotherIPInString, theString)
			
			if (status == true) then
				if (result == true) then
					returnTable.Checked = true
					
					break
				end
			else
				returnTable.ErrorCode = 1 + result.code
				
				break
			end
		end
	else
		returnTable.ErrorCode = 1
	end

	return returnTable
end