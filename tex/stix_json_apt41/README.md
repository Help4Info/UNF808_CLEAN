# Threat Hunting et Incident Response - APT41

Ce dossier contient les notebooks Jupyter, scripts et données pour le threat hunting et la réponse aux incidents liés au groupe APT41.

## Contenu du dossier

### Notebooks Jupyter

#### 1. APT41ThreatHuntingNotebook.ipynb
**Description**: Notebook principal pour le threat hunting des techniques APT41

**Contenu**:
- Requêtes Kestrel pour la détection des 5 techniques de mouvement latéral
- Analyse des IoCs (Indicators of Compromise)
- Corrélation des événements de sécurité
- Visualisation des résultats de chasse
- Génération de rapports HTML

**Techniques couvertes**:
- T1021.001 - Remote Desktop Protocol (RDP)
- T1021.002 - SMB/Windows Admin Shares
- T1047 - Windows Management Instrumentation (WMI)
- T1550.002 - Use Alternate Authentication: Pass the Hash
- T1550.003 - Use Alternate Authentication: Pass the Ticket

**Utilisation**:
```bash
jupyter notebook APT41ThreatHuntingNotebook.ipynb
```

#### 2. apt41_incident_response.ipynb
**Description**: Playbook de réponse aux incidents APT41

**Contenu**:
- Procédures d'investigation d'incident
- Scripts de remédiation automatisés
- Analyse forensique post-incident
- Timeline de reconstruction d'attaque
- Documentation des leçons apprises

**Utilisation**:
```bash
jupyter notebook apt41_incident_response.ipynb
```

### Fichiers de données

#### apt41_hunt.hdf / apt41_hunt_fixed.hdf
**Format**: HDF5 (Hierarchical Data Format)
**Description**: Données de chasse structurées contenant les résultats des requêtes Kestrel

**Contenu**:
- Événements de sécurité collectés
- Résultats de corrélation
- Métriques de détection
- Timeline des événements

**Lecture**:
```python
import h5py
with h5py.File('apt41_hunt.hdf', 'r') as f:
    # Lire les données
    events = f['events'][:]
```

#### apt41_report_YYYYMMDD_HHMMSS.html
**Description**: Rapports HTML générés automatiquement par les notebooks

**Contenu**:
- Résumé exécutif de la chasse
- Détections positives
- Graphiques et visualisations
- Recommandations

**Visualisation**: Ouvrir directement dans un navigateur web

#### apt41_report_YYYYMMDD_HHMMSS.json
**Description**: Rapport structuré au format JSON

**Utilisation**:
```python
import json
with open('apt41_report_20251208_190522.json', 'r') as f:
    report = json.load(f)
```

#### apt41_summary_YYYYMMDD_HHMMSS.csv
**Description**: Résumé tabulaire des détections

**Colonnes**:
- Timestamp
- Technique MITRE ATT&CK
- Severity
- Host
- Description
- Status

**Utilisation**:
```python
import pandas as pd
df = pd.read_csv('apt41_summary_20251208_190522.csv')
```

### Scripts PowerShell

#### remediation_SDC01VIRW22.ps1
**Description**: Script de remédiation automatisé pour les systèmes compromis

**Fonctionnalités**:
- Isolation du système compromis
- Arrêt des processus malveillants
- Suppression des persistences APT41
- Collecte de preuves forensiques
- Restauration de la configuration sécurisée

**Utilisation** (avec privilèges administrateur):
```powershell
# Vérifier la politique d'exécution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Exécuter le script
.\remediation_SDC01VIRW22.ps1 -Verbose
```

**AVERTISSEMENT**: Ce script modifie la configuration système. Toujours tester en environnement de lab avant production.

### Fichiers de logs

#### analyzer.log
**Description**: Log de l'analyseur Kestrel

**Contenu**:
- Exécution des requêtes Kestrel
- Erreurs et avertissements
- Statistiques de performance
- Connexions aux sources de données

