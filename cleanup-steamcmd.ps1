# Set your SteamCMD install directory here
$installDir = $args[0]

# List of file patterns to remove
$filePatterns = @(
    "appmanifest_*.acf",
    "*.tmp",
    "*.patch",
    "*.log",
    "*.old"
)

Write-Host "Cleaning SteamCMD leftovers in: $installDir"

foreach ($pattern in $filePatterns) {
    $files = Get-ChildItem -Path $installDir -Recurse -Filter $pattern -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        try {
            Remove-Item $file.FullName -Force
            Write-Host "Deleted: $($file.FullName)"
        } catch {
            Write-Host "Failed to delete: $($file.FullName)"
        }
    }
}

Write-Host "Cleanup complete."