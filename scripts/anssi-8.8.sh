#!/bin/bash
check_MDS() {
    grep -qE '\b(mds=full,nomst|mds=nomst,full)\b' /proc/cmdline
}
source traitement_csv.sh
if check_MDS; then
    echo "Le MDS est activé" >&2
    ajouter_recommandation $1 8.8 "tout va bien" "true" $2
    exit 0
else
    echo "le MDS n'est pas activé" >&2
    ajouter_recommandation $1 8.8 "l'option n'est pas activée" "false" $2
    exit 1
fi