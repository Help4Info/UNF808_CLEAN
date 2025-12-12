# Guide de Contribution - Projet APT41

Ce document explique comment contribuer au projet et préparer votre travail pour GitHub.

## Avant de commencer

### Prérequis
- Git installé et configuré
- Compte GitHub
- Accès au dépôt du projet
- Nom et matricule configurés dans `tex/preambule.tex`

## Configuration Git

### Configuration initiale

```bash
# Configurer votre identité
git config --global user.name "Prénom NOM"
git config --global user.email "votre.email@usherbrooke.ca"

# Vérifier la configuration
git config --list
```

## Structure de contribution

### Identification des contributions

Chaque étudiant doit clairement identifier ses contributions dans :
1. **Commits Git**: Commits nominatifs
2. **Code/Scripts**: Commentaires avec auteur
3. **Document LaTeX**: Sections avec commentaires d'auteur

### Exemple de commentaire LaTeX
```latex
% ===================================================================
% Section rédigée par: Prénom NOM (Matricule: XXXXXXX)
% Date: 2024-12-08
% ===================================================================
\section{Votre section}
...
```

### Exemple de commentaire Python
```python
# ===================================================================
# Script développé par: Prénom NOM (Matricule: XXXXXXX)
# Date: 2024-12-08
# Description: Validation des rapports STIX APT41
# ===================================================================
```

## Workflow de contribution

### 1. Cloner le dépôt (première fois)

```bash
git clone https://github.com/votre-organisation/pj-enlm-25a-1.git
cd pj-enlm-25a-1
```

### 2. Créer une branche de travail

```bash
# Créer une branche avec un nom descriptif
git checkout -b feature/detection-wazuh
# ou
git checkout -b fix/latex-compilation
# ou
git checkout -b docs/kestrel-notebook
```

**Convention de nommage des branches**:
- `feature/nom-feature`: Nouvelle fonctionnalité
- `fix/nom-bug`: Correction de bug
- `docs/nom-doc`: Documentation
- `refactor/nom`: Refactoring
- `test/nom`: Ajout de tests

### 3. Travailler sur votre branche

```bash
# Vérifier la branche actuelle
git branch

# Faire vos modifications
# Éditer les fichiers, ajouter du code, etc.
```

### 4. Vérifier les modifications

```bash
# Voir les fichiers modifiés
git status

# Voir les changements détaillés
git diff

# Voir les fichiers non suivis
git ls-files --others --exclude-standard
```

### 5. Nettoyer avant commit

**IMPORTANT**: Supprimer les fichiers temporaires avant de commit

```bash
# Se placer dans le dossier tex/
cd tex/

# Supprimer les fichiers temporaires LaTeX
rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.log *.out *.run.xml *.toc

# Supprimer les logs de threat hunting (optionnel)
rm -f stix_json_apt41/analyzer.log stix_json_apt41/hunt.log

# Retourner à la racine
cd ..
```

**Alternative**: Le fichier `.gitignore` exclut automatiquement ces fichiers, donc pas besoin de les supprimer manuellement.

### 6. Ajouter les fichiers au staging

```bash
# Ajouter tous les fichiers modifiés
git add .

# OU ajouter des fichiers spécifiques
git add tex/architecture_section.tex
git add tex/figures/nouveau_diagramme.png

# Vérifier ce qui sera commité
git status
```

### 7. Créer un commit

```bash
# Commit avec message descriptif
git commit -m "feat: Ajout de la détection RDP pour APT41

- Implémentation de la règle Wazuh pour T1021.001
- Ajout de requêtes Kestrel pour détection RDP
- Tests sur environnement de lab

Contributeur: Prénom NOM (Matricule: XXXXXXX)"
```

**Convention de messages de commit** (Conventional Commits):
- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation seulement
- `style:` Formatage, espaces, etc.
- `refactor:` Refactoring de code
- `test:` Ajout de tests
- `chore:` Tâches de maintenance

### 8. Pousser vers GitHub

```bash
# Première fois pour cette branche
git push -u origin feature/detection-wazuh

# Fois suivantes
git push
```

## Compilation du rapport LaTeX

### Avant de pousser, compiler et vérifier

```bash
cd tex/

# Compilation complète
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex

# Vérifier qu'il n'y a pas d'erreurs
# Le PDF doit être généré: main.pdf

# Retour à la racine
cd ..
```

### Que faire en cas d'erreur de compilation ?

1. **Erreur de référence manquante**:
   ```bash
   # Recompiler avec biber
   biber main
   pdflatex main.tex
   ```

2. **Erreur d'image manquante**:
   - Vérifier que l'image existe dans `tex/figures/`
   - Vérifier le chemin dans le `.tex`

3. **Erreur de package manquant**:
   ```bash
   # Installer le package (exemple pour TeX Live)
   tlmgr install <nom-du-package>
   ```

## Pull Request (PR)

### 1. Créer une Pull Request

1. Aller sur GitHub
2. Cliquer sur "Pull requests"
3. Cliquer sur "New pull request"
4. Sélectionner votre branche
5. Remplir le template de PR

### 2. Template de Pull Request

