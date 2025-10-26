function audit_general(){
    clear
    echo "------ Audit général en cours ------"
    jsonfile="$1"
    if [ -z "$jsonfile" ] || [ ! -f "$jsonfile" ]; then
        echo "Usage: $0 general <reco.json>"
        return 1
    fi

    jq -r '.[] | @base64' "$jsonfile" | while IFS= read -r row; do
        rowformatted=$(printf '%s' "$row" | base64 --decode)
        id=$(printf '%s' "$rowformatted" | jq -r '.id')
        echo "Traitement de la recommandation ID: $id"
        if [ -n "$id" ]; then
            script="scripts/anssi-${id}.sh"
            if [ -f "$script" ]; then
                bash "$script" || echo "Erreur : exécution de $script a échoué"
            else
                echo "Aucun script trouvé pour la recommandation ID: $id"
            fi
        else
            echo "Warning: entrée JSON sans id"
        fi 
    done
    echo "------ Audit général terminé ------"
}
if [ "$1" = "general" ]; then
    audit_general "$2"
elif [ "$1" = "specifique" ]; then
    recId=$2
    echo "------ Audit spécifique pour la recommandation ID: $recId ------"
    echo "------ Audit spécifique terminé ------"
else
    echo "Usage: $0 [general|specifique <recId>]"
fi
