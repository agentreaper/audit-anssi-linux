source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv6.conf.default.disable_ipv6=1|net.ipv6.conf.all.disable_ipv6=1"; then
    print_green "Le plan IPv6 est désactivé"
    ajouter_recommandation $1 13 "tout va bien" "true" $2
else
    print_red "Le plan IPv6 n'est pas désactivé"
    ajouter_recommandation $1 13 "l'option n'est pas activée mais devrait l'être" "false" $2
fi