#!/bin/bash
check_mce() {
    grep -qE '\b(page_alloc.shuffle=1)\b' /proc/cmdline
}
source traitement_csv.sh
if check_slub_debug; then
    echo "Le Page Allocator Randomization est correctement configuré" >&2
    ajouter_recommandation $1 8.10 "tout va bien" "true" $2
    exit 0
else
    echo "Le Page Allocator Randomization est mal configuré" >&2
    ajouter_recommandation $1 8.10 "l'option n'est pas activée" "false" $2
    exit 1
fi