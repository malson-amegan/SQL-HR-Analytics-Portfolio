/*
TITRE DU PROJET : Rapport de Performance des Départements 
AUTEUR          : Malson AMEGAN
DATE            : 12/2025
DESCRIPTION     : Ce script génère une table de reporting analytique agrégée par département.
                  Il combine des données financières (Salaires) et opérationnelles (Projets).
    
LOGIQUE MÉTIER  :
    1. Calcul des métriques salariales (Moyenne, Total, Effectif).
    2. Calcul des métriques projets (Nombre de projets actifs).
    3. Utilisation de CTEs (Common Table Expressions) pour éviter la duplication 
       des lignes lors des jointures multiples.
*/


-- Vérifie si la table de résultat existe déjà et la supprime pour éviter les erreurs.
IF OBJECT_ID('WWW_RAPPORT_DE_PERFORMENCE_DEPT','U') IS NOT NULL
    DROP TABLE WWW_RAPPORT_DE_PERFORMENCE_DEPT;
GO 

    -- CTE 1 : CALCUL DES SALAIRES
    -- On isole ce calcul pour garantir l'intégrité des sommes.
    -- Chaque employé est compté une seule fois ici, peu importe son nombre de projets.
WITH SALAIRE_DEPART AS (
    SELECT
        EP.DEPARTEMENT,
        COUNT(DISTINCT EP.ID) AS NBRE_EMPLOYE,
        AVG(EP.SALAIRE) AS SALAIRE_MOYEN,
        SUM(EP.SALAIRE) AS MONTANT_TOTAL
    FROM EMPLOYE EP
    GROUP BY EP.DEPARTEMENT
),

    -- CTE 2 : COMPTAGE DES PROJETS
    -- On isole ce calcul pour gérer les relations "One-to-Many" (1 employé -> N projets).
    -- On utilise LEFT JOIN pour garder les départements sans projets.
PROJETS_DEPART AS (
    SELECT
        EP.DEPARTEMENT,
        COUNT(DISTINCT PJ.PROJET_ID) AS NBRE_PROJETS 
    FROM EMPLOYE EP
    LEFT JOIN PROJETS PJ 
        ON EP.ID = PJ.EMPLOYE_ID
    GROUP BY EP.DEPARTEMENT
)

-- FUSION ET CRÉATION DU RAPPORT FINAL
SELECT
    SD.DEPARTEMENT,
    SD.NBRE_EMPLOYE,
    SD.SALAIRE_MOYEN,
    SD.MONTANT_TOTAL,
    -- Remplacement des valeurs NULL par 0 pour un affichage propre
    ISNULL(PD.NBRE_PROJETS, 0) AS NBRE_PROJETS
INTO WWW_RAPPORT_DE_PERFORMENCE_DEPT -- Création automatique de la table cible
FROM SALAIRE_DEPART SD
LEFT JOIN PROJETS_DEPART PD
    ON SD.DEPARTEMENT = PD.DEPARTEMENT
ORDER BY SD.SALAIRE_MOYEN DESC;

-- Affichage 
SELECT * FROM WWW_RAPPORT_DE_PERFORMENCE_DEPT;
