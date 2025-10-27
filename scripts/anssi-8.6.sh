#!/bin/bash
check_slub_debug() {
    grep -qE '\b(spectre_v2=on)\b' /proc/cmdline
}
source traitement_csv.sh
if check_slub_debug; then
    echo "Les contremesures spectre V2 sont activées" >&2
    ajouter_recommandation $1 8.6 "tout va bien" "true" $2
    exit 0
else
    echo "les contremesures spectre V2 ne sont pas activées" >&2
    ajouter_recommandation $1 8.6 "l'option n'est pas activée" "false" $2
    exit 1
fi