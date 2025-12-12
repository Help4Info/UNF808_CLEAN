# Rapport STIX APT41 - Documentation

## Description
Ce rapport STIX 2.1 documente de manière exhaustive le groupe de menace APT41 (Double Dragon) pour l'implémentation de détection avancée dans les systèmes SIEM et IA.

## Structure du rapport

### 1. **Threat Actor**
- **APT41** : Description complète du groupe avec tous ses alias
- Motivations doubles : espionnage d'État + cybercriminalité
- Niveau de sophistication : expert
- Ressources : gouvernementales

### 2. **Identités ciblées**
- Secteur de la santé (hôpitaux, pharma)
- Télécommunications
- Gouvernements
- Industrie du jeu vidéo

### 3. **Techniques d'attaque (MITRE ATT&CK)**
- **T1195** : Supply Chain Compromise (CCleaner, ASUS)
- **T1190** : Exploit Public-Facing Application (Log4Shell)
- **T1566.001** : Spearphishing Attachment

### 4. **Malwares**
- **SHADOWPAD** : Backdoor modulaire principal
- **WINNTI** : Famille de malware signature
- **DUSTPAN/DUSTTRAP** : Droppers récents (2023-2024)

### 5. **Campagnes majeures**
- **2017** : CCleaner (2.27 millions de victimes)
- **2020** : Espionnage COVID-19
- **2021-2022** : Gouvernements US
- **2023-2024** : DUSTTRAP global

### 6. **Indicateurs de compromission (IoCs)**
- Hashes de fichiers malveillants
- Domaines C2
- Patterns de certificats SSL

### 7. **Mesures de détection**
- Règles SIEM (Wazuh)
- Détection comportementale IA
- Analyse des mouvements latéraux

## Utilisation pour votre projet

### Intégration SIEM (Wazuh)
```xml
<rule id="100001" level="15">
  <if_sid>550</if_sid>
  <match>1a4a5123d7b2c534cb3e3168f7032cf9ebf38b9a2a97226d0fdb7933cf6030ff</match>
  <description>APT41 SHADOWPAD hash detected</description>
  <mitre>
    <id>T1195</id>
  </mitre>
</rule>
```

### Détection IA (Kestrel)
```kestrel
# Détection APT41 supply chain
GET file WHERE hash.sha256 = '1a4a5123d7b2c534cb3e3168f7032cf9ebf38b9a2a97226d0fdb7933cf6030ff'
GET process WHERE name = 'CCleaner.exe' AND command_line CONTAINS 'dns-update.club'
```

## Validation du rapport

1. **Installer le validateur STIX**:
```bash
pip install stix2-validator
```

2. **Valider le rapport**:
```bash
stix2_validator apt41_stix_report.json
```

3. **Visualiser le rapport**:
Utiliser https://oasis-open.github.io/cti-stix-visualization/

## Références
- FireEye APT41 Report (2019)
- Mandiant US State Governments Report (2022)
- Google TAG DUSTTRAP Report (2024)
- MITRE ATT&CK G0096
- US DOJ Indictments (2019, 2020)

## Contact
Projet INF808 - Université de Sherbrooke
Détection APT41 avec SIEM et IA
