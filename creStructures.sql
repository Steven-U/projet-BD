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

--REQUETE SQL

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1 ° ) Quelle est la date de la dernière révision et le nom du mécanicien l'ayant effectué de l'appareil immatriculé 2345297400 ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

Select date_rev, nom_mecanicien
From avion av, revision re
where av.id = re.id_av
and av.immatriculation = '2345297400' 
and date_rev = (Select max(date_rev) from revision);

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 ° ) Quel est le nom du salarié de la catégorie navigant ayant le plus gros salaire ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

	Select nom, prenom, salaire
	from personnel_nav
	where salaire = (Select max(salaire) from personnel_nav);

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 ° ) Quel est le nom du salarié le plus récemment embauché ? 
--------------------------------------------------------------------------------------------------------------------------------------------------------
	Select *
	from (											  
        Select nom, prenom, date_emb
        from personnel_nav
        union
        Select nom, prenom, date_emb
        from personnel_sol
        )	
        where date_emb = (Select max(date_emb) from ( Select personnel_nav.DATE_EMB from personnel_nav
                                                      union all
                                                      Select personnel_sol.DATE_EMB from personnel_sol));
                                                      
--------------------------------------------------------------------------------------------------------------------------------------------------------									  
-- 4 ° ) Quels sont les salaires moyens par fonction classés par ordre décroissants ? 
--------------------------------------------------------------------------------------------------------------------------------------------------------

	Select * 
  from (
        Select Round(avg(salaire),2) as moyenne,fonction
        from personnel_nav pn
        group by fonction
        union
        select Round(avg(salaire),2) as moyenne,fonction
        from personnel_sol ps
        group by fonction
        )
        order by moyenne desc;
        
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 ° ) Quelle est la mission de vol comportant le plus d'escales ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

	WITH TabCount AS
	(
	Select m.num, COUNT(*) AS N,
		   MAX(count(*)) OVER() AS maxi -- Over retourne toutes les valeurs max
	FROM   MISSION m, ESCALE e
	Where e.num_mission = m.num
	GROUP BY m.num)
	SELECT TabCount.num as Num_Mission, N as NB_escale
	FROM   TabCount
	WHERE  maxi = N;

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6 ° ) Quelle est la ville comportant le plus de mission de vols au départ et Ã  l'arrivée confondus ?
--------------------------------------------------------------------------------------------------------------------------------------------------------
  With Tot as
  (
	SELECT Ville, (count(num)) as NbMission
	FROM ( SELECT num, ville_arr as Ville
         FROM MISSION
         UNION
         SELECT num, ville_dep as Ville
         FROM MISSION )
  group by Ville 
  )
	Select *
  FROM Tot
  where NbMission = ( select max(NbMission) from Tot);

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7 ° ) Quel est le nom du pilote affecté au vol du 19 décembre 2014 au départ de Créteil Ã  10h00 ?
--------------------------------------------------------------------------------------------------------------------------------------------------------
 
 drop table equipage_vol;
 drop table vol cascade constraints;
 
CREATE TABLE VOL (
	id 				NUMBER NOT NULL,
	date_depart 	DATE NOT NULL,
	avion 			NUMBER NOT NULL,
	ville_dep 		varchar2(50) NOT NULL,
	ville_arr 		varchar2(50) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (avion) REFERENCES avion(id)
); 

CREATE TABLE Equipage_Vol (
	id_vol 			NUMBER NOT NULL,
	id_personnel 	NUMBER NOT NULL,
	PRIMARY KEY (id_vol, id_personnel),
	FOREIGN KEY (id_vol) REFERENCES vol(id) ON DELETE CASCADE, 
	FOREIGN KEY (id_personnel) REFERENCES personnel_nav(id) ON DELETE CASCADE
);
 
--Test
--Créteil à Annecy

INSERT INTO VOL VALUES('1','19/12/2014','1','Créteil','Annecy');
INSERT INTO VOL VALUES('2','08/05/2015','1','Créteil','Annecy');

insert into equipage_vol (id_vol,id_personnel) values(1,1);

	Select pn.nom, pn.prenom
	from Equipage_VOL ev, 
        vol v, 
        mission mis,
        personnel_nav pn
	where ev.id_vol = v.id
	and mis.num_vol = v.id
	and ev.id_personnel = pn.id
	and pn.fonction  = 'pilote'
	and v.date_depart = '19/12/2014'
	and mis.ville_dep like 'Créteil'
	and mis.h_dep = 10;

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 8 ° ) Quel est le prochain vol Ã  destination d'Annecy au départ de Créteil ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

	SELECT DISTINCT V.DATE_DEPART	
	FROM MISSION mis, VOL V, (
	SELECT E.NUM_MISSION AS numero, COUNT(E.NUM_MISSION) AS Nombre
	FROM ESCALE E
	GROUP BY E.NUM_MISSION
	HAVING COUNT( E.NUM_MISSION ) = 1
	)
	WHERE numero = mis.NUM
	AND mis.VILLE_DEP = 'Créteil';
	
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9 ° ) Quels sont les pilotes qui ne sont jamais allés Ã  Annecy ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO VOL VALUES(seqvol.nextval,'2','08/05/2015','2','Créteil','Brest');
INSERT INTO VOL VALUES(seqvol.nextval,'2','19/12/2014','1','Créteil','Annecy');
INSERT INTO equipage_vol (id_vol,id_personnel) values(2,2);

--MARCHE A PRIORI A TESTER 
  	SELECT distinct
		pn.nom, pn.prenom,
		M.num,
		M.ville_dep,
		M.ville_arr
	FROM
		personnel_nav pn, vol V, MISSION M, ESCALE E,EQUIPAGE_VOL ev
	Where 
	  pn.id = ev.ID_PERSONNEL
    and ev.id_vol = v.id
		and pn.fonction  = 'pilote'
		and M.ville_arr != 'Annecy'
		and E.num_mission = M.num (+);
	--	and E.ville != 'Annecy';

--------------------------------------------------------------------------------------------------------------------------------------------------------	
-- 10 ° ) Quels sont les vols au départ de Créteil ayant une escale maximum ?
--------------------------------------------------------------------------------------------------------------------------------------------------------
  With Tot as
  (
	SELECT Ville, (count(num)) as NbEscales
	FROM escale
  group by Ville 
  )
	Select vol.id
  FROM Tot, Vol
  where NbEscales = 1
  and Vol.ville_dep = 'Créteil';


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 11 ° ) Quels sont les vols ayant été effectués sans escale ?
--------------------------------------------------------------------------------------------------------------------------------------------------------

--MARCHE A PRIORI A TESTER 

	Select id
	from vol
	where num_mission not in (Select num_mission from escale);
  
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 12 ° ) Quels sont les avions actuellement en vol Ã  ce jour et cette heure ?
--------------------------------------------------------------------------------------------------------------------------------------------------------
--MARCHE

	Select type_avion
	from AVION a, vol v, mission m, escale e
	where m.num = v.num_mission
	and e.num_mission = m.num
	and a.id = v.avion
	and M.date_depart = to_char(sysdate,'DD/MM/YYYY')
	and TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) in m.h_dep;

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 13 ° ) Quelle est la liste des passagers du vol du 03/06/2014 entre Enghien et Annecy ?
--------------------------------------------------------------------------------------------------------------------------------------------------------
 

	Select c.nom,c.prenom
	from client c, Reservation r, mission m, vol v
	where c.id = r.id_client
	and r.id_vol = m.num
	and v.num_mission = m.num
	and m.date_depart = '03/06/2014'
	and m.ville_dep = 'Enghien'
	and m.ville_arr = 'Annecy';
