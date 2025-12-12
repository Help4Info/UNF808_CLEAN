#!/usr/bin/env python3
"""
Script de validation et extraction des IoCs du rapport STIX APT41
Pour le projet INF808 - Détection APT41 avec SIEM et IA
"""

import json
import sys
from datetime import datetime

def load_stix_report(filename):
    """Charge le rapport STIX depuis un fichier JSON"""
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"Erreur lors du chargement du fichier: {e}")
        return None

def validate_stix_structure(report):
    """Valide la structure basique du rapport STIX"""
    required_fields = ['type', 'id', 'spec_version', 'objects']
    
    for field in required_fields:
        if field not in report:
            print(f"❌ Champ requis manquant: {field}")
            return False
    
    if report['type'] != 'bundle':
        print(f"❌ Type incorrect: {report['type']} (devrait être 'bundle')")
        return False
    
    if report['spec_version'] != '2.1':
        print(f"⚠️  Version STIX: {report['spec_version']} (recommandé: 2.1)")
    
    print(f"✅ Structure STIX valide")
    print(f"   - {len(report['objects'])} objets trouvés")
    return True

def extract_indicators(report):
    """Extrait tous les indicateurs du rapport"""
    indicators = []
    
    for obj in report['objects']:
        if obj['type'] == 'indicator':
            indicators.append({
                'name': obj.get('name', 'Unknown'),
                'pattern': obj.get('pattern', ''),
                'description': obj.get('description', ''),
                'valid_from': obj.get('valid_from', '')
            })
    
    return indicators

def generate_wazuh_rules(indicators):
    """Génère des règles Wazuh à partir des indicateurs"""
    rules = []
    rule_id = 100001
    
    for indicator in indicators:
        # Extraire la valeur du pattern STIX
        pattern = indicator['pattern']
        
        if 'SHA256' in pattern:
            # Extraction du hash
            hash_value = pattern.split("'")[1]
            rule = f"""
<rule id="{rule_id}" level="15">
    <if_sid>550</if_sid>
    <match>{hash_value}</match>
    <description>APT41 - {indicator['name']}</description>
    <mitre>
        <id>T1195</id>
    </mitre>
</rule>"""
            rules.append(rule)
            
        elif 'domain-name' in pattern:
            # Extraction du domaine
            domain = pattern.split("'")[1]
            rule = f"""
<rule id="{rule_id}" level="14">
    <if_sid>1002</if_sid>
    <match>{domain}</match>
    <description>APT41 C2 - {indicator['name']}</description>
    <mitre>
        <id>T1071</id>
    </mitre>
</rule>"""
            rules.append(rule)
        
        rule_id += 1
    
    return rules

def analyze_threat_actor(report):
    """Analyse les informations sur le threat actor"""
    for obj in report['objects']:
        if obj['type'] == 'threat-actor' and obj['name'] == 'APT41':
            print("\n📊 Analyse du Threat Actor APT41:")
            print(f"   - Alias: {', '.join(obj['aliases'])}")
            print(f"   - Première observation: {obj['first_seen']}")
            print(f"   - Niveau de sophistication: {obj['sophistication']}")
            print(f"   - Motivation primaire: {obj['primary_motivation']}")
            print(f"   - Types: {', '.join(obj['threat_actor_types'])}")

def analyze_campaigns(report):
    """Analyse les campagnes APT41"""
    campaigns = []
    
    for obj in report['objects']:
        if obj['type'] == 'campaign':
            campaigns.append({
                'name': obj['name'],
                'description': obj['description'],
                'first_seen': obj.get('first_seen', 'Unknown'),
                'last_seen': obj.get('last_seen', 'Unknown')
            })
    
    if campaigns:
        print("\n🎯 Campagnes APT41:")
        for campaign in sorted(campaigns, key=lambda x: x['first_seen']):
            print(f"   - {campaign['name']} ({campaign['first_seen'][:4]})")
            print(f"     {campaign['description'][:80]}...")

def main():
    print("=== Validation et Analyse du Rapport STIX APT41 ===\n")
    
    # Charger le rapport
    report = load_stix_report('apt41_stix_report.json')
    if not report:
        sys.exit(1)
    
    # Valider la structure
    if not validate_stix_structure(report):
        sys.exit(1)
    
    # Analyser le threat actor
    analyze_threat_actor(report)
    
    # Analyser les campagnes
    analyze_campaigns(report)
    
    # Extraire les indicateurs
    indicators = extract_indicators(report)
    print(f"\n🔍 {len(indicators)} indicateurs de compromission trouvés:")
    for ind in indicators:
        print(f"   - {ind['name']}")
    
    # Générer les règles Wazuh
    rules = generate_wazuh_rules(indicators)
    
    # Sauvegarder les règles
    with open('apt41_wazuh_rules.xml', 'w', encoding='utf-8') as f:
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
        f.write('<group name="apt41,attack">\n')
        for rule in rules:
            f.write(rule + '\n')
        f.write('</group>')
    
    print(f"\n✅ {len(rules)} règles Wazuh générées dans 'apt41_wazuh_rules.xml'")
    
    # Statistiques finales
    object_types = {}
    for obj in report['objects']:
        obj_type = obj['type']
        object_types[obj_type] = object_types.get(obj_type, 0) + 1
    
    print("\n📈 Statistiques du rapport:")
    for obj_type, count in sorted(object_types.items()):
        print(f"   - {obj_type}: {count}")

if __name__ == "__main__":
    main()
