source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.dmesg_restrict=1"; then
    print_green "le buffer dmesg est restreint"
    ajouter_recommandation $1 9.1 "tout va bien" "true" $2
else
    print_red "le buffer dmesg n'est pas restreint"
    ajouter_recommandation $1 9.1 "l'option n'est pas activée" "false" $2
fi