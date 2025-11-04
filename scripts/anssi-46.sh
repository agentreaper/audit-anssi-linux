source scripts/shortcut_functions.sh
source traitement_csv.sh
if grep -qE "SELINUX=enforcing" /etc/selinux/config && grep -qE "SELINUXTYPE=targeted" /etc/selinux/config; then
    print_green "Tous les profils SELinux sont en mode enforce"
    ajouter_recommandation $1 46 "tout va bien" "true" $2
else
    print_red "Les profils SELinux ne sont pas tous en mode enforce"
    ajouter_recommandation $1 46 "Les politiques SELinux sont mal configurées" "false" $2
fi