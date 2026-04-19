# ============================================================
# create_ad_users.ps1 - Création en masse d'utilisateurs AD
# Auteur : Paulo ROSA - AIS O'Clock
# Description : Crée des utilisateurs AD depuis un tableau
# ============================================================

Import-Module ActiveDirectory

# Liste des utilisateurs à créer
$users = @(
    @{Prenom="Alice"; Nom="MARTIN"; Service="RH"},
    @{Prenom="Bob"; Nom="DUPONT"; Service="Informatique"},
    @{Prenom="Claire"; Nom="BERNARD"; Service="Direction"},
    @{Prenom="David"; Nom="THOMAS"; Service="Informatique"}
)

$OU = "OU=Utilisateurs,DC=oclock,DC=local"
$DefaultPassword = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force

foreach ($user in $users) {
    $SamAccount = ($user.Prenom.Substring(0,1) + $user.Nom).ToLower()
    $UPN = "$SamAccount@oclock.local"

    try {
        New-ADUser `
            -Name "$($user.Prenom) $($user.Nom)" `
            -GivenName $user.Prenom `
            -Surname $user.Nom `
            -SamAccountName $SamAccount `
            -UserPrincipalName $UPN `
            -Department $user.Service `
            -Path $OU `
            -AccountPassword $DefaultPassword `
            -Enabled $true `
            -PassThru

        Write-Host "[OK] Utilisateur cree : $SamAccount" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERREUR] $SamAccount : $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== Verification des utilisateurs crees ===" -ForegroundColor Cyan
Get-ADUser -Filter * -SearchBase $OU -Properties Department |
    Select-Object Name, SamAccountName, Department, Enabled |
    Format-Table -AutoSize