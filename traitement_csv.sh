#!/bin/bash

function ajouter_recommandation(){
    jq -r '.[] | @base64' "$1" | while IFS= read -r row; do
        rowformatted=$(printf '%s' "$row" | base64 --decode)
        id=$(printf '%s' "$rowformatted" | jq -r '.id')
        if [ $id = "$2" ]; then
            commentaire="$3"
            succes="$4"
            nom=$(printf '%s' "$rowformatted" | jq -r '.nom')
            niveau=$(printf '%s' "$rowformatted" | jq -r '.niveau')
            description=$(printf '%s' "$rowformatted" | jq -r '.description')
            categorie=$(printf '%s' "$rowformatted" | jq -r '.categorie')
            echo -e "$id;$nom;$description;$niveau;$categorie;$succes;$commentaire" >> "$5"
        fi
    done
}
function remake_header(){
    header="id;nom;description;niveau;categorie;succes;commentaire"
    if test -f "$1"; then
        sed -i "1s/.*/$header/" "$1"
        head -n 1 $1
    else
        echo $header > "$1"
    fi
}
# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4
# do
#   echo "value column 1: $rec_column1"
#   echo "value column 2: $rec_column2"
#   echo "value column 3: $rec_column3"
#   echo "value column 4: $rec_column4"
#   echo ""
# done < <(tail -n +2 test.csv)