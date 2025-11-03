source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.ipv4.icmp_ignore_bogus_error_responses=1"; then
    print_green "La norme RFC 1122 est activée"
    ajouter_recommandation $1 12.12 "tout va bien" "true" $2
else
    print_red "La norme RFC 1122 n'est pas activée"
    ajouter_recommandation $1 12.12 "l'option n'est pas activée mais devrait l'être" "false" $2
fi