#!/bin/bash
check_slub_debug() {
    grep -qE '\b(slub_debug=FZP|slub_debug=FPZ|slub_debug=PZF|slub_debug=PFZ|slub_debug=PZF|slub_debug=ZPF|slub_debug=PFP)\b' /proc/cmdline
}
source traitement_csv.sh
if check_slub_debug; then
    echo "Le renforcement de la mémoire dynamique est activé" >&2
    ajouter_recommandation $1 8.5 "tout va bien" "true" $2
    exit 0
else
    echo "le renforcement de la mémoire dynamique n'est pas appliqué" >&2
    ajouter_recommandation $1 8.5 "l'option n'est pas activée" "false" $2
    exit 1
fi