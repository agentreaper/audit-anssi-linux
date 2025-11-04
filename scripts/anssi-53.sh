source scripts/shortcut_functions.sh
source traitement_csv.sh
if [ $(find / -nouser -o -nogroup 2>/dev/null | wc -l) != 0 ]; then
    print_green "Tous les fichiers et dossiers ont un propriétaire valide"
    ajouter_recommandation $1 53 "tout va bien" "true" $2
else
    print_red "Il y a des fichiers ou dossiers sans propriétaire valide"
    ajouter_recommandation $1 53 "Des fichiers ou dossiers sont sans utilisateur ou groupe connu" "false" $2
fi