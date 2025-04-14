# List disks
Write-Host "Available disks:"
Get-Disk | Format-Table -AutoSize

# Prompt for device number
$usbNum = Read-Host "Enter the disk number of the USB drive (e.g., 1)"

# Check if disk exists
$disk = Get-Disk -Number $usbNum -ErrorAction SilentlyContinue
if (-not $disk) {
    Write-Host "Disk $usbNum not found!"
    exit 1
}

Write-Host "WARNING: This will erase all data on disk $usbNum. Continue? (y/n)"
$confirm = Read-Host
if ($confirm -ne "y") {
    Write-Host "Aborted."
    exit 1
}

# Unmount all volumes on the disk
$vols = Get-Volume | Where-Object { $_.ObjectId -like "*PhysicalDrive$usbNum*" }
foreach ($v in $vols) {
    try { Dismount-Volume -DriveLetter $v.DriveLetter -Force } catch {}
}

# Create diskpart script
$diskpartScript = @"
select disk $usbNum
clean
convert mbr
create partition primary size=512
format fs=fat32 label=BOOT quick
active
assign letter=Z
create partition primary
format fs=ntfs label=persistence quick
assign letter=Y
exit
"@

$diskpartScript | Set-Content -Path "$env:TEMP\diskpart_script.txt"
diskpart /s "$env:TEMP\diskpart_script.txt"

# Wait for the system to recognize new partitions
Start-Sleep -Seconds 2

# Create persistence.conf
$persistencePath = "Y:\persistence.conf"
"/ union" | Out-File -Encoding ASCII $persistencePath

# Eject drives
Remove-PSDrive -Name Y -ErrorAction SilentlyContinue
Remove-PSDrive -Name Z -ErrorAction SilentlyContinue

Write-Host "Done."
exit