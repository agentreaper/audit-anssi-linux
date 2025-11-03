source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.arp_filter=1"; then
    print_green "Le filtrage ARP est activé"
    ajouter_recommandation $1 12.6 "tout va bien" "true" $2
else
    print_red "Le filtrage ARP n'est pas activé"
    ajouter_recommandation $1 12.6 "l'option est désactivée mais devrait l'être" "false" $2
fi