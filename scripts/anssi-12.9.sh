source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.drop_gratuitous_arp=1"; then
    print_green "Le filtrage des ARP inutiles est activé"
    ajouter_recommandation $1 12.9 "tout va bien" "true" $2
else
    print_red "Le filtrage des ARP inutiles n'est pas activé"
    ajouter_recommandation $1 12.9 "l'option est activée mais ne devrait pas l'être" "false" $2
fi