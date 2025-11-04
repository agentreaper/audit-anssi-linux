source scripts/shortcut_functions.sh
source traitement_csv.sh
if [ "$(sudo aa-status --json | jq -r 'if (.profiles | to_entries | all(.value == "enforce")) then "1" else "0" end')" == "1" ]; then
    print_green "Tous les profils AppArmor sont en mode enforce"
    ajouter_recommandation $1 45 "tout va bien" "true" $2
else
    print_red "Les profils AppArmor ne sont pas tous en mode enforce"
    ajouter_recommandation $1 45 "les permissions du dossier sont mal configurées" "false" $2
fi