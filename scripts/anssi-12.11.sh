source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.core.bpf_jit_harden=2"; then
    print_green "Le chargement de modules kernel est désactivé"
    ajouter_recommandation $1 12.11 "tout va bien" "true" $2
else
    print_red "Le chargement des modules kernel n'est pas désactivé"
    ajouter_recommandation $1 12.11 "l'option n'est pas activé mais devrait l'être" "false" $2
fi