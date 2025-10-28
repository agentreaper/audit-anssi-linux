#!/bin/bash
check_MDS() {
    grep -qE '\b(mds=full,nomst|mds=nomst,full)\b' /proc/cmdline
}
source traitement_csv.sh
source scripts/shortcut_functions.sh
if check_MDS; then
    print_green "Le MDS est activé" >&2
    ajouter_recommandation $1 8.8 "tout va bien" "true" $2
    exit 0
else
    print_red "le MDS n'est pas activé" >&2
    ajouter_recommandation $1 8.8 "l'option n'est pas activée" "false" $2
    exit 1
fi