source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.panic_on_oops=1"; then
    print_green "Le kernel panic on oops est activé"
    ajouter_recommandation $1 9.9 "tout va bien" "true" $2
else
    print_red "Le BPF n'est pas restreint"
    ajouter_recommandation $1 9.9 "l'option n'est pas activé mais devrait l'être" "false" $2
fi