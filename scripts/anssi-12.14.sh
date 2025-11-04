source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.tcp_syncookies=1"; then
    print_green "La protection contre les attaques SYN est activée"
    ajouter_recommandation $1 12.14 "tout va bien" "true" $2
else
    print_red "La protection contre les attaques SYN n'est pas activée"
    ajouter_recommandation $1 12.14 "l'option n'est pas activée mais devrait l'être" "false" $2
fi