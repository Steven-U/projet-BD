--Cette procédure affecte un avion à un vol donné.  
--Définissez la signature, les contrôles fonctionnels associés
CREATE OR REPLACE PROCEDURE P_AFFECTATION_AVION(numeroAvion NUMBER, numeroVol NUMBER)

;

--Cette procédure affecte un pilote à un vol donné. 
--Définissez la signature, les contrôles fonctionnels associés. 
--Donner un exemple de test avec un jeu de données pertinent pour ces procédures. 
CREATE OR REPLACE PROCEDURE P_AFFECTATION_PILOTE(numeroPilote NUMBER, numeroVol NUMBER)

;


--Les noms des passagers sont séparés par des points virgules. 
--P_RESERVATION(‘Créteil’, ‘Annecy’, ‘01/06/14’, 2, ‘Duchemin’, ‘Duchemin Paul ;Duchemin Virginie ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘06/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘07/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; 
-- On souhaitera faire en sorte dans les jeux de tests que l’avion soit déjà plein pour cette réservation. 
CREATE OR REPLACE PROCEDURE P_RESERVATION(villeOrigine VARCHAR2(30), villeDestination VARCHAR2(30), dateVol DATE, nombrePassagers NUMBER(2), nomClient VARCHAR2(30) , listePassager VARCHAR(30))

;

--Cette procédurehistorise les informations de réservation antérieures à une date donnée
CREATE OR REPLACE PROCEDURE P_HIST_RESERVATION(dateHisto DATE)
;

--Cette procédure met à jour chaque nuit les compteurs d’heures de vol du jour des avions, pilotes, stewards et hôtesses
CREATE OR REPLACE PROCEDURE P_MAJ_COMPTEURS
;
