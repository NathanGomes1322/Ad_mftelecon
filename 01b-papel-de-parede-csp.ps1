$ErrorActionPreference = 'Stop'

if (-not [Environment]::Is64BitProcess -and (Test-Path 'C:\Windows\Sysnative\WindowsPowerShell\v1.0\powershell.exe')) {
    $u = 'https://raw.githubusercontent.com/NathanGomes1322/Ad_mftelecon/main/01b-papel-de-parede-csp.ps1'
    & 'C:\Windows\Sysnative\WindowsPowerShell\v1.0\powershell.exe' -NoProfile -Command "irm $u | iex"
    exit
}

$dir = 'C:\Program Files\MFTelecom'
$img = "$dir\wallpaper-pais.png"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
Invoke-WebRequest 'https://raw.githubusercontent.com/NathanGomes1322/Ad_mftelecon/main/wallpaper.png' -OutFile $img -UseBasicParsing

$k = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP'
New-Item -Path $k -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImagePath   -Value $img -PropertyType String -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImageUrl    -Value $img -PropertyType String -Force | Out-Null
New-ItemProperty -Path $k -Name DesktopImageStatus -Value 1    -PropertyType DWord  -Force | Out-Null

Remove-Item 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "OK - $env:COMPUTERNAME - 64bit:$([Environment]::Is64BitProcess)"
