source scripts/shortcut_functions.sh
source traitement_csv.sh
if sudo grep -E "^[^#]*\s+ALL\s*=.*dmesg\s+\"\"" /etc/sudoers /etc/sudoers.d/* 2>/dev/null | grep -q "dmesg \"\""; then
    print_green "Les arguments de la commande dmesg sont interdits"
    ajouter_recommandation $1 43 "tout va bien" "true" $2
else
    print_red "Les arguments de la commande dmesg ne sont pas interdits"
    ajouter_recommandation $1 43 "les arguments de la commande dmesg ne sont pas interdits" "false" $2
fi