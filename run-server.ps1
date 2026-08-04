# Set your SteamCMD install directory here
$logFile = $args[0]

# add shutdown hook
$pattern = "shutting down server"
echo "$pattern; quit" > reactivedrop/cfg/shutdown.cfg

# run client and wait for output
cmd /c start /wait srcds_console.exe -console -condebug -conclearlog `
    -game reactivedrop -noassert +sv_lan 1 +exec test +exec shutdown

# move console logfile
mv -Force reactivedrop/console.log $logFile
Get-Content $logFile -Tail 50

# check for errors
if (-not (Select-String -Path $logFile -SimpleMatch $pattern)) {
    Write-Error "Shutdown line missing in $logFile"
    exit 1
}
