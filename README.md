# SQL-HR-Analytics-Portfolio
Analyse de données RH et de performance des départements utilisant SQL Server (CTE, Jointures, Agrégations).

# 📊 Analyse de Performance RH (Portfolio SQL)

## 🎯 Objectif du Projet
En tant que Data Analyst, j'ai simulé une mission d'audit pour le département des Ressources Humaines. L'objectif était d'analyser les coûts salariaux et la charge de travail (projets) par département afin d'identifier des déséquilibres potentiels.

## 🛠️ Compétences Techniques Mises en Œuvre
- **SQL Server (T-SQL)** : Environnement de base de données.
- **CTEs (Common Table Expressions)** : Utilisées pour isoler les calculs d'agrégation et éviter les doublons de lignes (problème du "Fan-out").
- **Jointures Complexes** : Utilisation de `LEFT JOIN` pour inclure les départements sans activité projet.
- **Nettoyage de Données** : Gestion des valeurs `NULL` avec `ISNULL`.
- **Reporting** : Création d'une table de synthèse automatisée.

## 💡 Résultats Clés (Insights)
1. **Disparités Salariales** : Le département Finance possède le salaire moyen le plus élevé, tandis que les fonctions supports sont en retrait.
2. **Charge Projet** : Le département IT gère le plus gros volume de projets actifs, ce qui pourrait justifier des recrutements futurs.

## 📂 Structure du Code
Le script `Rapport_Performance_RH.sql` contient la logique complète :
1. **Setup** : Nettoyage des tables existantes.
2. **Calculs** : CTEs séparés pour les salaires et les projets.
3. **Consolidation** : Jointure finale et tri des données.
