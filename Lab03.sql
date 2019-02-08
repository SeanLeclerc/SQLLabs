--Sean Leclerc #2656477

--1
SELECT nom, description, c.code_table
FROM elements_menu em
INNER JOIN details_commande dc  ON em.id = dc.id_elements_menu
INNER JOIN commandes c ON c.id = dc.id_commandes
WHERE c.code_table = 'D3'

--2
SELECT em.description
FROM elements_menu em 
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
INNER JOIN ingredient i ON emi.id_ingredient = i.id
WHERE i.nom = 'Tomate'

--3 
SELECT COUNT(emi.id_ingredient) AS NbPlats, i.nom
FROM elements_menu em
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
INNER JOIN ingredient i ON emi.id_ingredient = i.id
GROUP BY i.id

--4 
SELECT DISTINCT em.nom, em.description
FROM elements_menu em
INNER JOIN details_commande dc  ON em.id = dc.id_elements_menu
INNER JOIN commandes c ON c.id = dc.id_commandes
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
INNER JOIN ingredient i ON emi.id_ingredient = i.id
WHERE c.code_table = 'A1' OR i.nom = 'Beurre'

--5
SELECT em.nom, em.description, SUM(dc.quantite) AS Quantite
FROM elements_menu em
INNER JOIN details_commande dc ON dc.id_elements_menu = em.id
GROUP BY em.nom
HAVING Quantite > 2
ORDER BY Quantite DESC

--6 
SELECT sections_menu.nom, COUNT(*)
FROM elements_menu
INNER JOIN sections_menu ON sections_menu.id = elements_menu.id_sections_menu
GROUP BY sections_menu.nom

--7
SELECT i.nom, COUNT(emi.id_ingredient) AS nbIngredient
FROM elements_menu em
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
INNER JOIN sections_menu sm ON sm.id = em.id_sections_menu
INNER JOIN ingredient i ON emi.id_ingredient = i.id
WHERE sm.nom = 'Dessert'
GROUP BY i.nom
ORDER BY nbIngredient DESC LIMIT 1

--8
SELECT i.nom, COUNT(emi.id_ingredient) AS nbIngredient
FROM elements_menu em
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
RIGHT JOIN ingredient i ON emi.id_ingredient = i.id
GROUP BY i.nom
HAVING nbIngredient = 0

--9
SELECT nom, COUNT(*)
FROM etats_commande
INNER JOIN commandes ON etats_commande.id = commandes.id_etats_commande
GROUP BY nom

--10
SELECT i.nom
FROM(
SELECT em.id, COUNT(dc.id_elements_menu) AS nbPlat
FROM elements_menu em
LEFT JOIN details_commande dc ON em.id = dc.id_elements_menu
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
INNER JOIN ingredient i ON i.id = emi.id_ingredient
GROUP BY em.id
HAVING nbPlat = 0 ) As plat
LEFT JOIN details_commande dc ON plat.id = dc.id_elements_menu
INNER JOIN elements_menu_ingredient emi ON plat.id = emi.id_elements_menu
INNER JOIN ingredient i ON i.id = emi.id_ingredient
GROUP BY i.nom
