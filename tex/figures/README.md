# Figures et Ressources Visuelles - Projet APT41

Ce répertoire contient toutes les figures, diagrammes, captures d'écran et ressources visuelles utilisées dans le rapport LaTeX du projet de détection APT41.

## 📊 Vue d'ensemble

**Total de fichiers** : 55+ fichiers
**Taille totale** : ~46 MB
**Formats** : PNG, JPG, SVG, JSON, Python, MP4
**Catégories** : Architecture, CALDERA, Grafana, Kestrel, MITRE ATT&CK, STIX, Captures d'écran

---

## 🏗️ Architecture et Infrastructure

### Architecture.jpg (165 KB) ⭐
**Description** : Architecture technique complète de l'infrastructure de détection APT41

**Contenu** :
- **Zone 1 - Attack Infrastructure (Rouge)** :
  - CALDERA Server (Ubuntu) - IP: 192.168.1.88:8888
  - Adversary: APT41_Lateral_Movement
  - 13 abilities configurées

- **Zone 2 - Active Directory Domain (Jaune)** :
  - Contrôleur de domaine: SDC01VIRW22 (Target Windows Server 2022)
  - Services réseau: RDP (3389), SMB (445), WMI (135), Kerberos (88)
  - Clients: WIN11-C2 et WIN11-C3 (privilèges élevés)

- **Zone 3 - Wazuh SIEM Stack 4.11 (Bleu)** :
  - Wazuh Manager (IP: 192.168.1.51)
  - Rule engine: 230K+ règles
  - API REST
  - Wazuh Indexer (rétention 30 jours)
  - Wazuh Dashboard (monitoring temps réel)

- **Zone 4 - Threat Hunting & Analytics (Violet)** :
  - Kestrel Threat Hunting (Jupyter Notebooks, STIX pattern matching, PostgreSQL backend)
  - Grafana Dashboards (Détection APT41, intégration IA, métriques temps réel)

**Infrastructure** :
- 5 VMs total
- Réseau: 192.168.x.x segmenté
- Stockage: 500GB alloué
- RAM: 32GB total
- Capacité de détection: 230K événements/jour

**Points d'intégration** :
- Sysmon + Wazuh agents sur tous les Windows
- API REST pour automatisation
- Webhook notifications (Teams/Email)
- MITRE ATT&CK mapping
- Analyse alimentée par IA

---

### SOAREquipe1.jpeg (242 KB) ⭐
**Description** : Architecture de défense automatisée avec SIEM, IA et SOAR

**Contenu** :
- **Zone 1 - Simulation d'Attaque (Rouge)** :
  - CALDERA (émulation adversaire)
  - Techniques: T1021, T1047
  - Attaques Kerberos

- **Zone 2 - Réseau Victime (Bleu)** :
  - Client Windows avec Agent Wazuh
  - Serveur Windows AD avec Agent Wazuh

- **Zone 3 - Cœur de Défense (Bleu foncé)** :
  - **Réponse Active SOAR** (Tier Processus / Bloquer Utilisateur)
  - Wazuh Manager (SIEM)
  - Kestrel (Docker)
  - **Nœud IA Générative** (Claude, GPT, Gemini)
  - Webhook Incident

- **Zone 4 - Visualisation & Rapport (Vert)** :
  - Grafana (dashboards temps réel)
  - Analytics IA
  - Notification E-Mail
  - Microsoft Teams (Webhook Teams)

**Flux automatisé** :
1. CALDERA simule attaque →
2. Agents Wazuh détectent →
3. SIEM analyse →
4. IA enrichit contexte →
5. SOAR répond (tuer processus/bloquer utilisateur) →
6. Grafana visualise + Teams notifie

---

### InfraAPT41.png (6.6 MB)
**Description** : Infrastructure complète APT41 avec tous les composants

### flow_soar.jpeg (126 KB)
**Description** : Diagramme de flux du pipeline SOAR automatisé

---

## 🎯 CALDERA - Simulation d'Attaques

### caldera_1.png (45 KB)
**Description** : Interface principale de CALDERA avec vue d'ensemble

### caldera_Agents.png (16 KB)
**Description** : Liste des agents CALDERA déployés
- Agent: zukiqu (PID 3724)
- Agent: xbroltt (PID 1636)

### caldera_abilities.png (51 KB)
**Description** : Bibliothèque d'abilities CALDERA pour APT41
- 22 abilities YAML développées
- Couverture des 5 techniques de mouvement latéral

