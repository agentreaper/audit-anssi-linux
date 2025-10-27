#!/bin/bash
check_spec_store_bypass() {
    grep -qE '\b(spec_store_bypass=seccomp)\b' /proc/cmdline
}
source traitement_csv.sh
if check_spec_store_bypass; then
    echo "Les contremesures spectre V4 sont activées" >&2
    ajouter_recommandation $1 8.6 "tout va bien" "true" $2
    exit 0
else
    echo "les contremesures spectre V4 ne sont pas activées" >&2
    ajouter_recommandation $1 8.6 "l'option n'est pas activée" "false" $2
    exit 1
fi