source scripts/shortcut_functions.sh
source traitement_csv.sh
if [ $(find / \( -path /proc -o -path /run -o -path /sys -o -path /dev -o -path /tmp -o -path /var/tmp \) -prune -o -type d \( -perm 0002 -a \! -perm -1000 \) -print 2>/dev/null | wc -l) != 0 ]; then
    print_green "Aucun répertoire world-writable sans sticky bit n'a été trouvé"
    ajouter_recommandation $1 54 "tout va bien" "true" $2
else
    print_red "Des répertoires world-writable sans sticky bit ont été trouvés"
    ajouter_recommandation $1 54 "Des répertoires world-writable sans sticky bit ont été trouvés" "false" $2
fi