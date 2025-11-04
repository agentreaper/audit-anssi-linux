source scripts/shortcut_functions.sh
source traitement_csv.sh
if [ $(find / -type f -perm /6000 -ls 2>/dev/null | wc -l) != 0 ]; then
    print_green "Aucun fichier avec un bit setuid ou setgid n'a été trouvé"
    ajouter_recommandation $1 56 "tout va bien" "true" $2
else
    print_red "Des fichiers avec un bit setuid ou setgid ont été trouvés"
    ajouter_recommandation $1 56 "Des fichiers avec un bit setuid ou setgid ont été trouvés" "false" $2
fi