```markdown
## Description
Brève description des changements apportés.

## Type de changement
- [ ] Nouvelle fonctionnalité (feature)
- [ ] Correction de bug (fix)
- [ ] Documentation (docs)
- [ ] Refactoring (refactor)

## Sections du rapport modifiées
- [ ] État de l'art
- [ ] Architecture
- [ ] Règles Wazuh
- [ ] Requêtes Kestrel
- [ ] SOAR
- [ ] Annexes

## Tests effectués
- [ ] Compilation LaTeX réussie
- [ ] Scripts Python testés
- [ ] Notebooks Jupyter exécutés
- [ ] Règles Wazuh validées

## Contributeur
Prénom NOM (Matricule: XXXXXXX)

## Checklist
- [ ] Code propre et commenté
- [ ] Documentation à jour
- [ ] Pas de fichiers temporaires
- [ ] Commit messages clairs
```

### 3. Revue de code

Attendez que les autres membres du groupe ou le professeur examine votre PR avant de merger.

## Bonnes pratiques

### Commits

✅ **BON**:
```bash
git commit -m "feat: Ajout détection Pass-the-Hash (T1550.002)

- Règle Wazuh pour détection PTH
- Requête Kestrel avec corrélation événements
- Tests sur Windows Server 2022
- Documentation des faux positifs

Contributeur: Jean Dupont (Matricule: 12345678)"
```

❌ **MAUVAIS**:
```bash
git commit -m "update"
git commit -m "fix"
git commit -m "work in progress"
```

### Fichiers à inclure

✅ **À INCLURE**:
- `tex/*.tex` (fichiers LaTeX sources)
- `tex/figures/*.png, *.jpg, *.svg` (images)
- `tex/figures/*.py` (scripts)
- `tex/stix_json_apt41/*.ipynb` (notebooks)
- `tex/stix_json_apt41/*.ps1` (scripts PowerShell)
- `tex/*.bib` (bibliographies)
- `README.md`, `CONTRIBUTING.md`
- `.gitignore`

✅ **OPTIONNEL** (selon les besoins):
- `tex/main.pdf` (rapport compilé final)

❌ **À EXCLURE** (déjà dans .gitignore):
- `tex/*.aux, *.log, *.out` (fichiers temporaires LaTeX)
- `tex/stix_json_apt41/*.log` (logs de hunt)
- `tex/stix_json_apt41/*.hdf` (données volumineuses)
- Fichiers de configuration locale des éditeurs

### Branches

- **main**: Branche principale, toujours stable et fonctionnelle
- **develop**: Branche de développement (si utilisée)
- **feature/**: Branches de fonctionnalités individuelles
- **fix/**: Branches de correction de bugs

### Fréquence des commits

- Commit régulièrement (au moins après chaque session de travail)
- Ne pas attendre d'avoir tout terminé
- Chaque commit doit être logique et cohérent

## Résolution de conflits

### Si vous avez des conflits Git

```bash
# Récupérer les dernières modifications
git fetch origin

# Merger la branche main dans votre branche
git merge origin/main

# Git indiquera les fichiers en conflit
# Éditer les fichiers et résoudre les conflits manuellement
# Rechercher les marqueurs: <<<<<<< HEAD, =======, >>>>>>>

# Après résolution
git add <fichiers-resolus>
git commit -m "fix: Résolution des conflits avec main"
git push
```

## Synchronisation avec le dépôt

### Mettre à jour votre branche locale

```bash
# Récupérer les dernières modifications
git fetch origin

# Mettre à jour votre branche main locale
git checkout main
git pull origin main

# Retourner sur votre branche de travail
git checkout feature/votre-feature

# Intégrer les modifications de main
git merge main
```

## Commandes Git utiles

```bash
# Voir l'historique des commits
git log --oneline --graph --all

# Voir les différences avec une autre branche
git diff main..feature/votre-feature

# Annuler les modifications non commitées
git restore <fichier>

# Annuler le dernier commit (garde les modifications)
git reset --soft HEAD~1

# Voir qui a modifié quelle ligne
git blame <fichier>

# Rechercher dans l'historique
git log --grep="mot-clé"

# Voir les statistiques de contribution
git shortlog -sn
```

## Support et aide

### En cas de problème

1. **Problèmes Git**:
   - Consulter la documentation Git: https://git-scm.com/doc
   - Demander de l'aide à vos collègues

2. **Problèmes LaTeX**:
   - Vérifier les logs: `tex/main.log`
   - Stack Exchange TeX: https://tex.stackexchange.com/

3. **Problèmes Python/Notebooks**:
   - Vérifier les dépendances: `pip list`
   - Consulter la documentation Kestrel

### Contact

- **Professeur**: Daniel Migault
- **Cours**: INF808 - Université de Sherbrooke
- **Issues GitHub**: Créer une issue pour les bugs ou questions

## Checklist finale avant de pousser

- [ ] Code compilé/exécuté sans erreurs
- [ ] Fichiers temporaires nettoyés ou ignorés
- [ ] Commits avec messages clairs et descriptifs
- [ ] Contributions personnelles identifiées
- [ ] Documentation à jour
- [ ] README.md reflète les changements si nécessaire
- [ ] Tests effectués (si applicable)

---

**Merci de contribuer à ce projet de manière professionnelle et organisée !**
