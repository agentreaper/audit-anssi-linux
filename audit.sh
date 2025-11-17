function audit_general(){
    source sripts/shortcut_functions.sh
    clear
    echo "------ Audit général en cours ------"
    jsonfile="$1"
    csvfile="rapports/$2"
    if [ -z "$jsonfile" ] || [ ! -f "$jsonfile" ]; then
        echo "Usage: $0 --type general --reco <fichier json des recommandations> --outputcsv <fichier csv de rapport>"
        return 1
    fi
    remake_header $csvfile
    jq -r '.[] | @base64' "$jsonfile" | while IFS= read -r row; do
        rowformatted=$(printf '%s' "$row" | base64 --decode)
        id=$(printf '%s' "$rowformatted" | jq -r '.id')
        categorie=$(printf '%s' "$rowformatted" | jq -r '.categorie')
        
        if [ -n "$id" ]; then
            # Si la recommandation est manuelle et que MANUAL=true, l'ajouter avec résultat "inconnu"
            if [ "$categorie" = "manuelle" ] && [ "$MANUAL" = "true" ]; then
                echo "Ajout de la recommandation manuelle ID: $id avec résultat 'inconnu'"
                ajouter_recommandation "$jsonfile" "$id" "Vérification manuelle requise" "inconnu" "$csvfile"
            # Sinon, traiter normalement avec le script si disponible
            else
                script="scripts/anssi-${id}.sh"
                if [ -f "$script" ]; then
                    echo "Traitement de la recommandation ID: $id"
                    bash "$script" $jsonfile $csvfile
                else
                    continue
                fi
            fi
        else
            echo "Warning: entrée JSON sans id"
        fi 
    done
    echo "------ Audit général terminé ------"
}

source scripts/shortcut_functions.sh
source traitement_csv.sh

# Parse arguments
TYPE=""
OUTPUTCSV=""
RECO=""
MANUAL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --type)
            TYPE="$2"
            shift 2
            ;;
        --outputcsv)
            OUTPUTCSV="$2"
            shift 2
            ;;
        --reco)
            RECO="$2"
            shift 2
            ;;
        --manual)
            MANUAL=true
            shift
            ;;
        *)
            echo "Option inconnue: $1"
            exit 1
            ;;
    esac
done

if [ "$TYPE" = "general" ]; then
    audit_general "$RECO" "$OUTPUTCSV"
elif [ "$TYPE" = "specifique" ]; then
    echo "------ Audit spécifique pour la recommandation ID: $RECO ------"
    # Ajoutez ici le code pour l'audit spécifique
    echo "------ Audit spécifique terminé ------"
else
    echo "Usage: $0 --type [general|specifique] --reco <fichier json des recommandations> --outputcsv <fichier csv> [--reco <recId>]"
    exit 1
fi
python3 generation-rapports/rapport-html.py "rapports/$OUTPUTCSV"