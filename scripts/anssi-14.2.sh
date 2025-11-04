source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "fs.protected_fifos=2|fs.protected_regular=2"; then
    print_green "L'ouverture non souhaitée des fichiers FIFO est activée"
    ajouter_recommandation $1 14.2 "tout va bien" "true" $2
else
    print_red "L'ouverture non souhaitée des fichiers FIFO n'est pas activée"
    ajouter_recommandation $1 14.2 "l'option n'est pas activée mais devrait l'être" "false" $2
fi