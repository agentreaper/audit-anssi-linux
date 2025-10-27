# audit-anssi-linux
Ce repo contient un outil d'audit pour les systèmes d'exploitation GNU/Linux selon les recommandations de l'ANSII (Agence Nationnale de la Sécurité des Systèmes D'information).

# Installation
```
gh repo clone agentreaper/audit-anssi-linux
cd audit anssi-linux
```

## Incrémentation
### Structure du json
La structure de base est la suivante
```json
[
    {
        "id": 0,
        "niveau": 0,
        "categorie": "", 
        "nom" : "",
        "description": ""
    }
]
```

### structure du CSV
Le nom par défaut du CSV est `audit.csv`. Le délimiteur est le point virgule `;`
Les colonnes sont les suivantes:
```csv
id;nom;description;niveau;succes;commentaire
``` 

note pour plus tard: permettre de rajouter des données au CSV après le rapport à froid. quitte à retirer les commantaires par défaut