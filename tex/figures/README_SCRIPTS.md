# Scripts et Validation STIX - APT41

Ce document décrit les scripts et fichiers STIX contenus dans le dossier `figures/`.

## Script Python

### validate_stix_apt41.py

**Description**: Script de validation et extraction des IoCs du rapport STIX APT41

**Fonctionnalités principales**:
1. **Validation de la structure STIX 2.1**
   - Vérification des champs requis (type, id, spec_version, objects)
   - Validation du type de bundle
   - Comptage des objets STIX

2. **Extraction des indicateurs de compromission (IoCs)**
   - Hashes SHA256 de malwares APT41
   - Domaines C2 (Command & Control)
   - Patterns de détection

3. **Génération automatique de règles Wazuh**
   - Conversion des IoCs STIX en règles Wazuh XML
   - Attribution automatique des IDs de règles
   - Association avec les techniques MITRE ATT&CK

4. **Analyse du Threat Actor**
   - Profil APT41 complet
   - Alias et sophistication
   - Motivations et types d'acteurs

5. **Analyse des campagnes**
   - Timeline des campagnes majeures
   - Descriptions et périodes d'activité
   - Cibles et secteurs affectés

### Utilisation

```bash
# Installation des dépendances
pip install stix2 stix2-validator

# Exécution du script
python validate_stix_apt41.py
```

### Sortie attendue

```
=== Validation et Analyse du Rapport STIX APT41 ===

✅ Structure STIX valide
   - 45 objets trouvés

📊 Analyse du Threat Actor APT41:
   - Alias: Winnti Group, BRONZE ATLAS, Barium, Double Dragon
   - Première observation: 2012-01-01T00:00:00Z
   - Niveau de sophistication: expert
   - Motivation primaire: organizational-gain
   - Types: state-sponsored, cybercriminal

🎯 Campagnes APT41:
   - CCleaner Supply Chain (2017)
     Compromission de CCleaner affectant 2.27 millions d'utilisateurs...
   - COVID-19 Espionage Campaign (2020)
     Exploitation de la pandémie pour cibler la recherche médicale...

🔍 15 indicateurs de compromission trouvés:
   - SHADOWPAD malware hash
   - WINNTI backdoor hash
   - C2 domain: dns-update.club
   ...

✅ 15 règles Wazuh générées dans 'apt41_wazuh_rules.xml'

📈 Statistiques du rapport:
   - threat-actor: 1
   - campaign: 5
   - malware: 3
   - indicator: 15
   - attack-pattern: 8
   - identity: 10
   - relationship: 25
```

### Fichiers générés

**apt41_wazuh_rules.xml**: Règles de détection Wazuh

Exemple de règle générée:
```xml
<rule id="100001" level="15">
    <if_sid>550</if_sid>
    <match>1a4a5123d7b2c534cb3e3168f7032cf9ebf38b9a2a97226d0fdb7933cf6030ff</match>
    <description>APT41 - SHADOWPAD malware hash</description>
    <mitre>
        <id>T1195</id>
    </mitre>
</rule>
```

## Fichiers STIX JSON

### stix_json_apt41.json

**Format**: STIX 2.1 Bundle
**Description**: Rapport STIX complet sur le groupe APT41

**Structure**:
```json
{
  "type": "bundle",
  "id": "bundle--apt41-report-2024",
  "spec_version": "2.1",
  "objects": [
    {
      "type": "threat-actor",
      "name": "APT41",
      ...
    },
    {
      "type": "campaign",
      ...
    },
    {
      "type": "malware",
      ...
    },
    ...
  ]
}
```

**Types d'objets inclus**:
- **threat-actor**: Profil APT41
- **campaign**: 5 campagnes majeures (2017-2024)
- **malware**: SHADOWPAD, WINNTI, DUSTPAN/DUSTTRAP
- **attack-pattern**: 8 techniques MITRE ATT&CK
- **indicator**: 15 IoCs (hashes, domaines, IPs)
- **identity**: Secteurs ciblés (santé, télécoms, gouvernement)
- **relationship**: Liens entre objets

### apt41_stix_report.json

**Description**: Version alternative du rapport avec focus sur les campagnes récentes

### apt41_techniques_stix.json

**Description**: Focus spécifique sur les techniques de mouvement latéral

**Techniques documentées**:
- T1021.001 - Remote Desktop Protocol (RDP)
- T1021.002 - SMB/Windows Admin Shares
- T1047 - Windows Management Instrumentation (WMI)
- T1550.002 - Use Alternate Authentication Material: Pass the Hash
- T1550.003 - Use Alternate Authentication Material: Pass the Ticket

## Validation avec STIX Validator

### Installation

```bash
pip install stix2-validator
```

