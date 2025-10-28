#!/bin/bash
check_PTI() {
    grep -qE '\b(pti=on)\b' /proc/cmdline
}
source traitement_csv.sh
source scripts/shortcut_functions.sh
if check_PTI; then
    print_green "l'isolation des pages de tables est activée" >&2
    ajouter_recommandation $1 8.3 "tout va bien" "true" $2
    exit 0
else
    print_red "l'isolation des pages de tables n'est pas activée" >&2
    ajouter_recommandation $1 8.3 "l'option n'est pas activée" "false" $2
    exit 1
fi