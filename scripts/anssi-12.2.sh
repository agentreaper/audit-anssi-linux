source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.ip_forward=0"; then
    print_green "Le routage IP entre les interfaces est désactivé"
    ajouter_recommandation $1 12.2 "tout va bien" "true" $2
else
    print_red "Le routage IP entre les interfaces n'est pas désactivé"
    ajouter_recommandation $1 12.2 "l'option n'est pas activée mais devrait l'être" "false" $2
fi