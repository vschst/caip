# caip
[MTA] CAIP - Chech another IP

#[RUS]
Ресурс проверяет строку на наличие совпадений вида IP:Port. 
Алгоритм поиска основан на перебирании последовательных комбинаций символов цифр из проверяемой строки.

#[Settings]

#[Export function]
Type: server

Syntax:
>table **checkAnotherIP**(string **theString**)

Arguments:
>**theString** - The string for check

Returns:
Return table with 2 keys `ErrorCode` and `Checked`. In the case of successful validation, `ErrorCode` is equal to 0. Result of the check
is written to the key `Checked`. If `Checked` equals *true*, then string contains matches IP:Port, *false* otherwise.
