#!/bin/bash
function check_headers(){
    if [ -f "$1" ]; then
        echo "le fichier csv n'existe pas encore et va être créé"
        touch "$1"
    fi
    IFS=';' read -a var < "$1"
    expected_headers=("id" "nom" "description" "niveau" "succes" "commentaire")
    for i in "${!expected_headers[@]}"; do
        if [ "${var[i]}" != "${expected_headers[i]}" ]; then
            echo "headers incorrects sur la colonne $((i+1)): souhaité '${expected_headers[i]}', obtenu '${var[i]}'" >&2
            remake_header "$1" || return 1
            return 0
        fi
    done
    echo "Les headers sont corrects."
    return 0
}

function ajouter_recommandation(){
    check_headers "$5"
    jq -r '.[] | @base64' "$1" | while IFS= read -r row; do
        rowformatted=$(printf '%s' "$row" | base64 --decode)
        id=$(printf '%s' "$rowformatted" | jq -r '.id')
        if [ $id = "$2" ]; then
            commentaire="$3"
            succes="$4"
            nom=$(printf '%s' "$rowformatted" | jq -r '.nom')
            niveau=$(printf '%s' "$rowformatted" | jq -r '.niveau')
            description=$(printf '%s' "$rowformatted" | jq -r '.description')
            echo -e "$id;$nom;$description;$niveau;$succes;$commentaire" >> "$5"
        fi
    done
}
function remake_header(){
    header="id;nom;description;niveau;succes;commentaire"
    sed -i "1s/.*/$header/" "$1"
}
# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4
# do
#   echo "value column 1: $rec_column1"
#   echo "value column 2: $rec_column2"
#   echo "value column 3: $rec_column3"
#   echo "value column 4: $rec_column4"
#   echo ""
# done < <(tail -n +2 test.csv)