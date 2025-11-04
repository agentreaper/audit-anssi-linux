source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.yama.ptrace_scope=1|kernel.yama.ptrace_scope=2|kernel.yama.ptrace_scope=3"; then
    print_green "Yama ptrace scope est correctement configuré"
    ajouter_recommandation $1 11 "tout va bien" "true" $2
else
    print_red "Yama ptrace scope n'est pas correctement configuré"
    ajouter_recommandation $1 11 "l'option n'est pas activée mais devrait l'être" "false" $2
fi