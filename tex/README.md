# Documentation LaTeX - Détection APT41

Ce répertoire contient la documentation LaTeX complète du projet de recherche sur la détection des techniques de mouvement latéral du groupe APT41.

## 📄 Document Principal

**Fichier** : `main.tex` (126 pages)
**PDF généré** : `main.pdf`
**Classe** : Article (12pt, A4)
**Police** : Helvetica (Arial alternative)
**Marges** : 2.5 cm
**Interligne** : 1.5

---

## 📚 Sommaire Exécutif

### Contexte et Problématique

Les groupes de menaces persistantes avancées (APT) représentent aujourd'hui l'une des menaces les plus critiques en cybersécurité. **APT41**, également connu sous les noms de Winnti Group ou Double Dragon, se distingue par sa sophistication technique et sa dualité opérationnelle unique combinant espionnage sponsorisé par l'État chinois et cybercriminalité à des fins financières.

Le mouvement latéral constitue une phase critique de la chaîne d'attaque permettant aux adversaires de progresser d'un système initialement compromis vers d'autres ressources de valeur au sein du réseau cible. APT41 excelle particulièrement dans l'utilisation de techniques de mouvement latéral qui exploitent des protocoles légitimes de Windows (RDP, SMB, WMI, Kerberos, NTLM).

**Question de recherche** : Comment améliorer la détection des techniques de mouvement latéral d'APT41 en combinant un SIEM open-source (Wazuh) avec l'intelligence artificielle générative pour l'analyse et la réponse automatisée aux incidents ?

### Objectifs du Projet

**Objectif principal** : Améliorer la détection de +15% et réduire les faux positifs de -20% via l'intégration d'un SIEM open-source avec intelligence artificielle.

**Objectifs spécifiques** :
- Simuler les 5 techniques principales de mouvement latéral d'APT41 (T1021.001/002, T1047, T1550.002/003)
- Développer 55+ règles Wazuh personnalisées pour détection haute-fidélité
- Créer un pipeline SOAR automatisé réduisant le MTTR à moins de 5 minutes
- Générer un dataset annoté de 500+ événements pour validation expérimentale
- Intégrer l'intelligence artificielle générative pour enrichissement contextuel

### Résultats Clés

**Validation expérimentale (2-6 décembre 2024)** :
- ✅ **24,677 détections** validées en production (taux 99.42%)
- ✅ **239,764 événements** analysés par IA sur 7 jours
- ✅ **93% de réduction** du temps de réponse (11.5 min vs 165 min manuel)
- ✅ **55 règles Wazuh** personnalisées (<1% faux positifs)
- ✅ **22 abilities Caldera** couvrant killchain complète APT41

**Score global** : 6.5/7 objectifs atteints ou dépassés (93%)

### Contributions Originales

1. **Intégration IA Générative dans SIEM** (PREMIÈRE IMPLÉMENTATION)
   - 3 modèles génératifs (Claude Sonnet 4, GPT-3.5, Gemini Pro)
   - Pipeline SOAR complet : Détection → Enrichissement IA → Réponse

2. **Approche Hybride Red-Blue-Purple**
   - Validation bidirectionnelle : Caldera simule, Wazuh détecte, SOAR répond
   - Dataset unique de 24,879+ événements annotés

3. **Threat Hunting Standardisé avec Kestrel**
   - 6 huntflows déclaratifs réutilisables
   - Réduction de 82% des lignes de code vs requêtes Python

### Impact Mesurable

- 📉 Réduction de **97%** du temps analyste (7.75h/jour économisées)
- 🕐 Couverture temporelle **24/7** (+300%)
- ⚡ Détection précoce **99.8% plus rapide** (<30s vs 4.2 jours)

---

## 🏗️ Structure du Document

### Organisation du fichier `main.tex`

```latex
main.tex (Document principal)
├── Préambule
│   ├── Packages essentiels (encodage, police, marges)
│   ├── Configuration bibliographie (biber)
│   ├── Configuration listings (YAML, PowerShell, Python)
│   └── Informations du document (preambule.tex)
│
├── Corps du document
│   ├── Page de garde (page_garde.tex)
│   ├── [Sommaire exécutif] (sommaire_executif.tex) - commenté
│   ├── Table des matières
│   │
│   ├── SECTIONS PRINCIPALES
│   │   ├── État de l'art (etatart.tex)
│   │   ├── Architecture et Configuration (architecture_section.tex)
│   │   ├── Règles de Détection Wazuh (regles_wazuh_section.tex)
│   │   ├── Requêtes de Détection (detection_queries_section.tex)
│   │   └── SOAR et IA (automation_soar_section.tex)
│   │
│   ├── Bibliographie (bib.bib)
│   │
│   └── ANNEXES
│       ├── Annexes générales (appendix.tex)
│       ├── Dashboards Grafana (dashboard_grafana_annexe.tex)
│       ├── Threat Hunting Kestrel (kestrel_section.tex)
│       └── Figures et tables Kestrel (kestrel_figures_tables.tex)
```

