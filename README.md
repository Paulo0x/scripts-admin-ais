# Scripts d'administration — formation AIS

Deux scripts réalisés pendant ma formation Administrateur d'Infrastructures Sécurisées (O'clock).

| Script | Rôle |
|---|---|
| `create_ad_users.ps1` | Crée des comptes Active Directory en masse dans une unité d'organisation, à partir d'une liste d'utilisateurs |
| `audit_system.sh` | Audit rapide d'un serveur Linux : CPU, mémoire, disque et services Docker, avec journalisation |

## Utilisation

- PowerShell, sur un contrôleur de domaine avec le module ActiveDirectory : `.\create_ad_users.ps1`
- Bash, avec les droits root : `sudo ./audit_system.sh`

## Pistes d'amélioration

- Lire les utilisateurs depuis un fichier CSV
- Demander le mot de passe initial au lancement au lieu de l'écrire dans le script
