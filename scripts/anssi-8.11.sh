#!/bin/bash
check_rng_core() {
    grep -qE '\b(rng_core.default_quality=500)\b' /proc/cmdline
}
source traitement_csv.sh
source scripts/shortcut_functions.sh
if check_rng_core; then
    print_green "Le HWRNG est correctement configuré" >&2
    ajouter_recommandation $1 8.11 "tout va bien" "true" $2
    exit 0
else
    print_red "Le HWRNG est mal configurée" >&2
    ajouter_recommandation $1 8.11 "l'option n'est pas activée" "false" $2
    exit 1
fi