---

## 📑 Sections du Rapport

### 1. Introduction et État de l'Art (`etatart.tex`)

**Contenu** :
- Introduction générale et problématique
- Profil du groupe APT41 (origine, motivations, campagnes)
- Cadres de modélisation (MITRE ATT&CK, Cyber Kill Chain, Diamond Model)
- Les 5 techniques de mouvement latéral détaillées
- Écosystème d'outils (Caldera, Wazuh, Sysmon, Kestrel, OCSF)

**Références** : 30+ publications académiques et rapports industriels

### 2. Architecture et Configuration (`architecture_section.tex`)

**Contenu** :
- Infrastructure de laboratoire (5 VMs)
- Configuration Wazuh Manager et agents
- Déploiement Sysmon avec configuration personnalisée
- Architecture réseau et segmentation
- Topologie du système de détection

**Figures** : Diagrammes d'architecture, configurations XML

### 3. Règles de Détection Wazuh (`regles_wazuh_section.tex`)

**Contenu** :
- Méthodologie de développement des règles
- 55 règles XML personnalisées (IDs 110001-110055)
- Règles par technique MITRE ATT&CK :
  - T1021.001 (RDP) : 8 règles
  - T1021.002 (SMB/PsExec) : 12 règles
  - T1047 (WMI) : 10 règles
  - T1550.002 (Pass-the-Hash) : 13 règles
  - T1550.003 (Pass-the-Ticket) : 12 règles
- Configuration des niveaux de sévérité

**Listings** : Code XML complet des règles

### 4. Requêtes de Détection et Threat Hunting (`detection_queries_section.tex`)

**Contenu** :
- Requêtes Elasticsearch/OpenSearch
- Requêtes Kestrel pour threat hunting
- Corrélation multi-événements
- Timeline de reconstruction d'attaque
- Métriques de détection

**Listings** : Requêtes DSL, code Kestrel

### 5. SOAR et Intelligence Artificielle (`automation_soar_section.tex`)

**Contenu** :
- Architecture du pipeline SOAR
- Intégration des 3 modèles IA (Claude Sonnet 4, GPT-3.5, Gemini Pro)
- Workflow automatisé : Détection → Analyse → Réponse
- Génération de recommandations tactiques
- Métriques de performance (MTTR, ROI)

**Résultats** :
- 239,764 événements analysés (7 jours)
- Temps d'analyse IA : 2.3 secondes
- MTTR : 11.5 minutes vs 165 minutes manuel

### 6. Références Bibliographiques

**Gestionnaire** : BibLaTeX avec backend Biber
**Fichier** : `bib.bib`
**Style** : Alphabetic
**Références** : 30+ sources (académiques, industrielles, techniques)

### Annexes

#### A. Annexes Générales (`appendix.tex`)
- Configurations détaillées
- Scripts complets
- Données expérimentales

#### B. Dashboards Grafana (`dashboard_grafana_annexe.tex`)
- Captures d'écran des dashboards
- Métriques temps réel (24h)
- Visualisations par technique

#### C. Threat Hunting Kestrel (`kestrel_section.tex`)
- 6 huntflows complets
- Résultats d'exécution
- Analyse des détections

#### D. Figures et Tables Kestrel (`kestrel_figures_tables.tex`)
- Tables de résultats détaillées
- Graphiques de performance

---

## 📂 Fichiers Principaux

### Fichiers de Contenu

