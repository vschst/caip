# caip
[MTA] CAIP - Check another IP

#[Description][RUS]
Ресурс проверяет строку на наличие совпадений вида IP:Port. 
Алгоритм поиска основан на перебирании последовательных комбинаций символов цифр из проверяемой строки.

#[Description][ENG]
This resource checks the string for matches of the view IP:Port.
A search algorithm based on sequential shuffling of combinations of numbers of the check string.

#[Settings]

#[Export functions]
* ##checkAnotherIP
  * ###Type
  Server-only function

  * ###Syntax:
  >table **checkAnotherIP**(string **theString**)

  * ###Arguments:
  >**theString** - The string for check

  * ###Returns:
  Return table with 2 keys `ErrorCode` and `Checked`. In the case of successful validation, `ErrorCode` is equal to 0. Result of the check
  is written to the key `Checked`. If `Checked` equals *true*, then string contains matches IP:Port, *false* otherwise.
