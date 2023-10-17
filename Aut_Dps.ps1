# Verifica se o script está sendo executado como administrador
$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

# Se não estiver sendo executado como administrador, solicita privilégios de administrador e reinicia o script
if (-not $isAdmin) {
    Start-Process powershell.exe -ArgumentList "Start-Process PowerShell -Verb RunAs -ArgumentList '-File $($MyInvocation.MyCommand.Path)'" -Verb RunAs
    exit
}

# Desativa a privacidade do IPv6 
netsh interface ipv6 set privacy state=disabled

# Habilita o Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Saída para indicar a conclusão
Write-Host "A privacidade do IPv6 foi desativada e o Remote Desktop foi habilitado com sucesso."