# Set your SteamCMD install directory here
$logFile = $args[0]

# run client and wait for output
cmd /c start /wait srcds_console.exe -console -condebug -conclearlog `
    -game reactivedrop -noassert +sv_lan 1 +exec test

# move console logfile
cat reactivedrop/console.log
mv -Force reactivedrop/console.log $logFile

# check for errors
$pattern = "Shutdown function ShutdownMixerControls() not in list!!!"
if (-not (Select-String -Path $logFile -Pattern "$pattern")) {
    Write-Error "Shutdown line missing in $logFile"
    exit 1
}