| Fichier | Description | Lignes | Rôle |
|---------|-------------|--------|------|
| `main.tex` | Document principal | ~165 | Orchestre tous les éléments |
| `preambule.tex` | Métadonnées et packages | ~117 | Configuration LaTeX |
| `page_garde.tex` | Page de garde | ~50 | Première page du document |
| `sommaire_executif.tex` | Sommaire exécutif | ~260 | Résumé du projet (commenté) |
| `etatart.tex` | État de l'art | ~800 | Introduction et contexte |
| `architecture_section.tex` | Architecture | ~400 | Infrastructure technique |
| `regles_wazuh_section.tex` | Règles Wazuh | ~600 | 55 règles de détection |
| `detection_queries_section.tex` | Requêtes | ~500 | Threat hunting |
| `automation_soar_section.tex` | SOAR et IA | ~700 | Pipeline automatisé |
| `appendix.tex` | Annexes | ~300 | Compléments techniques |
| `dashboard_grafana_annexe.tex` | Dashboards | ~200 | Visualisations |
| `kestrel_section.tex` | Kestrel | ~400 | Huntflows détaillés |
| `kestrel_figures_tables.tex` | Tables Kestrel | ~250 | Résultats |

### Fichiers de Configuration

| Fichier | Description | Format |
|---------|-------------|--------|
| `bib.bib` | Bibliographie principale | BibTeX |
| `ietf.bib` | Bibliographie IETF | BibTeX |
| `references.bib` | Références supplémentaires | BibTeX |

### Ressources

| Dossier/Fichier | Description | Contenu |
|-----------------|-------------|---------|
| `figures/` | Images et diagrammes | 70+ fichiers PNG/JPG/SVG |
| `stix_json_apt41/` | Données STIX et notebooks | JSON, IPYNB, HDF |
| `logo-usherbrooke.png` | Logo université | Image |
| `logo_uds.png` | Logo UdeS | Image |

### Fichiers Générés (LaTeX)

| Fichier | Description | Git |
|---------|-------------|-----|
| `main.pdf` | Rapport compilé final | ✅ Inclus |
| `main.aux` | Fichier auxiliaire | ❌ Ignoré (.gitignore) |
| `main.bbl` | Bibliographie compilée | ❌ Ignoré |
| `main.bcf` | Contrôle Biber | ❌ Ignoré |
| `main.blg` | Log Biber | ❌ Ignoré |
| `main.log` | Log de compilation | ❌ Ignoré |
| `main.out` | Hyperlinks | ❌ Ignoré |
| `main.toc` | Table des matières | ❌ Ignoré |

---

## 🔧 Compilation du Document

### Prérequis

