source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.sysrq=0"; then
    print_green "Les combinaisons de touches magiques sont désactivées"
    ajouter_recommandation $1 9.7 "tout va bien" "true" $2
else
    print_red "Les combinaisons de touches magiques sont activées"
    ajouter_recommandation $1 9.7 "l'option est activée mais ne devrait pas l'être" "false" $2
fi