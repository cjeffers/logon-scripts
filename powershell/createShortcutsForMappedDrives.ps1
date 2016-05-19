# Author: Cameron Jeffers
# Email: cjeffers@henselphelps.com
# For every mapped drive, W: --> \\hp100a\Common,
# create a shortcut to \\hp100a\Common on the Desktop with
# the name "Common (W)"

$wshShell = New-Object -ComObject WScript.Shell
$mappedDrives = Get-WmiObject Win32_MappedLogicalDisk
foreach ($mappedDrive in $mappedDrives) {
    $remoteName = $mappedDrive.ProviderName
    $remoteBaseName = $remoteName.Split("\")[-1]  # get the last part of the path
    $driveLetter = $mappedDrive.Name[0]  # get first letter, e.g. "W" from "W:"
    $shortcutName = "$remoteBaseName ($driveLetter)"
    $shortcut = $wshShell.CreateShortcut("$HOME\Desktop\$shortcutName.lnk")
    $shortcut.TargetPath = $remoteName
    $shortcut.Save()
    Write-Output "Creating $shortcutName --> $remoteName"
}