### caldera_deploy_agent.png (29 KB)
**Description** : Procédure de déploiement d'agent CALDERA sur cible

### caldera_mittre.png (88 KB)
**Description** : Mapping des abilities CALDERA vers MITRE ATT&CK
- 14 tactiques couvertes
- 55+ techniques

---

## 📈 Grafana - Tableaux de Bord

### Grafana_AI_Dash.png (77 KB)
**Description** : Dashboard Grafana principal avec intégration IA

### Grafana_AI_Dash_apt_1.png (191 KB)
**Description** : Vue détaillée - Détections APT41 en temps réel
- Total détections: 12,217 (24h)
- Alertes critiques: 7,669 (62.8%)

### Grafana_AI_Dash_apt_2.png (153 KB)
**Description** : Vue détaillée - Distribution par technique MITRE
- T1021.001 (RDP): 208 détections
- T1021.002 (SMB): 4,050 détections
- T1550.002 (PTH): 4,010 détections
- T1550.003 (PTT): 3,950 détections

### Grafana_AI_Dash_apt_3.png (148 KB)
**Description** : Vue détaillée - Timeline des attaques

### Grafana_AI_Dash_apt_4.png (112 KB)
**Description** : Vue détaillée - Systèmes affectés et métriques

---

## 🦅 Kestrel - Threat Hunting

### kestrel_architecture.png (61 KB) / .svg (8.3 KB)
**Description** : Architecture du framework Kestrel
- Jupyter Notebooks
- STIX-Shifter
- Backend PostgreSQL

### Kestrel_console.png (59 KB)
**Description** : Console Kestrel avec requêtes de threat hunting

### Kestrel_console_2.png (67 KB)
**Description** : Résultats d'exécution des huntflows Kestrel

### kestrel_jupyter_interface.svg (7.1 KB)
**Description** : Interface Jupyter pour Kestrel (diagramme vectoriel)

### kestrel_soar_flow.png (52 KB) / .svg (6.9 KB)
**Description** : Flux d'intégration Kestrel dans le pipeline SOAR

---

## 🎯 MITRE ATT&CK - Techniques

### mittre attack.png (79 KB)
**Description** : Matrice MITRE ATT&CK avec techniques APT41 surlignées

### mittre attack 1.png (105 KB)
**Description** : Vue détaillée des techniques de mouvement latéral

### Technique Mittre Attack.png (114 KB)
**Description** : Mapping des 5 techniques couvertes par le projet

---

## 🛡️ Wazuh - SIEM

### wazuh-dashboard.png (99 KB)
**Description** : Dashboard Wazuh avec vue d'ensemble des alertes
- Interface de monitoring en temps réel
- Vue des agents connectés
- Statistiques de détection

---

## 👤 APT41 - Profil et Chronologie

### Adversaire.png (55 KB)
**Description** : Profil du threat actor APT41
- Alias: Winnti Group, Double Dragon, BRONZE ATLAS
- Origine: Chine
- Actif depuis: 2012

### Chronologie APT41.png (6.4 MB)
**Description** : Timeline complète des campagnes APT41
- 2012-2024: Principales opérations
- Cibles et secteurs affectés
- Évolution des techniques

### Simulation APT41.png (5.9 MB)
**Description** : Résultats de simulation complète APT41 avec CALDERA

---

## 🎨 Techniques Spécifiques - Captures

### T1550.002_A.png (6.0 MB)
**Description** : Détection Pass-the-Hash (PTH)
- Technique: T1550.002
- Événements Sysmon: Event ID 10 (Process Access)
- Règles Wazuh associées: 110041-110043

### T1550.003_A.png (6.3 MB)
**Description** : Détection Pass-the-Ticket (PTT)
- Technique: T1550.003
- Événements Kerberos: TGT/TGS manipulation
- Règles Wazuh associées: 110044-110055

---

## 📸 Captures d'Écran - Détections en Production

### Série "Capture d'écran 2025-12-06" (9 fichiers)
**Date** : 6 décembre 2025
**Période** : Validation expérimentale (5 jours)

- `120556.png` (77 KB) : Vue d'ensemble détections
- `120758.png` (191 KB) : Alertes critiques Wazuh
- `120827.png` (153 KB) : Détails technique T1550.003
- `120855.png` (148 KB) : Timeline des événements
- `120921.png` (112 KB) : Corrélation multi-événements
- `121147.png` (112 KB) : Dashboard temps réel
- `121310.png` (36 KB) : Statistiques finales
- `125309.png` (114 KB) : Grafana metrics
- `125526.png` (114 KB) : Grafana analytics

