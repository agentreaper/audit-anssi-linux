#!/bin/bash
function check_headers(){
    IFS=',' read -a var < "$1"
    expected_headers=("id" "nom" "description" "niveau")
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
    rec_id="$1"
    rec_nom="$2"
    rec_description="$3"
    rec_niveau="$4"
    echo "$rec_id,$rec_nom,$rec_description,$rec_niveau" >> "$5"
}
# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4
# do
#   echo "value column 1: $rec_column1"
#   echo "value column 2: $rec_column2"
#   echo "value column 3: $rec_column3"
#   echo "value column 4: $rec_column4"
#   echo ""
# done < <(tail -n +2 test.csv)
check_headers "$1"