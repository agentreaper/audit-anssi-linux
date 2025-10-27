#!/bin/bash
check_IOMMU() {
    grep -qE '\b(intel_iommu=on|amd_iommu=force_isolation|iommu=pt)\b' /proc/cmdline
}
source traitement_csv.sh
if check_IOMMU; then
    echo "IOMMU est activé" >&2
    ajouter_recommandation $1 7 "tout va bien" "true" $2
    exit 0
else
    echo "IOMMU n'est pas activé" >&2
    ajouter_recommandation $1 7 "l'option n'est pas activée" "false" $2
    exit 1
fi
# Pour obtenir le code de sortie :
# ./scripts/anssi-7.sh > /dev/null 2>&1; echo $?