param (
    [string]$filter,
    [string][Alias("c")]$count = 30
)
$lines = Get-Content ~\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

if ($filter) {
    $lines = $lines | Select-String -Pattern $filter 
}

$lines = $lines | Select-Object -Last $count


Write-Output $lines
