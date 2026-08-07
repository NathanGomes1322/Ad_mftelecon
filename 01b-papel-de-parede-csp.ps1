$ErrorActionPreference = 'Stop'
$dir = 'C:\Program Files\MFTelecom'
$img = "$dir\wallpaper-pais.png"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
Invoke-WebRequest 'https://raw.githubusercontent.com/NathanGomes1322/Ad_mftelecon/main/wallpaper.png' -OutFile $img -UseBasicParsing

$base = [Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine','Registry64')
$k = $base.CreateSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP')
$k.SetValue('DesktopImagePath',   $img, 'String')
$k.SetValue('DesktopImageUrl',    $img, 'String')
$k.SetValue('DesktopImageStatus', 1,    'DWord')
$k.Close()

$lixo = $base.OpenSubKey('SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion',$true)
if ($lixo) { $lixo.DeleteSubKeyTree('PersonalizationCSP',$false); $lixo.Close() }
$base.Close()

Write-Output "OK - $env:COMPUTERNAME - 64bit:$([Environment]::Is64BitProcess) - logoff para aplicar"
