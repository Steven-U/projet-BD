--Cette procédure affecte un avion à un vol donné.  
--Définissez la signature, les contrôles fonctionnels associé
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_AFFECTATION_AVION(numeroAvion NUMBER, numeroVol NUMBER) AS
BEGIN
  Update vol
  set vol.AVION = numeroAvion
  Where vol.id = numeroVol;
  EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('SQLCODE:'||SQLCODE||'SQLERROR:'||SQLERRM);
  RAISE_APPLICATION_ERROR(-20000,'Vérifier l existence de l avion ainsi que le vol');
  END;
--EXECUTION DE LA PROCEDURE AJOUTE BIEN L'AVION id 3 AU VOL 1904
EXEC  P_AFFECTATION_AVION(3,5);

--Cette procédure affecte un pilote à un vol donné. 
--Définissez la signature, les contrôles fonctionnels associés. 
--Donner un exemple de test avec un jeu de données pertinent pour ces procédures. 
CREATE OR REPLACE PROCEDURE P_AFFECTATION_Pilote(numeroPilote NUMBER, numeroVol NUMBER) AS
BEGIN
  Update equipage_vol
  set id_vol = numeroAvion, id_personnel = numeroPilote;
  END;
EXEC  P_AFFECTATION_Pilote(1,1);

----------------------------------------------------------------------------------------------------------------------------
--Les noms des passagers sont séparés par des points virgules. 
--P_RESERVATION('Créteil', 'Annecy', '01/06/14', 2, 'Duchemin', 'Duchemin Paul ;Duchemin Virginie ;') ; -- résultat réservation OK 
--P_RESERVATION('Enghien','Trouville', '06/06/14', 2,'Durand', 'Durand René ;Durand Hélène ;') ; -- résultat réservation OK 
--P_RESERVATION('Enghien','Trouville', '07/06/14', 2,'Durand', 'Durand René ;Durand Hélène ;') ; 
-- On souhaitera faire en sorte dans les jeux de tests que l'avion soit déjà plein pour cette réservation. 
----------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE P_RESERVATION
(
	villeOrigine reservation.villeOrigine%type, 
	villeDestination reservation.villeDestination%type, 
	dateVol reservation.dateVol%type, 
	nombrePassagers reservation.nombrePassagers%type, 
	nomClient reservation.nomClient%type, 
	listePassager reservation.listePassager%type
	)  
AS
  v_num_mission     INTEGER;
  v_id_avion       INTEGER;
  v_capacite_max      INTEGER;
  v_place_dispo    INTEGER;
  v_nbPassagers INTEGER;
  tot_place   INTEGER;
  
  CURSOR c1(c_villeOrigine reservation.villeOrigine%type, c_villeDestination reservation.villeDestination%type, c_dateVol reservation.dateVol%type)
    IS
    SELECT nombrePassagers
    FROM reservation
    WHERE dateVol = c_dateVol
    AND villeOrigine = c_villeOrigine
    AND villeDestination = c_villeDestination;
BEGIN
  SELECT num
  INTO v_num_mission
  FROM mission
  WHERE ville_dep = villeOrigine
  AND ville_arr = villeDestination;
  
  SELECT id
  INTO v_id_avion
  FROM vol
  WHERE Date_depart = datevol
  AND ID_MISSION = v_num_mission;
  
  SELECT capacite
  INTO v_capacite_max
  FROM avion
  WHERE id = (SELECT id FROM avion WHERE id = v_id_avion);
  dbms_output.put_line('Capacité maximale de l avion : ' || v_capacite_max);
  
  tot_place := 0;
  OPEN c1(villeOrigine,villeDestination,dateVol);
  LOOP
    FETCH c1 INTO v_nbPassagers;
    EXIT
  WHEN c1%notfound;
  tot_place := tot_place + v_nbPassagers;
  END LOOP;
  CLOSE c1;

  IF (v_capacite_max-tot_place) = 0 THEN
        dbms_output.put_line('Plus de places disponibles pour cet avion.');
  ELSE INSERT INTO reservation VALUES(
                                  villeOrigine , 
                                  villeDestination , 
                                  dateVol , 
                                  nombrePassagers, 
                                  nomClient, 
                                  listePassager
                  );
  dbms_output.put_line('Réservation OK');
  END IF;
END;
P_RESERVATION('Créteil', 'Annecy', '01/06/2014', 2, 'Duchemin','Duchemin Paul','Duchemin Virginie');
P_RESERVATION('Enghien','Trouville', '06/06/2014', 2,'Durand', 'Durand René','Durand Hélène'); 
P_RESERVATION('Enghien','Trouville', '07/06/2014', 2,'Durand', 'Durand René','Durand Hélène'); 

----------------------------------------------------------------------------------------------------------------------------
--Cette procédure historise les informations de réservation antérieures à une date donnée
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_HIST_RESERVATION(
    dateHisto DATE)
AS
  v_res reservation%rowtype;
  CURSOR c1(c_dateHisto DATE)
  IS
    SELECT * FROM reservation WHERE date_reservation = c_dateHisto;
BEGIN
  OPEN c1(dateHisto);
  LOOP
    FETCH c1 INTO v_res;
    EXIT
  WHEN c1%notfound;
    dbms_output.put_line(v_res.ville_dep || ' ' ||v_res.ville_arr||' '||v_res.date_reservation
    ||' '||v_res.id_vol||' '||v_res.id_client);
  END LOOP;
  CLOSE c1;
END;

SET serveroutput ON;
CALL P_HIST_RESERVATION('01/01/2014');

--Cette procédure met à jour chaque nuit les compteurs d'heures de vol du jour des avions, pilotes, stewards et hôtesses
