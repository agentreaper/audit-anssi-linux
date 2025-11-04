source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.rp_filter=1|net.ipv4.conf.default.rp_filter=1"; then
    print_green "La double vérification des paquets est activée"
    ajouter_recommandation $1 12.10 "tout va bien" "true" $2
else
    print_red "La double vérification des paquets n'est pas activée"
    ajouter_recommandation $1 12.10 "l'option n'est pas activée mais devrait l'être" "false" $2
fi