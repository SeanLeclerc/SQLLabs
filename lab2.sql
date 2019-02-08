--No 1. idk if works
DROP DATABASE IF EXISTS gestion_employe;

--No 2. 
CREATE DATABASE gestion_employe CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;

--N0. 3
USE gestion_employe;
CREATE TABLE employe(
        id_employe INT AUTO_INCREMENT,
        nom VARCHAR(50) NOT NULL,
        prenom VARCHAR(50) NOT NULL,
        date_embauche DATE,
        salaire DOUBLE,
        id_superviseur INT,
        id_departement INT,
        CONSTRAINT pk_employe PRIMARY KEY(id_employe)
        );

--No.4 
USE gestion_employe;
CREATE TABLE formation(
		id_formation INT AUTO_INCREMENT,
		nom VARCHAR(50) NOT NULL,
		sujet VARCHAR(50) NOT NULL,
		date DATE NOT NULL,
		CONSTRAINT pk_formation PRIMARY KEY(id_formation)
		);

--No.5
USE gestion_employe;
CREATE TABLE formation_employe(
id_formation INT AUTO_INCREMENT,
id_employe INT,
CONSTRAINT pk_formation_employe PRIMARY KEY(id_formation,id_employe),
CONSTRAINT fk_formation FOREIGN KEY(id_formation) 
REFERENCES formation(id_formation) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_employe FOREIGN KEY(id_employe) 
REFERENCES employe(id_employe)
ON DELETE RESTRICT 
ON UPDATE CASCADE
);

-- No 6.
DROP TABLE IF EXISTS type_conge;
CREATE TABLE type_conge(
	id_type_conge INT AUTO_INCREMENT,
	nom VARCHAR(25) NOT NULL,
	CONSTRAINT pk_type_conge PRIMARY KEY (id_type_conge)
	);

	-- No 7.
DROP TABLE IF EXISTS vacances;
CREATE TABLE vacances(
	id_vacances INT AUTO_INCREMENT,
	date_debut DATE NOT NULL,
	date_fin DATE NOT NULL,
	explication TINYTEXT,
	id_type_conge INT,
	id_employe INT,
	CONSTRAINT pk_id_vacances PRIMARY KEY (id_vacances),
	CONSTRAINT fk_type_conge FOREIGN KEY(id_type_conge) REFERENCES type_conge(id_type_conge) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_employe FOREIGN KEY(id_employe) REFERENCES employe(id_employe) ON DELETE RESTRICT ON UPDATE CASCADE
	);

	-- No. 8
DROP TABLE IF EXISTS departement;
CREATE TABLE departement(
	id_departement INT AUTO_INCREMENT,
	nom VARCHAR(25) NOT NULL,
	description TINYTEXT,
	CONSTRAINT pk_departement PRIMARY KEY (id_departement)
);

-- No 9.
ALTER TABLE employe ADD FOREIGN KEY (id_departement) REFERENCES departement(id_departement) ON DELETE RESTRICT ON UPDATE CASCADE;

-- No 10.
ALTER TABLE employe ADD FOREIGN KEY (id_superviseur) REFERENCES  employe(id_employe) ON DELETE SET NULL ON UPDATE CASCADE;

-- No 11.
DROP TABLE IF EXISTS projet;
CREATE TABLE projet(
	id_projet INT AUTO_INCREMENT,
	nom VARCHAR(25),
	description TINYTEXT,
	CONSTRAINT pk_projet PRIMARY KEY (id_projet)
);

-- No 12.
DROP TABLE IF EXISTS role;
CREATE TABLE role(
	id_role INT AUTO_INCREMENT,
	nom VARCHAR(25),
	description TINYTEXT,
	CONSTRAINT pk_role PRIMARY KEY (id_role)
);

-- No 13.
DROP TABLE IF EXISTS projet_employe;
CREATE TABLE projet_employe(
	id_projet INT,
	id_employe INT,
	id_role INT,
	CONSTRAINT fk_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_employe FOREIGN KEY (id_employe) REFERENCES employe(id_employe) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_role FOREIGN KEY (id_role) REFERENCES role(id_role) ON DELETE RESTRICT ON UPDATE CASCADE

	);

--No 14.

INSERT INTO departement(nom, description)
VALUES('Ressource informatique', 'Gestion des infrastructures informatiques');

INSERT INTO departement(nom, description)
VALUES('Ressource humaine', 'Gestion des ressources humaines');

--No 15.


INSERT INTO employe(nom, prenom, date_embauche, salaire, id_superviseur, id_departement)
VALUES('Boucher', 'Amélie', '2009-02-25', '85000', NULL, '1');
INSERT INTO employe(nom, prenom, date_embauche, salaire, id_superviseur, id_departement)
VALUES('Roy', 'Maxime', '2009-02-20', '83000', NULL, '2');
INSERT INTO employe(nom, prenom, date_embauche, salaire, id_superviseur, id_departement)
VALUES('Tremblay', 'Jacques', '2015-05-18', '49500', '1', '1');
INSERT INTO employe(nom, prenom, date_embauche, salaire, id_superviseur, id_departement)
VALUES('Robert', 'Jocelyne', '2014-11-01', '61000', '1', '1');
INSERT INTO employe(nom, prenom, date_embauche, salaire, id_superviseur, id_departement)
VALUES('Gagnon', 'Jacynthe', '2017-10-05', '52000', '2', '2');

--No 16.

INSERT INTO formation(nom, sujet, date)
VALUES('Communication 101', 'La communication', '2009-03-04');
INSERT INTO formation(nom, sujet, date)
VALUES('Informatique pour les nuls', 'Linformatique', '2016-07-25');

--No 17.

INSERT INTO formation_employe(id_employe, id_formation)
VALUES('2', '1');
INSERT INTO formation_employe(id_employe, id_formation)
VALUES('3', '2');
INSERT INTO formation_employe(id_employe, id_formation)
VALUES('4', '2');

--No 18.

DELETE FROM formation_employe WHERE id_employe = 2 AND id_employe = 4


--No 19.

UPDATE employe
SET salaire = '56350'
WHERE salaire = '52000';

--No 20(7).

SELECT * FROM employe
ORDER BY date_embauche ASC; --plus vieux au plus jeunes. 

--No 21.

SELECT MIN(salaire) AS alias_minimum, MAX(salaire) As alias_maximum FROM employe;

--No 22.

SELECT COUNT(*) AS alias_nbEmploye, AVG(salaire)
FROM employe;

--No 23.

SELECT * FROM employe WHERE id_superviseur Is NULL

--No 24.

SELECT * FROM employe WHERE prenom like 'J%'

--No 25.

SELECT * FROM employe
WHERE date_embauche BETWEEN '2014-01-01' AND '2016-01-01';

--No 26.

SELECT * FROM employe
WHERE id_departement LIKE '1'

--No 27.

SELECT * FROM employe
WHERE salaire < '80000'






