source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.perf_cpu_time_max_percent=1|kernel.perf_event_max_sample_rate=1"; then
    print_green "les adresses noyaux sont bien cachées"
    ajouter_recommandation $1 9.4 "tout va bien" "true" $2
else
    print_red "les adresses noyaux ne sont pas bien cachées"
    ajouter_recommandation $1 9.4 "l'option n'est pas activée" "false" $2
fi