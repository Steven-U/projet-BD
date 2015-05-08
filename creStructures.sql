/*
TABLE AVION
TABLE REVISION
TABLE PERSONNEL_SOL
TABLE PERSONNEL_NAV
TABLE MISSION
TABLE VOL
TABLE CLIENT
TABLE Reservation
TABLE EQUIPAGE_VOL
*/

--AVION

CREATE TABLE AVION (
	id 		  				NUMBER NOT NULL,
	immatriculation			NUMBER NOT NULL,
	type_avion  			varchar2(4),
	date_MS					DATE NOT NULL,
	nb_h_vol_dr				NUMBER,			
	capacite  				NUMBER NOT NULL,
	modele 	  				VARCHAR2(100),
	PRIMARY KEY (id)
);

--REVISION

CREATE TABLE REVISION (
	id 		  				NUMBER NOT NULL,
	id_av					NUMBER NOT NULL,
	date_rev				DATE NOT NULL,
	rapport					VARCHAR2(60) NOT NULL,	
	h_total_vol			NUMBER, --Coptabilise le nb d'heure de vol total de l'avion
	h_der_rev       NUMBER, --remis a zero a chaque revision, faire trigger sur ca +500h interdiction a l'id_av correspondant 
	nom_mecanicien			VARCHAR2(50),
	PRIMARY KEY (id),
	FOREIGN KEY (id_av) REFERENCES AVION(id) ON DELETE CASCADE
);

-- La législation aérienne impose une révision tous les 6 mois ou toutes les 500 heures --> TRIGGER
-- de vols sous peine d'interdiction de vol.                                            --> TRIGGER



-- A chaque révision, on enregistre la date                                            --> ID_AV
-- ainsi que l'ensemble des éléments ayant fait l'objet de contrôle voire de réparation.-->RAPPORT 
-- Après enregistrement également du nombre d'heures de vol au moment de la révision,   -->H_TOTAL_VOL
--le compteur du nombre d'heures de vols depuis la dernière révision de l'avion est remis Ã  zéro. --> H_DER_REV
--Le nom du mécanicien ayant effectué cette réparation est également enregistré.           -->NOM_MECANICIEN

--PERSONNELS DEUX TYPES NAVIGANT(NAV) ET SOL

-- personnel_sol

CREATE TABLE personnel_sol (
	id 		  NUMBER NOT NULL,
	nom  	  varchar2(100) NOT NULL,
	prenom    varchar2(100) NOT NULL,
	tel		  varchar2(100),
	adr		  varchar2(100),
	salaire   FLOAT DEFAULT 0,
	fonction  VARCHAR(50) NOT NULL CHECK (fonction IN('administratif', 'mécanicien')),
	date_emb  DATE NOT NULL,
	PRIMARY KEY (id)
  );

--personnels de Vol

CREATE TABLE personnel_nav (
	id 			NUMBER NOT NULL,
	nom  		varchar2(100) NOT NULL,
	prenom 		varchar2(100) NOT NULL,
	tel		  	varchar2(100),
	adr		  	varchar2(100),
	salaire 	FLOAT DEFAULT 0,
	fonction 	VARCHAR2(50) NOT NULL CHECK (fonction IN('pilote', 'Steward','Hotesse')),
	date_emb 	DATE NOT NULL,
	PRIMARY KEY (id)
);

--Client

CREATE TABLE Client (
	id 			NUMBER NOT NULL,
	nom  		varchar2(100) NOT NULL,
	prenom  	varchar2(100) NOT NULL,
	tel 		varchar2(100) NOT NULL,
	PRIMARY KEY (id)
);

--Mission

CREATE TABLE Mission (
	num 			NUMBER NOT NULL,
	num_vol  		varchar2(10) NOT NULL,
	date_depart 	DATE NOT NULL,
	h_dep 			NUMBER NOT NULL,
	id_avion 			NUMBER NOT NULL,
	ville_dep 		varchar2(50) NOT NULL,
	ville_arr 		varchar2(50) NOT NULL,
	PRIMARY KEY (num),
	FOREIGN KEY (id_avion) REFERENCES avion(id) ON DELETE CASCADE
);

--Vol

CREATE TABLE VOL (
	id 				NUMBER NOT NULL,
	num_vol  		varchar2(10) NOT NULL,
	date_depart 	DATE NOT NULL,
	avion 			NUMBER NOT NULL,
	ville_dep 		varchar2(50) NOT NULL,
	ville_arr 		varchar2(50) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (avion) REFERENCES avion(id)
); 


--Escale
CREATE TABLE escale (
	num 			NUMBER NOT NULL,
	num_mission  NUMBER NOT NULL,
	ville 			VARCHAR2(50) NOT NULL,
	h_arr 			NUMBER NOT NULL,
	duree 			NUMBER NOT NULL,
	PRIMARY KEY (num),
	FOREIGN KEY (num_mission) REFERENCES mission(num)
);

--RELATION ENTRE LES ENTITÃ‰S

--EQUIPAGE DE VOL - relation entre La table VOL et table PERSONNEL_VOL

CREATE TABLE Equipage_Vol (
	id_vol 			NUMBER NOT NULL,
	id_personnel 	NUMBER NOT NULL,
	PRIMARY KEY (id_vol, id_personnel),
	FOREIGN KEY (id_vol) REFERENCES vol(id) ON DELETE CASCADE, 
	FOREIGN KEY (id_personnel) REFERENCES personnel_nav(id) ON DELETE CASCADE
);

--Reservation

CREATE TABLE Reservation (
	id 					NUMBER NOT NULL,
	place 				NUMBER NOT NULL,
	id_client 			NUMBER NOT NULL,
	date_reservation 	DATE NOT NULL,
	id_vol 				NUMBER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_client) REFERENCES client(id) ON DELETE CASCADE,
	FOREIGN KEY (id_vol) REFERENCES vol(id) ON DELETE CASCADE
);
