# I think I did a good write-up of ForEach-Object Cmdlet (and also the 'foreach' keyword) here:
# https://github.com/yantex0/AGFTAS/blob/main/PowerShell/PowerShell%20Oddities.md#foreach-vs-foreach-object

$arrayOfThings = @("a","b","c")
$arrayOfThings | ForEach-Object { Write-Output $_ }a
