#!/bin/bash
check_page_alloc_shuffle() {
    grep -qE '\b(page_alloc.shuffle=1)\b' /proc/cmdline
}
source traitement_csv.sh
source scripts/shortcut_functions.sh
if check_page_alloc_shuffle; then
    print_green "Le Page Allocator Randomization est correctement configuré" >&2
    ajouter_recommandation $1 8.10 "tout va bien" "true" $2
    exit 0
else
    print_red "Le Page Allocator Randomization est mal configuré" >&2
    ajouter_recommandation $1 8.10 "l'option n'est pas activée" "false" $2
    exit 1
fi