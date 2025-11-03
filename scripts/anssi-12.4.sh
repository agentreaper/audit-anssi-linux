source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.conf.all.accept_redirects=0|net.ipv4.conf.default.accept_redirects=0|net.ipv4.conf.all.secure_redirects=0|net.ipv4.conf.default.secure_redirects=0|net.ipv4.conf.all.shared_media=0|net.ipv4.conf.default.shared_media=0"; then
    print_green "Le traitement de paquets ICMP redirect est désactivé"
    ajouter_recommandation $1 12.4 "tout va bien" "true" $2
else
    print_red "Le traitement de paquets ICMP redirect n'est pas désactivé"
    ajouter_recommandation $1 12.4 "l'option n'est pas activée mais devrait l'être" "false" $2
fi