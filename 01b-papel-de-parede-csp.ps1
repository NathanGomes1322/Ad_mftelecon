$ErrorActionPreference = 'Stop'
$dir = 'C:\Program Files\MFTelecom'
$img = "$dir\wallpaper.png"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
Invoke-WebRequest 'https://raw.githubusercontent.com/NathanGomes1322/Ad_mftelecon/main/wallpaper.png' -OutFile $img -UseBasicParsing

$k = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP'
New-Item -Path $k -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImagePath   -Value $img -PropertyType String -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImageUrl    -Value $img -PropertyType String -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImageStatus -Value 1    -PropertyType DWord  -Force | Out-Null

Write-Output "OK - $env:COMPUTERNAME - reiniciar para aplicar"
