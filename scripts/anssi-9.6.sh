source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.randomize_va_space=2"; then
    print_green "L'ASLR est activé"
    ajouter_recommandation $1 9.6 "tout va bien" "true" $2
else
    print_red "L'ASLR est désactivé"
    ajouter_recommandation $1 9.6 "l'option est désactivée" "false" $2
fi