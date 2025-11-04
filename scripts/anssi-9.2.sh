source scripts/shortcut_functions.sh
source traitement_csv.sh
if sysctl_check "kernel.kptr_restrict=2"; then
    print_green "les adresses noyaux sont bien cachées"
    ajouter_recommandation $1 9.2 "tout va bien" "true" $2
else
    print_red "les adresses noyaux ne sont pas bien cachées"
    ajouter_recommandation $1 9.2 "l'option n'est pas activée" "false" $2
fi