source scripts/shortcut_functions.sh
source traitement_csv.sh
if stat --format '%a' /boot == 700; then
    print_green "Le dossier /boot a les permissions correctes"
    ajouter_recommandation $1 29 "tout va bien" "true" $2
else
    print_red "Le dossier /boot n'a pas les permissions correctes"
    ajouter_recommandation $1 29 "les permissions du dossier sont mal configurées" "false" $2
fi