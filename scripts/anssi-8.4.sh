#!/bin/bash
check_slab_nomerge() {
    grep -qE '\b(slab_nomerge=yes)\b' /proc/cmdline
}
source traitement_csv.sh
source scripts/shortcut_functions.sh
if check_slab_nomerge; then
    print_green "l'isolation des pages de tables est activée" >&2
    ajouter_recommandation $1 8.4 "tout va bien" "true" $2
    exit 0
else
    print_red "l'isolation des pages de tables n'est pas activée" >&2
    ajouter_recommandation $1 8.4 "l'option n'est pas activée" "false" $2
    exit 1
fi