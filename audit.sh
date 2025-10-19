function audit_general(){
    clear
    echo "------ Audit général en cours ------"
    echo "------ Audit général terminé ------"
}
if [ "$1" == "general" ]; then
    audit_general
elif [ "$1" == "specifique" ]; then
    recId=$2
    echo "------ Audit spécifique pour la recommandation ID: $recId ------"
    echo "------ Audit spécifique terminé ------"
else
    echo "Usage: $0 [general|specifique <recId>]"
fi