**Distribution LaTeX requise** :
- Windows : [MiKTeX](https://miktex.org/) ou [TeX Live](https://www.tug.org/texlive/)
- macOS : [MacTeX](https://www.tug.org/mactex/)
- Linux : TeX Live (via gestionnaire de paquets)

**Packages essentiels** (installés automatiquement avec MiKTeX) :
- `inputenc`, `fontenc`, `babel` (encodage et langue)
- `biblatex` avec backend `biber` (bibliographie)
- `hyperref` (liens hypertextes)
- `listings` (code source)
- `graphicx` (images)
- `amsmath`, `amsfonts` (mathématiques)

### Compilation Standard (4 passes)

```bash
cd tex/

# Première compilation (génère structure)
pdflatex main.tex

# Compilation de la bibliographie
biber main

# Deuxième compilation (intègre références)
pdflatex main.tex

# Troisième compilation (finalise liens)
pdflatex main.tex
```

**Résultat** : `main.pdf` (126 pages)

### Compilation avec latexmk (Recommandé)

```bash
cd tex/

# Compilation automatique complète
latexmk -pdf main.tex

# Avec nettoyage automatique
latexmk -pdf -c main.tex
```

`latexmk` gère automatiquement les passes nécessaires (pdflatex + biber).

### Compilation avec Overleaf

1. Créer un nouveau projet sur [Overleaf](https://www.overleaf.com/)
2. Uploader tous les fichiers `.tex`, `.bib`, et le dossier `figures/`
3. Compiler (automatique)

**Avantage** : Pas besoin d'installer LaTeX localement

### Nettoyage des fichiers temporaires

```bash
# Suppression manuelle
cd tex/
rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.toc *.fdb_latexmk *.fls *.run.xml

# Avec latexmk
latexmk -C
```

---

## 🎨 Personnalisation

### Modifier les informations du projet

Éditez `preambule.tex` :

```latex
\title{État de l'Art : Détection des Techniques de Mouvement Latéral du Groupe APT41}

\author{
  \textbf{Étudiant 1 : Prénom NOM} \\
  Matricule : XXXXXXX \\[0.2cm]
  \textbf{Étudiant 2 : Prénom NOM} \\
  Matricule : XXXXXXX
}

\date{22 novembre 2024}

\newcommand{\institution}{UNIVERSITÉ DE SHERBROOKE (UDS)}
\newcommand{\cours}{INF808 - Réaction aux attaques et analyses des attaques}
\newcommand{\session}{Automne 2025}
\newcommand{\professeur}{Professeur : Daniel Migault}
```

### Activer le sommaire exécutif

Dans `main.tex`, ligne 127, décommenter :

```latex
% PAGE DE GARDE
\input{page_garde.tex}
\input{sommaire_executif.tex}  % ← Décommenter cette ligne
```

### Ajouter une nouvelle section

1. Créer un fichier `.tex` (ex: `ma_section.tex`)
2. Dans `main.tex`, ajouter avant la bibliographie :
   ```latex
   \input{ma_section.tex}
   ```

---

## 📊 Statistiques du Document

### Métriques générales

- **Pages totales** : 126 pages
- **Figures** : 53 figures
- **Tables** : 40 tables
- **Code listings** : 30 listings (YAML, PowerShell, Python, XML)
- **Références bibliographiques** : 30+ sources
- **Mots** : ~35,000 mots

### Distribution par section

| Section | Pages | % |
|---------|-------|---|
| État de l'art | 25 | 20% |
| Architecture | 15 | 12% |
| Règles Wazuh | 20 | 16% |
| Requêtes détection | 18 | 14% |
| SOAR et IA | 22 | 17% |
| Annexes | 26 | 21% |

---

## 🔗 Fichiers Associés

### Notebooks Jupyter

Localisation : `stix_json_apt41/`

- `APT41ThreatHuntingNotebook.ipynb` : Threat hunting avec Kestrel
- `apt41_incident_response.ipynb` : Réponse aux incidents

### Fichiers STIX

- `stix_json_apt41.json` : Rapport STIX 2.1 complet APT41
- `figures/apt41_stix_report.json` : Version alternative
- `figures/apt41_techniques_stix.json` : Focus techniques

### Scripts

- `figures/validate_stix_apt41.py` : Validation STIX et génération règles Wazuh

### Données de Threat Hunting

- `stix_json_apt41/apt41_hunt.hdf` : Données HDF5
- `stix_json_apt41/apt41_report_*.html` : Rapports HTML
- `stix_json_apt41/apt41_summary_*.csv` : Résumés CSV

---

## 🐛 Troubleshooting

### Erreur : "File not found"

**Cause** : Fichier `.tex` ou image manquant

**Solution** :
```bash
# Vérifier que tous les fichiers existent
ls -la *.tex
ls -la figures/
```

### Erreur : "Undefined control sequence"

**Cause** : Package LaTeX manquant

**Solution** :
- MiKTeX : Installe automatiquement les packages manquants
- TeX Live : `tlmgr install <package-name>`

### Erreur : "Citation undefined"

**Cause** : Bibliographie non compilée

**Solution** :
```bash
biber main
pdflatex main.tex
```

### Erreur : "Package babel Error"

**Cause** : Configuration de langue

**Solution** : Vérifier `\usepackage[french]{babel}` dans le préambule

### PDF non généré

**Cause** : Erreur de compilation bloquante

**Solution** :
1. Lire `main.log` pour identifier l'erreur
2. Chercher "Error" ou "!" dans le log
3. Corriger l'erreur signalée

---

## 📖 Références

### Documentation LaTeX

- [LaTeX Project](https://www.latex-project.org/)
- [Overleaf Documentation](https://www.overleaf.com/learn)
- [TeX Stack Exchange](https://tex.stackexchange.com/)

### Bibliographie

- [BibLaTeX Documentation](https://ctan.org/pkg/biblatex)
- [Biber Documentation](https://ctan.org/pkg/biber)

### Packages utilisés

- [listings](https://ctan.org/pkg/listings) : Code source
- [hyperref](https://ctan.org/pkg/hyperref) : Liens hypertextes
- [graphicx](https://ctan.org/pkg/graphicx) : Images

---

## 👥 Contribution

Ce document a été réalisé dans le cadre du cours **INF808 - Réaction aux attaques et analyses des attaques** de l'Université de Sherbrooke.

**Professeur** : Daniel Migault
**Session** : Automne 2025
**Programme** : Maîtrise en Cybersécurité

---

## 📧 Support

Pour toute question concernant le document LaTeX :
- Consulter le fichier `main.log` pour les erreurs
- Vérifier la documentation LaTeX
- Contacter l'équipe du projet via GitHub

---

**Note** : Ce document fait partie d'un travail de recherche académique en cybersécurité. Les techniques et outils présentés sont utilisés dans un contexte éthique et légal d'apprentissage et de défense.
