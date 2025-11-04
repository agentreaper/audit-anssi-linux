source scripts/shortcut_functions.sh
source traitement_csv.sh
if [ -f /etc/sudoers ] && sudo grep -iFq "defaults noexec, requiretty, use_pty, umask=0027" /etc/sudoers && grep -iFq "Defaults ignore_dot, env_reset" /etc/sudoers; then
    print_green "Les lignes requises sont présentes dans /etc/sudoers"
    ajouter_recommandation $1 39 "tout va bien" "true" $2
else
    print_red "Les lignes requises ne sont pas présentes dans /etc/sudoers"
    ajouter_recommandation $1 39 "les permissions du dossier sont mal configurées" "false" $2
fi