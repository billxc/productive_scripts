param (
    [string]$filter,
    [string][Alias("c")]$count = 30
)
$lines = Get-Content ~\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

if ($filter) {
    $lines = $lines | Select-String -Pattern $filter 
}

$lines = $lines | Select-Object -Last $count

$i = 0
$lines | ForEach-Object { Write-Host -NoNewline "${i}`t";  Write-Output $_ ;  $i = $i + 1 }

Write-Host "Please input the index of the command to re-run:"
$index = Read-Host

$cmd = $lines[$index]
if ($index -and $cmd) {
    Write-Output $cmd
    Invoke-Expression $cmd
}
else {
    Write-Output "Please input correct index"
}