### Série "Capture_d_ecran_2025-12-06" (6 fichiers)
**Format** : Noms de fichiers sans espaces

- `121029.png` (90 KB) : Interface Wazuh
- `121040.png` (238 KB) : Détails alertes
- `121114.png` (82 KB) : Configuration règles
- `121130.png` (97 KB) : Logs événements
- `121153.png` (146 KB) : Analyse forensique
- `121233.png` (145 KB) : Rapport final

---

## 🔧 SOAR - Orchestration

### SOAR_GROUE01.png (6.7 MB)
**Description** : Architecture SOAR complète du groupe
- Pipeline automatisé complet
- Intégration IA générative
- Playbooks de réponse

---

## 📹 Vidéo et Multimédia

### Animated_APT_Defense_Infographic_Video.mp4 (3.8 MB)
**Description** : Vidéo d'infographie animée
**Durée** : ~30-60 secondes (estimation)
**Contenu** : Démonstration du système de défense APT41
**Usage** : Présentation visuelle du projet

**Pour visualiser** : Lien dans le README principal ou upload sur YouTube

---

## 📄 Fichiers STIX et Scripts

### STIX JSON Files

#### stix_json_apt41.json (14 KB)
**Format** : STIX 2.1 Bundle
**Description** : Rapport STIX principal pour APT41
**Contenu** :
- Threat actor (APT41)
- 5 campagnes majeures
- 3 malwares (SHADOWPAD, WINNTI, DUSTPAN)
- 15 indicateurs de compromission (IoCs)
- 8 attack patterns (techniques MITRE)
- 10 identités ciblées

#### apt41_stix_report.json (16 KB)
**Description** : Version alternative du rapport STIX
**Usage** : Import dans MISP, OpenCTI, ThreatConnect

#### apt41_stix_report (1).json (16 KB)
**Description** : Copie de sauvegarde du rapport STIX

#### apt41_techniques_stix.json (14 KB)
**Description** : Focus spécifique sur les 5 techniques de mouvement latéral
**Techniques** :
- T1021.001 - RDP
- T1021.002 - SMB/PsExec
- T1047 - WMI
- T1550.002 - Pass-the-Hash
- T1550.003 - Pass-the-Ticket

### stix_json_apt41.png (60 KB)
**Description** : Visualisation graphique du rapport STIX
**Format** : Graphe de relations entre objets STIX

---

## 🐍 Scripts Python

### validate_stix_apt41.py (5.5 KB) ⭐
**Description** : Script de validation et génération de règles Wazuh

**Fonctionnalités** :
1. Validation de la structure STIX 2.1
2. Extraction des IoCs (hashes, domaines, IPs)
3. Génération automatique de règles Wazuh XML
4. Analyse du profil threat actor
5. Analyse des campagnes

**Usage** :
```bash
python validate_stix_apt41.py
```

**Sortie** :
- `apt41_wazuh_rules.xml` : 15 règles générées automatiquement
- Rapport de validation STIX
- Statistiques du rapport

**Dépendances** :
```bash
pip install stix2 stix2-validator
```

---

## 📚 Documentation Associée

### README_STIX_APT41.md (2.5 KB)
**Description** : Documentation du rapport STIX APT41
**Contenu** :
- Structure du rapport STIX
- Techniques d'attaque documentées
- Utilisation pour intégration SIEM
- Exemples de requêtes Kestrel

### README_SCRIPTS.md (7.9 KB)
**Description** : Documentation complète des scripts et validation STIX
**Contenu** :
- Guide d'utilisation de validate_stix_apt41.py
- Explication des fichiers STIX JSON
- Procédure de validation avec stix2-validator
- Intégration dans le SIEM Wazuh
- Requêtes Kestrel utilisant les IoCs STIX

---

## 📊 Statistiques des Fichiers

### Par type de fichier

| Type | Nombre | Taille totale |
|------|--------|---------------|
| PNG | 35+ | ~38 MB |
| JPG | 2 | ~400 KB |
| SVG | 3 | ~23 KB |
| JSON | 4 | ~60 KB |
| MD | 2 | ~10 KB |
| PY | 1 | ~5.5 KB |
| MP4 | 1 | ~3.8 MB |

### Par catégorie

