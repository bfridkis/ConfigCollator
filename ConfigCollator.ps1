If (Test-Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt) {
    Remove-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Force
    New-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt
}
Get-ChildItem C:\ProgramData\SolarWinds\NCM\Config-Archive | ForEach-Object {
    $NewestConfigDir = $_ | Get-ChildItem | Sort-Object -Descending LastWriteTime | Select-Object -First 1
    $NewestRunningConfig = $NewestConfigDir | Get-ChildItem | Where { $_.Name -like "*running*" } | Select-Object -First 1
    Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value "***** START OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****"
    Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value (Get-Content $NewestRunningConfig.FullName)
    Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value "***** END OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****`n"
}