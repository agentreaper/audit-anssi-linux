source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.route_localnet=0"; then
    print_green "Le routage local est désactivé"
    ajouter_recommandation $1 12.8 "tout va bien" "true" $2
else
    print_red "Le routage local n'est pas désactivé"
    ajouter_recommandation $1 12.8 "l'option est activée mais ne devrait pas l'être" "false" $2
fi