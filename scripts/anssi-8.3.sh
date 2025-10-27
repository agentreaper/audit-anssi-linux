#!/bin/bash
check_PTI() {
    grep -qE '\b(pti=on)\b' /proc/cmdline
}
source traitement_csv.sh
if check_PTI; then
    echo "l'isolation des pages de tables est activée" >&2
    ajouter_recommandation $1 8.3 "tout va bien" "true" $2
    exit 0
else
    echo "l'isolation des pages de tables n'est pas activée" >&2
    ajouter_recommandation $1 8.3 "l'option n'est pas activée" "false" $2
    exit 1
fi