source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "fs.suid_dumpable=0"; then
    print_green "La protection contre les attaques par coredump est activée"
    ajouter_recommandation $1 14.1 "tout va bien" "true" $2
else
    print_red "La protection contre les attaques par coredump n'est pas activée"
    ajouter_recommandation $1 14.1 "l'option n'est pas activée mais devrait l'être" "false" $2
fi