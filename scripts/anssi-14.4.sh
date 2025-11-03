source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "fs.protected_hardlinks=1"; then
    print_green "La création des liens durs est protégée"
    ajouter_recommandation $1 14.4 "tout va bien" "true" $2
else
    print_red "La création des liens durs n'est pas protégée"
    ajouter_recommandation $1 14.4 "l'option n'est pas activée mais devrait l'être" "false" $2
fi