| Catégorie | Fichiers | Taille |
|-----------|----------|--------|
| Architecture | 4 | ~7 MB |
| CALDERA | 5 | ~230 KB |
| Grafana | 5 | ~740 KB |
| Kestrel | 6 | ~200 KB |
| MITRE ATT&CK | 3 | ~270 KB |
| Techniques (T1550) | 2 | ~12 MB |
| Captures d'écran | 15+ | ~2 MB |
| STIX/Scripts | 7 | ~70 KB |
| Divers | 8+ | ~22 MB |

### Top 5 fichiers les plus volumineux

1. **InfraAPT41.png** : 6.6 MB
2. **SOAR_GROUE01.png** : 6.7 MB
3. **Chronologie APT41.png** : 6.4 MB
4. **T1550.003_A.png** : 6.3 MB
5. **T1550.002_A.png** : 6.0 MB

---

## 🎨 Convention de Nommage

### Formats utilisés

- **Architecture** : `Architecture.jpg`, `InfraAPT41.png`
- **Outils** : `caldera_*.png`, `Grafana_*.png`, `Kestrel_*.png`
- **Techniques** : `T1550.002_A.png`, `T1550.003_A.png`
- **Captures** : `Capture d'écran YYYY-MM-DD HHMMSS.png`
- **STIX** : `apt41_*.json`, `stix_json_apt41.*`
- **Scripts** : `validate_*.py`

---

## 🔗 Utilisation dans le Rapport LaTeX

### Inclusion dans main.tex

Les figures sont incluses dans le rapport LaTeX via :

```latex
\includegraphics[width=\textwidth]{figures/Architecture.jpg}
```

### Sections utilisant les figures

| Section | Figures principales |
|---------|---------------------|
| État de l'art | Adversaire.png, Chronologie APT41.png |
| Architecture | Architecture.jpg, InfraAPT41.png |
| Règles Wazuh | wazuh-dashboard.png, captures d'écran |
| Détection | T1550.002_A.png, T1550.003_A.png |
| SOAR | SOAREquipe1.jpeg, flow_soar.jpeg |
| Kestrel | kestrel_*.png/svg |
| Grafana | Grafana_AI_Dash*.png |
| CALDERA | caldera_*.png |

---

## 🛠️ Outils de Création

### Logiciels utilisés (estimé)

- **Diagrammes** : Draw.io, Lucidchart, ou similaire
- **Captures d'écran** : Windows Snipping Tool, ShareX
- **Édition** : GIMP, Photoshop, ou Paint.NET
- **Graphes STIX** : STIX Visualizer (OASIS)
- **Vidéo** : PowerPoint, After Effects, ou outil similaire

---

## 📥 Ajout de Nouvelles Figures

### Procédure recommandée

1. **Nommer clairement** :
   - Format : `categorie_description.format`
   - Exemple : `grafana_dashboard_apt41.png`

2. **Optimiser la taille** :
   - PNG : Comprimer avec TinyPNG ou similaire
   - JPG : Qualité 85-90%
   - SVG : Préféré pour les diagrammes (vectoriel)

3. **Ajouter au Git** :
   ```bash
   git add tex/figures/nouvelle_figure.png
   git commit -m "docs: Ajout figure nouvelle_figure"
   ```

4. **Documenter** :
   - Mettre à jour ce README avec description
   - Ajouter référence dans le rapport LaTeX

---

## 🔍 Recherche de Figures

### Par technique MITRE

- **T1021.001 (RDP)** : Voir captures d'écran 12:05-12:09
- **T1021.002 (SMB)** : Voir captures d'écran 12:10-12:12
- **T1047 (WMI)** : Voir Architecture.jpg (Zone 2)
- **T1550.002 (PTH)** : T1550.002_A.png
- **T1550.003 (PTT)** : T1550.003_A.png

### Par outil

- **CALDERA** : `caldera_*.png`
- **Wazuh** : `wazuh-dashboard.png`, captures d'écran
- **Kestrel** : `kestrel_*.png`, `kestrel_*.svg`
- **Grafana** : `Grafana_AI_Dash*.png`
- **STIX** : `*.json`, `stix_json_apt41.png`

---

## 📧 Support

Pour toute question concernant les figures :
- Consulter ce README
- Vérifier le rapport LaTeX (`main.tex`) pour contexte d'utilisation
- Contacter l'équipe du projet via GitHub

---

**Note** : Ce répertoire contient des ressources visuelles créées dans un cadre académique pour la recherche en cybersécurité. Les techniques et outils présentés sont utilisés dans un contexte éthique et légal d'apprentissage et de défense.
