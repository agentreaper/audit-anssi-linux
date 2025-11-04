source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "fs.protected_symlinks=1"; then
    print_green "La creation de liens symboliques est protégée"
    ajouter_recommandation $1 14.3 "tout va bien" "true" $2
else
    print_red "La creation de liens symboliques n'est pas protégée"
    ajouter_recommandation $1 14.3 "l'option n'est pas activée mais devrait l'être" "false" $2
fi