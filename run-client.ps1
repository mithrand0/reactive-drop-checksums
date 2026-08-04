# Set your SteamCMD install directory here
$logFile = $args[0]

# run client and wait for output
cmd /c start /wait reactivedrop.exe -textmode -condebug -conclearlog +exec test

# move console logfile
cat reactivedrop/console.log
mv -Force reactivedrop/console.log $logFile