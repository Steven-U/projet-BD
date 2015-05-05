

--Cette procédure affecte un avion à un vol donné.  
--Définissez la signature, les contrôles fonctionnels associés
CREATE OR REPLACE PROCEDURE P_AFFECTATION_AVION(numeroAvion NUMBER, numeroVol NUMBER) IS

declare
CURSOR c1 is select num from avion;


BEGIN
for  in c1 loop
end loop;
DBms_output.put_line();

end
;


--Cette procédure affecte un pilote à un vol donné. 
--Définissez la signature, les contrôles fonctionnels associés. 
--Donner un exemple de test avec un jeu de données pertinent pour ces procédures. 
CREATE OR REPLACE PROCEDURE P_AFFECTATION_PILOTE(numeroPilote NUMBER, numeroVol NUMBER)

BEGIN

Insert into 

DECLARE

END
;


--Les noms des passagers sont séparés par des points virgules. 
--P_RESERVATION(‘Créteil’, ‘Annecy’, ‘01/06/14’, 2, ‘Duchemin’, ‘Duchemin Paul ;Duchemin Virginie ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘06/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; -- résultat réservation OK 
--P_RESERVATION(‘Enghien’,’Trouville’, ‘07/06/14’, 2,‘Durand’, ‘Durand René ;Durand Hélène ;’) ; 
-- On souhaitera faire en sorte dans les jeux de tests que l’avion soit déjà plein pour cette réservation. 
CREATE OR REPLACE PROCEDURE P_RESERVATION(villeOrigine VARCHAR2(30), villeDestination VARCHAR2(30), dateVol DATE, nombrePassagers NUMBER(2), nomClient VARCHAR2(30) , listePassager VARCHAR(30))

DECLARE

//

CURSOR c1 IS
select ;

BEGIN

open c1;
loop
  fetch c1 into 
  exit when c1%notfound;
end loop
close c1;



DBms_output.put_line('résultat ok');


close c1

;

--Cette procédure historise les informations de réservation antérieures à une date donnée
CREATE OR REPLACE PROCEDURE P_HIST_RESERVATION(dateHisto DATE)

DECLARE

CURSOR c1 IS
select ;

BEGIN

open c1;
loop
  fetch c1 into 
  exit when c1%notfound;
end loop
close c1;

CREATE TABLE Hist_Reservation(dateHisto Date);


END
;


--Cette procédure met à jour chaque nuit les compteurs d’heures de vol du jour des avions, pilotes, stewards et hôtesses
CREATE OR REPLACE PROCEDURE P_MAJ_COMPTEURS IS

BEGIN



;
