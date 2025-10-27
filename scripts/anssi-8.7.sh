#!/bin/bash
check_spectre_v2() {
    grep -qE '\b(spectre_v2=on)\b' /proc/cmdline
}
source traitement_csv.sh
if check_spectre_v2; then
    echo "Les contremesures spectre V2 sont activées" >&2
    ajouter_recommandation $1 8.7 "tout va bien" "true" $2
    exit 0
else
    echo "les contremesures spectre V2 ne sont pas activées" >&2
    ajouter_recommandation $1 8.7 "l'option n'est pas activée" "false" $2
    exit 1
fi