source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.accept_local=0"; then
    print_green "L'acceptation des connexions locales est désactivée"
    ajouter_recommandation $1 12.3 "tout va bien" "true" $2
else
    print_red "L'acceptation des connexions locales n'est pas désactivée"
    ajouter_recommandation $1 12.3 "l'option est activée mais ne devrait pas l'être" "false" $2
fi