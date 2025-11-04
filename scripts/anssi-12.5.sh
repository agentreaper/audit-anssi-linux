source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.accept_source_route=0|net.ipv4.conf.default.accept_source_route=0"; then
    print_green "L'acceptation des paquets avec des routes source est désactivée"
    ajouter_recommandation $1 12.5 "tout va bien" "true" $2
else
    print_red "L'acceptation des paquets avec des routes source n'est pas désactivée"
    ajouter_recommandation $1 12.5 "l'option est activée mais ne devrait pas l'être" "false" $2
fi