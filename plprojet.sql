--Cette procédure affecte un avion à un vol donné.  
--Définissez la signature, les contrôles fonctionnels associés
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

--Les noms des passagers sont séparés par des points virgules. 
--P_RESERVATION(‘Créteil’, ‘Annecy’, ‘01/06/14’, 2, ‘Duchemin’, ‘Duchemin Paul ;Duchemin Virginie ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘06/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘07/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; 
-- On souhaitera faire en sorte dans les jeux de tests que l’avion soit déjà plein pour cette réservation. 




--Cette procédure historise les informations de réservation antérieures à une date donnée
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

--Cette procédure met à jour chaque nuit les compteurs d’heures de vol du jour des avions, pilotes, stewards et hôtesses
