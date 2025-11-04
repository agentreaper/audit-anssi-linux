source scripts/shortcut_functions.sh
source traitement_csv.sh
if grep -qE "TMOUT=180" /etc/profile; then
    print_green "Le délai d'inactivité est correctement configuré"
    ajouter_recommandation $1 32 "tout va bien" "true" $2
else
    print_red "Le délai d'inactivité n'est pas correctement configuré"
    ajouter_recommandation $1 32 "le délai d'inactivité est mal configuré" "false" $2
fi