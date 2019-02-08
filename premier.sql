CREATE DATABASE compagnie CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


--DROP TABLE client; enleve la table client
USE compagnie;
DROP TABLE client;
CREATE TABLE client(
	id_client INT NOT NULL AUTO_INCREMENT, 
	prenom VARCHAR(50) NOT NULL,
	nom VARCHAR(50) NOT NULL,
	adresse VARCHAR(50),

	CONSTRAINT pk_client PRIMARY KEY(id_client)

);

	--CONSTRAINT uq_nom UNIQUE(prenom, nom)
	--CONSTRAINT ck_id_client CHECK(id_client >= 0 AND id_client <= 100)
DROP TABLE commande
CREATE TABLE commande (
	id_commande INT NOT NULL AUTO_INCREMENT,
	id_client INT NOT NULL,
	prix_total FLOAT NOT NULL,
	date DATE,
	CONSTRAINT pl_commande PRIMARY KEY(id_commande),
	CONSTRAINT FK_CLIENT_COMMANDE FOREIGN KEY(id_client)
		REFERENCES client(id_client)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
		);


--TRUNCATE TABLE client;
--ALTER TABLE DROP CONSTRAINT uq_nom;
ALTER TABLE client DROP PRIMARY KEY
ALTER TABLE client ADD telephone CHAR(11);
ALTER TABLE client MODIFY telephone INT;
ALTER TABLE client DROP telephone;

ALTER TABLE client DROP INDEX idx_prenom;
CREATE INDEX idx_prenom_nom ON client (prenom, nom)
