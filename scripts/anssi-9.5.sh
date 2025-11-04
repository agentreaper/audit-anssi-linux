source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.perf_event_paranoid=2"; then
    print_green "Le kernel profiling est désactivé"
    ajouter_recommandation $1 9.5 "tout va bien" "true" $2
else
    print_red "le kernel profiling est activé"
    ajouter_recommandation $1 9.5 "l'option est activée mais ne devrait pas " "false" $2
fi