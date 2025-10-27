#!/bin/bash
function check_headers(){
    IFS=',' read -a var < "$1"
    expected_headers=("nom" "description" "niveau" "succes" "commentaire")
    for i in "${!expected_headers[@]}"; do
        if [ "${var[i]}" != "${expected_headers[i]}" ]; then
            echo "headers incorrects sur la colonne $((i+1)): souhaité '${expected_headers[i]}', obtenu '${var[i]}'" >&2
            return 1
        fi
    done
    echo "Les headers sont corrects."
    return 0
}

function ajouter_recommandation(){
    jq -r '.[] | @base64' "$1" | while IFS= read -r row; do
        rowformatted=$(printf '%s' "$row" | base64 --decode)
        id=$(printf '%s' "$rowformatted" | jq -r '.id')
        if [ $id = "$2" ]; then
            echo "la recommandation $id existe"
            commentaire="$3"
            succes="$4"
            nom=$(printf '%s' "$rowformatted" | jq -r '.nom')
            niveau=$(printf '%s' "$rowformatted" | jq -r '.niveau')
            description=$(printf '%s' "$rowformatted" | jq -r '.description')
            echo -e "$nom,$description,$niveau,$succes,$commentaire" >> "$5"
        fi
    done
}
# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4
# do
#   echo "value column 1: $rec_column1"
#   echo "value column 2: $rec_column2"
#   echo "value column 3: $rec_column3"
#   echo "value column 4: $rec_column4"
#   echo ""
# done < <(tail -n +2 test.csv)