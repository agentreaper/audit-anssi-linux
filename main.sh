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
    3. Obtenir les recommandations par catégorie
    4. Audit général 
    5. Audit spécifique
    6. Quitter
    " reponse
    case $reponse in
        1) afficherRecommandations ;;
        2) obtenirRecommandationsParNiveau ;;
        3) obtenirRecommandationsParCategorie ;;
        4) auditGeneral ;;
        5) auditSpecifique ;;
        *) echo "Entrée invalide. Veuillez réessayer." ;;
    esac
}

function auditGeneral(){
    bash ./audit.sh "general"
}
function auditSpecifique(){
    read -p "Entrez l'ID de la recommandation à auditer : " recId
    bash ./audit.sh "specifique" "$recId"
}

function obtenirRecommandationsParCategorie(){
    read -p "Entrez la catégorie de sécurité
    1. automatisée
    2. manuelle
    3. autre
    " categorie
    case $categorie in
        1) categorieTexte="automatisée" ;;
        2) categorieTexte="manuelle" ;;
        3) categorieTexte="autre" ;;
        *) echo "Entrée invalide. Veuillez réessayer." ; return ;;
    esac
    clear
    echo "------ Recommandations pour la catégorie $categorieTexte ------"
    jsonData=$( cat manual.json )
    for row in $(echo $jsonData | jq -r --arg cat "$categorieTexte" '.[] | select(.categorie == $cat) | @base64'); do
        echo "ID de la recommandation : $(echo "${row}" | base64 -di | jq -r '.id')"
        echo "Catégorie : $(echo "${row}" | base64 -di | jq -r '.categorie')"
        echo "-----------------------------"
    done
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