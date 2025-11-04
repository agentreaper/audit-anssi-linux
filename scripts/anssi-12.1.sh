source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "net.core.bpf_jit_harden=2"; then
    print_green "Le JIT noyau est limité"
    ajouter_recommandation $1 12.1 "tout va bien" "true" $2
else
    print_red "Le JIT noyau n'est pas limité"
    ajouter_recommandation $1 12.1 "l'option n'est pas activée mais devrait l'être" "false" $2
fi