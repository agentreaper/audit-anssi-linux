import csv
import sys
from pathlib import Path

#!/usr/bin/env python3
"""
Script de génération de rapport HTML à partir d'un fichier CSV d'audit ANSSI Linux.
"""



def generer_html(csv_path):
    """Génère un rapport HTML à partir d'un fichier CSV."""
    
    # Lire le CSV
    resultats = []
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f, delimiter=';')
        for row in reader:
            resultats.append(row)
    
    # Statistiques
    total = len(resultats)
    succes = sum(1 for r in resultats if r['succes'].lower() == 'true')
    echecs = total - succes
    automatisees = sum(1 for r in resultats if r.get('categorie', '').lower() == 'automatisée')
    manuelles = sum(1 for r in resultats if r.get('categorie', '').lower() == 'manuelle')
    
    # Générer le HTML
    html = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapport d'Audit ANSSI Linux</title>
    <style>
        * {{ box-sizing: border-box; }}
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: #0d1117;
            color: #c9d1d9;
        }}
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            background: #161b22;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.4);
        }}
        h1 {{
            color: #58a6ff;
            border-bottom: 3px solid #1f6feb;
            padding-bottom: 10px;
            margin-top: 0;
        }}
        .stats {{
            display: flex;
            gap: 20px;
            margin: 20px 0;
        }}
        .stat-box {{
            flex: 1;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            background: #21262d;
            border: 1px solid #30363d;
        }}
        .stat-box.total {{ 
            background: linear-gradient(135deg, #1f6feb 0%, #1a56db 100%);
            border: none;
        }}
        .stat-box.success {{ 
            background: linear-gradient(135deg, #238636 0%, #1a6929 100%);
            border: none;
        }}
        .stat-box.error {{ 
            background: linear-gradient(135deg, #da3633 0%, #b62324 100%);
            border: none;
        }}
        .stat-box h2 {{ margin: 0; font-size: 2em; color: white; }}
        .stat-box p {{ margin: 5px 0 0 0; color: rgba(255,255,255,0.9); }}
        
        .filters {{
            margin: 20px 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }}
        .filter-group {{
            display: flex;
            gap: 10px;
            padding: 10px;
            background: #21262d;
            border-radius: 8px;
        }}
        .filter-group label {{
            color: #8b949e;
            font-weight: 600;
            margin-right: 10px;
            align-self: center;
        }}
        .filters button {{
            padding: 10px 20px;
            border: 1px solid #30363d;
            border-radius: 6px;
            cursor: pointer;
            background: #21262d;
            color: #c9d1d9;
            transition: all 0.3s;
            font-weight: 500;
        }}
        .filters button:hover {{ 
            background: #30363d;
            border-color: #58a6ff;
        }}
        .filters button.active {{ 
            background: #1f6feb;
            color: white;
            border-color: #1f6feb;
        }}
        .filters button.niveau-1.active {{ background: #1f6feb; }}
        .filters button.niveau-2.active {{ background: #d29922; }}
        .filters button.niveau-3.active {{ background: #bc4c00; }}
        .filters button.niveau-4.active {{ background: #da3633; }}
        
        .result {{
            border: 1px solid #30363d;
            border-radius: 8px;
            margin: 15px 0;
            padding: 20px;
            transition: all 0.3s;
            background: #0d1117;
        }}
        .result:hover {{
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            transform: translateY(-2px);
            border-color: #58a6ff;
        }}
        .result.success {{ border-left: 4px solid #238636; }}
        .result.error {{ border-left: 4px solid #da3633; }}
        
        .result-header {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }}
        .result-id {{
            font-weight: bold;
            color: #8b949e;
            font-size: 0.9em;
        }}
        .result-title {{
            font-size: 1.2em;
            font-weight: bold;
            color: #58a6ff;
            margin: 10px 0;
        }}
        .badge {{
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 0.85em;
            font-weight: 600;
            margin-left: 8px;
        }}
        .badge.niveau-1 {{ background: #1f6feb; color: white; }}
        .badge.niveau-2 {{ background: #d29922; color: white; }}
        .badge.niveau-3 {{ background: #bc4c00; color: white; }}
        .badge.niveau-4 {{ background: #da3633; color: white; }}
        .badge.success {{ background: #238636; color: white; }}
        .badge.error {{ background: #da3633; color: white; }}
        .badge.auto {{ background: #7c3aed; color: white; }}
        .badge.manual {{ background: #f59e0b; color: white; }}
        
        .result-description {{
            color: #8b949e;
            margin: 10px 0;
            line-height: 1.6;
        }}
        .result-comment {{
            background: #21262d;
            padding: 12px;
            border-radius: 6px;
            border-left: 3px solid #58a6ff;
            font-style: italic;
            color: #8b949e;
            margin-top: 10px;
        }}
    </style>
</head>
<body>
    <div class="container">
        <h1>🔒 Rapport d'Audit de Sécurité ANSSI Linux</h1>
        
        <div class="stats">
            <div class="stat-box total">
                <h2>{total}</h2>
                <p>Tests au total</p>
            </div>
            <div class="stat-box success">
                <h2>{succes}</h2>
                <p>Conformes</p>
            </div>
            <div class="stat-box error">
                <h2>{echecs}</h2>
                <p>Non conformes</p>
            </div>
        </div>
        
        <div class="stats">
            <div class="stat-box" style="background: linear-gradient(135deg, #7c3aed 0%, #5b21b6 100%);">
                <h2>{automatisees}</h2>
                <p>Tests automatisés</p>
            </div>
            <div class="stat-box" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
                <h2>{manuelles}</h2>
                <p>Tests manuels</p>
            </div>
        </div>
        
        <div class="filters">
            <div class="filter-group">
                <label>Statut:</label>
                <button onclick="filtrerStatut('all')" class="active" id="btn-all">Tous</button>
                <button onclick="filtrerStatut('error')" id="btn-error">Non conformes</button>
                <button onclick="filtrerStatut('success')" id="btn-success">Conformes</button>
            </div>
            <div class="filter-group">
                <label>Niveau:</label>
                <button onclick="filtrerNiveau('all')" class="active" id="btn-niveau-all">Tous</button>
                <button onclick="filtrerNiveau('1')" class="niveau-1" id="btn-niveau-1">Niveau 1</button>
                <button onclick="filtrerNiveau('2')" class="niveau-2" id="btn-niveau-2">Niveau 2</button>
                <button onclick="filtrerNiveau('3')" class="niveau-3" id="btn-niveau-3">Niveau 3</button>
                <button onclick="filtrerNiveau('4')" class="niveau-4" id="btn-niveau-4">Niveau 4</button>
            </div>
            <div class="filter-group">
                <label>Catégorie:</label>
                <button onclick="filtrerCategorie('all')" class="active" id="btn-cat-all">Toutes</button>
                <button onclick="filtrerCategorie('automatisée')" id="btn-cat-auto">Automatisées</button>
                <button onclick="filtrerCategorie('manuelle')" id="btn-cat-manual">Manuelles</button>
            </div>
        </div>
        
        <div id="resultats">
"""
    
    # Ajouter chaque résultat
    for r in resultats:
        is_success = r['succes'].lower() == 'true'
        status_class = 'success' if is_success else 'error'
        status_text = 'Conforme' if is_success else 'Non conforme'
        niveau_class = f"niveau-{r['niveau']}"
        categorie = r.get('categorie', 'automatisée').lower()
        categorie_badge = 'Automatisée' if categorie == 'automatisée' else 'Manuelle'
        categorie_class = 'auto' if categorie == 'automatisée' else 'manual'
        
        html += f"""
            <div class="result {status_class}" data-status="{status_class}" data-niveau="{r['niveau']}" data-categorie="{categorie}">
                <div class="result-header">
                    <div>
                        <span class="result-id">#{r['id']}</span>
                        <span class="badge {niveau_class}">Niveau {r['niveau']}</span>
                        <span class="badge {categorie_class}">{categorie_badge}</span>
                        <span class="badge {status_class}">{status_text}</span>
                    </div>
                </div>
                <div class="result-title">{r['nom']}</div>
                <div class="result-description">{r['description']}</div>
                <div class="result-comment"><strong>Commentaire :</strong> {r['commentaire']}</div>
            </div>
"""
    
    # Fermer le HTML
    html += """
        </div>
    </div>
    
    <script>
        let filtreStatut = 'all';
        let filtreNiveau = 'all';
        let filtreCategorie = 'all';
        
        function appliquerFiltres() {
            const resultats = document.querySelectorAll('.result');
            
            resultats.forEach(result => {
                const matchStatut = filtreStatut === 'all' || result.dataset.status === filtreStatut;
                const matchNiveau = filtreNiveau === 'all' || result.dataset.niveau === filtreNiveau;
                const matchCategorie = filtreCategorie === 'all' || result.dataset.categorie === filtreCategorie;
                
                if (matchStatut && matchNiveau && matchCategorie) {
                    result.style.display = 'block';
                } else {
                    result.style.display = 'none';
                }
            });
        }
        
        function filtrerStatut(type) {
            filtreStatut = type;
            
            document.querySelectorAll('.filter-group:first-child button').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('btn-' + type).classList.add('active');
            
            appliquerFiltres();
        }
        
        function filtrerNiveau(niveau) {
            filtreNiveau = niveau;
            
            document.querySelectorAll('.filter-group:nth-child(2) button').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('btn-niveau-' + niveau).classList.add('active');
            
            appliquerFiltres();
        }
        
        function filtrerCategorie(categorie) {
            filtreCategorie = categorie;
            
            document.querySelectorAll('.filter-group:nth-child(3) button').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('btn-cat-' + (categorie === 'all' ? 'all' : (categorie === 'automatisée' ? 'auto' : 'manual'))).classList.add('active');
            
            appliquerFiltres();
        }
    </script>
</body>
</html>
"""
    
    # Écrire le fichier HTML
    output_path = Path(csv_path).stem + '_rapport.html'
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"Rapport généré : {output_path}")


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python rapport-html.py <fichier.csv>")
        sys.exit(1)
    
    csv_file = sys.argv[1]
    if not Path(csv_file).exists():
        print(f"Erreur: Le fichier {csv_file} n'existe pas")
        sys.exit(1)
    
    generer_html(csv_file)