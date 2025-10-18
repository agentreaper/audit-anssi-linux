function afficherRecommandations() {
    clear
    echo "------ Affichage de toutes les recommandations ------"
    jsonData=$( cat manual.json )
    for row in $(echo $jsonData | jq -r '.[] | @base64'); do
        echo "ID de la recommandation : $(echo "${row}" | base64 -di | jq -r '.id')"
        echo "Niveau : $(echo "${row}" | base64 -di | jq -r '.niveau')"
        echo "-----------------------------"
    done
}

function saisieClavier(){
    read -p "Entrez votre choix :
    1. Afficher toutes les recommandations
    2. Obtenir les recommandations par niveau
    " reponse
    case $reponse in
        1) afficherRecommandations ;;
        2) obtenirRecommandationsParNiveau ;;
        *) echo "Entrée invalide. Veuillez réessayer." ;;
    esac
}

function obtenirRecommandationsParNiveau(){
    read -p "Entrez le niveau de sécurité (1, 2, 3 ou 4) : " niveau
    clear
    echo "------ Recommandations pour le niveau $niveau ------"
    jsonData=$( cat manual.json )
    for row in $(echo $jsonData | jq -r --arg lvl "$niveau" '.[] | select(.niveau == ($lvl | tonumber)) | @base64'); do
        echo "ID de la recommandation : $(echo "${row}" | base64 -di | jq -r '.id')"
        echo "Niveau : $(echo "${row}" | base64 -di | jq -r '.niveau')"
        echo "-----------------------------"
    done
}

clear
while true; do
    saisieClavier
done