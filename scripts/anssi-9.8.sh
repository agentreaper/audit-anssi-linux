source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.unprivileged_bpf_disabled=1"; then
    print_green "Le BPF est restreint"
    ajouter_recommandation $1 9.8 "tout va bien" "true" $2
else
    print_red "Le BPF n'est pas restreint"
    ajouter_recommandation $1 9.8 "l'option n'est pas activée" "false" $2
fi