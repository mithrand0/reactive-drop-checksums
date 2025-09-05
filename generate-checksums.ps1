$outputFile = "checksums.txt"
$algorithm = "SHA1"
$currentDirectory = $args[0]
Clear-Content $outputFile -ErrorAction SilentlyContinue
New-Item -ItemType File -Path $outputFile -Force | Out-Null
Get-ChildItem -File -Recurse | ForEach-Object {
    $hash = Get-FileHash -Algorithm $algorithm -Path $_.FullName
    $relativePath = $_.FullName.Substring($currentDirectory.Path.Length + 1)
    "$($hash.Hash)  $relativePath" | Out-File -FilePath $outputFile -Append
}
