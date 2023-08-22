If (Test-Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt) {
    Remove-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Force
    New-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt
}
Get-ChildItem C:\ProgramData\SolarWinds\NCM\Config-Archive | ForEach-Object {
    If (Test-Path $_.FullName -PathType Container) {
        $NewestConfigDir = $_ | Get-ChildItem | Sort-Object -Descending LastWriteTime | Select-Object -First 1
        $NewestRunningConfig = $NewestConfigDir | Get-ChildItem | Where { $_.Name -like "*running*" } | Select-Object -First 1
        Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value "***** START OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****"
        Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value (Get-Content $NewestRunningConfig.FullName)
        Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs.txt -Value "***** END OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****`n"
    }
}

If (Test-Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt) {
    Remove-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt -Force
    New-Item C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt
}
Get-ChildItem C:\ProgramData\SolarWinds\NCM\Config-Archive | ForEach-Object {
    If (Test-Path $_.FullName -PathType Container) { 
        $NewestConfigDir = $_ | Get-ChildItem | Sort-Object -Descending LastWriteTime | Select-Object -First 1
        $NewestRunningConfig = $NewestConfigDir | Get-ChildItem | Where { $_.Name -like "*running*" } | Select-Object -First 1
        Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt -Value "***** START OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****"
        Get-Content $NewestRunningConfig.FullName | ForEach-Object {
            Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt -Value "$($_) --- $($NewestRunningConfig.Name.Split("-")[0])"
        }
        Add-Content -Path C:\ProgramData\SolarWinds\NCM\Config-Archive\CollatedRunningSwitchConfigs-wSwitchNameOnEachLine.txt -Value "***** END OF $($NewestRunningConfig.Name.Split("-")[0]) CONFIG *****`n"
    }
}