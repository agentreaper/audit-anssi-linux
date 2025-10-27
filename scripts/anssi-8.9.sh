#!/bin/bash
check_mce() {
    grep -qE '\b(mce=0)\b' /proc/cmdline
}
source traitement_csv.sh
if check_mce; then
    echo "Le MCE est correctement configuré" >&2
    ajouter_recommandation $1 8.9 "tout va bien" "true" $2
    exit 0
else
    echo "le MCE est mal configuré" >&2
    ajouter_recommandation $1 8.9 "l'option est activée mais ne devrait pas" "false" $2
    exit 1
fi