#### hunt.log
**Description**: Log des sessions de threat hunting

**Contenu**:
- Timestamps des sessions
- Requêtes exécutées
- Résultats obtenus
- Actions de remédiation

## Dépendances

### Python
```bash
pip install kestrel-lang
pip install jupyter
pip install pandas
pip install matplotlib
pip install seaborn
pip install h5py
pip install stix2
```

### Kestrel Runtime
```bash
# Installation de Kestrel
pip install kestrel-jupyter

# Configuration des sources de données
kestrel config init
```

## Configuration

### Connexion aux sources de données

Éditer `~/.config/kestrel/kestrel.yaml`:

```yaml
datasources:
  wazuh:
    type: stixshifter
    connector: elastic
    connection:
      host: wazuh-indexer.local
      port: 9200
      indices: wazuh-alerts-*

  sysmon:
    type: stixshifter
    connector: splunk
    connection:
      host: splunk.local
      port: 8089
```

## Workflow de Threat Hunting

### 1. Préparation
```bash
# Démarrer Jupyter
jupyter notebook

# Ouvrir APT41ThreatHuntingNotebook.ipynb
```

### 2. Exécution des requêtes
- Exécuter les cellules séquentiellement
- Analyser les résultats de chaque technique
- Noter les détections positives

### 3. Investigation
- Pour chaque détection, investiguer avec apt41_incident_response.ipynb
- Collecter les preuves
- Documenter les findings

### 4. Remédiation
- Exécuter les scripts PowerShell de remédiation
- Vérifier l'efficacité
- Documenter les actions

### 5. Reporting
- Générer le rapport HTML final
- Exporter le CSV pour analyse
- Archiver les données HDF5

## Structure des requêtes Kestrel

### Exemple - Détection T1021.001 (RDP)
```kestrel
# Recherche de connexions RDP suspectes
procs = GET process FROM wazuh://
    WHERE [process:name = 'mstsc.exe']
    START 2024-12-01T00:00:00Z STOP 2024-12-08T23:59:59Z

# Analyse des événements réseau associés
conns = GET network-traffic FROM wazuh://
    WHERE [network-traffic:dst_port = 3389]
    AND [network-traffic:src_ref.value IN procs]

# Affichage des résultats
DISP procs ATTR name, pid, command_line, parent_ref.name
DISP conns ATTR src_ref.value, dst_ref.value, dst_port
```

## Métriques de détection

Les notebooks génèrent les métriques suivantes:

- **True Positives**: Détections confirmées d'activité APT41
- **False Positives**: Alertes nécessitant tuning
- **Coverage**: % de techniques APT41 détectées
- **Time to Detect (TTD)**: Temps entre l'événement et la détection
- **Time to Respond (TTR)**: Temps entre la détection et la remédiation

## Troubleshooting

### Erreur: "No connection to datasource"
- Vérifier la configuration Kestrel dans `kestrel.yaml`
- Tester la connectivité réseau vers Wazuh/Splunk
- Vérifier les credentials

### Erreur: "Kernel died"
- Augmenter la mémoire allouée à Jupyter
- Réduire la plage temporelle des requêtes
- Optimiser les requêtes Kestrel

### Fichiers HDF corrompus
- Utiliser `apt41_hunt_fixed.hdf` (version réparée)
- Ou régénérer avec le notebook

## Références

- [Kestrel Threat Hunting Language](https://kestrel.readthedocs.io/)
- [MITRE ATT&CK APT41 Profile](https://attack.mitre.org/groups/G0096/)
- [STIX 2.1 Specification](https://docs.oasis-open.org/cti/stix/v2.1/)

## Support

Pour toute question:
- Projet: INF808 - Université de Sherbrooke
- Professeur: Daniel Migault

---

**Note**: Ces outils sont destinés à un usage éthique et légal dans le cadre de la défense et de la recherche en cybersécurité.
