$ErrorActionPreference = 'Stop'
$dir = 'C:\Program Files\MFTelecom'
$img = "$dir\wallpaper.png"

New-Item -ItemType Directory -Path $dir -Force | Out-Null
Invoke-WebRequest 'https://raw.githubusercontent.com/NathanGomes1322/Ad_mftelecon/main/wallpaper.png' -OutFile $img -UseBasicParsing

$task = 'MFT-Wallpaper'
$ps = "`$c='[DllImport(\"user32.dll\")]public static extern bool SystemParametersInfo(int u,int i,string p,int f);';Add-Type -MemberDefinition `$c -Name W -Namespace N;Set-ItemProperty 'HKCU:\Control Panel\Desktop' Wallpaper '$img';Set-ItemProperty 'HKCU:\Control Panel\Desktop' WallpaperStyle '10';[N.W]::SystemParametersInfo(20,0,'$img',3)"
$enc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($ps))

schtasks /create /tn $task /tr "powershell.exe -NoProfile -WindowStyle Hidden -EncodedCommand $enc" /sc once /st 00:00 /ru INTERACTIVE /f | Out-Null
schtasks /run /tn $task | Out-Null
Start-Sleep -Seconds 5
schtasks /delete /tn $task /f | Out-Null

Write-Output "OK - $env:COMPUTERNAME - aplicado na sessao ativa"
