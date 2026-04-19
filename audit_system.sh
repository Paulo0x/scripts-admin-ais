#!/bin/bash
# ============================================================
# audit_system.sh - Audit système automatique
# Auteur : Paulo ROSA - AIS O'Clock
# Description : Vérifie CPU, RAM, disque et services Docker
# ============================================================

DATE=$(date '+%Y-%m-%d %H:%M:%S')
HOSTNAME=$(hostname)
LOG="/var/log/audit_system.log"

echo "========================================"
echo "  AUDIT SYSTÈME - $HOSTNAME"
echo "  $DATE"
echo "========================================"

echo ""
echo "--- CPU ---"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Utilisation CPU : ${CPU_USAGE}%"

echo ""
echo "--- MÉMOIRE ---"
free -h | grep -E "Mem|Swap"

echo ""
echo "--- DISQUE ---"
df -h | grep -v tmpfs

echo ""
echo "--- SERVICES DOCKER ---"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "--- RÉSEAU ---"
ip -4 addr show ens18 | grep inet

echo ""
echo "========================================"
echo "  Audit terminé — $(date '+%H:%M:%S')"
echo "========================================"
