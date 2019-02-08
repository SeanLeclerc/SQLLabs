--Sean Leclerc
--2656477

--1
CREATE TABLE elements_menu_copie(
	id int,
	id_sections_menu int,
	nom varchar(50),
	description TEXT(50),
	CONSTRAINT pk_id primary key(id)
);

--2
DELIMITER  //
CREATE TRIGGER ajouter_copie
AFTER INSERT ON elements_menu FOR EACH ROW 
BEGIN 
	INSERT INTO elements_menu_copie (id, id_sections_menu, nom, description)
	VALUES (NEW.id, NEW.id_sections_menu, NEW.nom, NEW.description);
END//

--3
DELIMITER  //
CREATE TRIGGER supprimer_copie
AFTER DELETE ON elements_menu FOR EACH ROW 
BEGIN 
	DELETE FROM elements_menu_copie
	where id = OLD.id;
END//

--4
DELIMITER  //
CREATE TRIGGER modifier_copie
AFTER UPDATE ON elements_menu FOR EACH ROW 
BEGIN 
	UPDATE elements_menu_copie
	SET id = NEW.id, id_sections_menu = NEW.id_sections_menu, nom = NEW.nom, desciption = NEW.description;
END//

--5
ALTER TABLE elements_menu
ADD nb_ingredients int default 0;

--6
UPDATE elements_menu em
INNER JOIN elements_menu_ingredient emi ON em.id = emi.id_elements_menu
SET nb_ingredients = (
SELECT COUNT(id_elements_menu)
FROM elements_menu_ingredient emi
WHERE emi.id_elements_menu = em.id
)
WHERE em.id = emi.id_elements_menu;

--7
DELIMITER  //
CREATE TRIGGER ajouter_ingredient
AFTER INSERT ON elements_menu_ingredient FOR EACH ROW
BEGIN
	UPDATE elements_menu
	SET nb_ingredients = (
SELECT COUNT(id_elements_menu)
	FROM elements_menu_ingredient
	WHERE id_elements_menu = NEW.id_elements_menu)
WHERE id = NEW.id_elements_menu;
END//

--8
DELIMITER  //
CREATE TRIGGER supprimer_ingredient
AFTER DELETE ON elements_menu_ingredient FOR EACH ROW
BEGIN
	UPDATE elements_menu
	SET nb_ingredients = (
SELECT COUNT(id_elements_menu)
	FROM elements_menu_ingredient
	WHERE id_elements_menu = OLD.id_elements_menu)
WHERE id = OLD.id_elements_menu;
END//

--9
DELIMITER  //
CREATE TRIGGER modifier_ingredient
AFTER UPDATE ON elements_menu_ingredient FOR EACH ROW
BEGIN
	UPDATE elements_menu
	SET nb_ingredients = (
SELECT COUNT(id_elements_menu)
	FROM elements_menu_ingredient
	WHERE id_elements_menu = OLD.id_elements_menu)
WHERE id = OLD.id_elements_menu;
	UPDATE elements_menu
	SET nb_ingredients = (
SELECT COUNT(id_elements_menu)
	FROM elements_menu_ingredient
	WHERE id_elements_menu = NEW.id_elements_menu)
WHERE id = NEW.id_elements_menu;
END//

--10
CREATE VIEW commande_avec_etat AS
SELECT commandes.id, code_table, etats_commande.nom  
FROM commandes
INNER JOIN etats_commande ON etats_commande.id = commandes.id_etats_commande

--11
--Non car il n'a pas de données dans un view.
--DELETE FROM commande_avec_etat
--  WHERE commandes.id;
  
 --12
--Oui 
 
--13
--Non

--14
--Non

--15
CREATE VIEW plus_grand_moyenne AS
SELECT em.nom, em.nb_ingredients
FROM elements_menu em
WHERE em.nb_ingredients > 
(SELECT AVG(nb_ingredients) FROM elements_menu)


 