### Validation complète

```bash
# Validation du rapport principal
stix2_validator stix_json_apt41.json

# Validation avec niveau verbose
stix2_validator --verbose stix_json_apt41.json

# Validation stricte STIX 2.1
stix2_validator --strict-version 2.1 stix_json_apt41.json
```

### Résultats attendus

```
STIX JSON File: stix_json_apt41.json
STIX Version: 2.1
Validation Type: stix-validator

Results:
✓ The file was validated successfully
✓ All objects are valid STIX 2.1
✓ All relationships are properly formed
✓ All required properties are present
```

## Visualisation STIX

### STIX Visualizer (OASIS)

1. Aller sur: https://oasis-open.github.io/cti-stix-visualization/
2. Charger le fichier `stix_json_apt41.json`
3. Visualiser les relations entre objets

### Alternative: MISP

```bash
# Importer dans MISP
python3 misp_import.py --file stix_json_apt41.json
```

## Intégration dans le SIEM

### 1. Génération des règles Wazuh

```bash
python validate_stix_apt41.py
```

### 2. Déploiement sur Wazuh Manager

```bash
# Copier les règles générées
sudo cp apt41_wazuh_rules.xml /var/ossec/etc/rules/

# Redémarrer Wazuh
sudo systemctl restart wazuh-manager

# Vérifier les règles
sudo /var/ossec/bin/wazuh-logtest
```

### 3. Vérification des alertes

```bash
# Tester une alerte
echo '1a4a5123d7b2c534cb3e3168f7032cf9ebf38b9a2a97226d0fdb7933cf6030ff' | sudo /var/ossec/bin/wazuh-logtest

# Résultat attendu:
# Rule: 100001 (level 15) -> 'APT41 - SHADOWPAD malware hash'
```

## Intégration avec Kestrel

### Exemple de requête utilisant les IoCs STIX

```kestrel
# Charger les IoCs depuis STIX
iocs = LOAD stix://stix_json_apt41.json

# Rechercher les hashes malveillants
malicious_files = GET file FROM wazuh://
    WHERE hash.sha256 IN iocs.indicator.pattern

# Rechercher les connexions C2
c2_connections = GET network-traffic FROM wazuh://
    WHERE dst_ref.value IN iocs.indicator.pattern

# Afficher les résultats
DISP malicious_files ATTR name, hash.sha256, parent_directory_ref.path
DISP c2_connections ATTR src_ref.value, dst_ref.value, dst_port
```

## Maintenance et Mise à jour

### Ajout de nouveaux IoCs

1. Éditer `stix_json_apt41.json`
2. Ajouter un nouvel objet `indicator`:

```json
{
  "type": "indicator",
  "id": "indicator--new-ioc-uuid",
  "spec_version": "2.1",
  "created": "2024-12-08T00:00:00Z",
  "modified": "2024-12-08T00:00:00Z",
  "name": "New APT41 Malware Hash",
  "description": "Recently discovered APT41 malware sample",
  "pattern": "[file:hashes.SHA256 = 'NEW_HASH_HERE']",
  "pattern_type": "stix",
  "valid_from": "2024-12-08T00:00:00Z"
}
```

3. Régénérer les règles:
```bash
python validate_stix_apt41.py
```

4. Redéployer sur Wazuh

### Versioning

- Utiliser des IDs uniques pour chaque version du rapport
- Conserver l'historique des campagnes
- Mettre à jour le champ `modified` lors des changements

## Troubleshooting

### Erreur: "Invalid STIX JSON"

**Solution**: Vérifier la syntaxe JSON
```bash
python -m json.tool stix_json_apt41.json
```

### Erreur: "Missing required property"

**Solution**: Vérifier avec le validateur
```bash
stix2_validator --verbose stix_json_apt41.json
```

### Les règles Wazuh ne se déclenchent pas

**Vérifications**:
1. Règles bien chargées: `sudo /var/ossec/bin/wazuh-logtest`
2. Agents connectés: `sudo /var/ossec/bin/agent_control -l`
3. Logs collectés: `tail -f /var/ossec/logs/alerts/alerts.json`

## Références

- [STIX 2.1 Specification](https://docs.oasis-open.org/cti/stix/v2.1/)
- [STIX Validator Documentation](https://stix2-validator.readthedocs.io/)
- [Wazuh Rules Documentation](https://documentation.wazuh.com/current/user-manual/ruleset/)
- [MITRE ATT&CK APT41](https://attack.mitre.org/groups/G0096/)

## Support

Projet INF808 - Université de Sherbrooke
Professeur: Daniel Migault

---

**Note**: Ces outils sont destinés à un usage éthique et légal dans le cadre de la défense et de la recherche en cybersécurité.
