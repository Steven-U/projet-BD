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

-- 1 ° ) Quelle est la date de la dernière révision et le nom du mécanicien l'ayant effectué de l'appareil immatriculé 2345297400 ?

--Les deux marche, préférence pour la deuxieme

select max(date_rev), nom_mecanicien
from AVION av, REVISION rev
where av.id = rev.id_av
and av.immatriculation = '2345297400'
GROUP BY rev.date_rev, rev.nom_mecanicien;

Select date_rev, nom_mecanicien
From avion av, revision re
where av.id = re.id_av
and av.immatriculation = '2345297400' 
and date_rev = (Select max(date_rev) from revision);

-- 2 ° ) Quel est le nom du salarié de la catégorie navigant ayant le plus gros salaire ?
-- marche

	Select nom, prenom
	from personnel_nav
	where salaire = (Select max(salaire) from personnel_nav);

-- 3 ° ) Quel est le nom du salarié le plus récemment embauché ? MARCHE PAS POUR LE MOME

-- MARCHE PAS, PEUT ETRE SUPPRIIMER AVEC VERIF DE LA DEUXIEME
	Select nom, prenom
	from personnel_nav, personnel_sol
	where date_emb = (Select max(date_emb) from personnel_nav,personnel_sol);

	--deuxième solution, parce qu'on avait pas spécifié à quelle table appartenait nom et prénom
  
  --MARCHE 
  
  
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
									  
-- 4 ° ) Quels sont les salaires moyens par fonction classés par ordre décroissants ? 


--MARCHE, passer par un alias sur avg(salaire) sinon erreur invalied identifer sur salaire Il ne reconnait pas quelle salaire donc avec alias ca passe
	
	select * 
  from (
        Select avg(salaire) as moyenne,fonction
        from personnel_nav pn
        group by fonction
        union
        select avg(salaire) as moyenne,fonction
        from personnel_sol ps
        group by fonction
        )
        order by moyenne desc;
        

-- 5 ° ) Quelle est la mission de vol comportant le plus d'escales ?

--	Requete 5 A REVOIR : BRICOLE POUR OVTENIR LE PREMIER RESULTAT, SI PLUSIEUR MISSION ON LE MAX DESCALE RESSORT QUE LA PREMIERE LIGNE
  
  
	Select *
	from (
	  select num_mission, count(num_mission)
	  from escale
	  group by num_mission 
	  order by count(num_mission) desc ;
		  )
	where rownum >1 ;

--MARCHE PAS. JCOMPREND PAS LE CODE LA(TUGAY) 

	WITH Apopo AS
	(
	Select m.num, COUNT(*) AS N,
		   MAX(count(*)) OVER() AS maxi -- Over retourne toutes les valeurs max
	FROM   MISSION m, ESCALE e
	Where e.num_mission = m.num
	GROUP BY m.num)
	SELECT Apopo.num
	FROM   Apopo
	WHERE  maxi = N;

-- 6 ° ) Quelle est la ville comportant le plus de mission de vols au départ et Ã  l'arrivée confondus ?

	--à finir...
  
	Select * FROM
	(
	SELECT num, ville_arr as Ville
	FROM MISSION
	UNION
	SELECT num, ville_dep as Ville
	FROM MISSION
	)
	Where max(count(*))

-- 7 ° ) Quel est le nom du pilote affecté au vol du 19 décembre 2014 au départ de Créteil Ã  10h00 ?

--MARCHE A PRIORI A TESTER 

	Select nom, prenom
	from Equipage_VOL ev, VOL v, mission m, personnel_nav pn
	where ev.id_vol = v.id
	and m.num_vol = v.id
	and v.num_mission = m.num
	and ev.id_personnel = pn.id
	and pn.fonction  = 'pilote'
	and v.date_depart = '19/12/2014'
	and m.ville_dep = 'Créteil'
	and m.h_dep = 10;

-- 8 ° ) Quel est le prochain vol Ã  destination d'Annecy au départ de Créteil ?

	-- MARCHE
	SELECT DISTINCT V.DATE_DEPART
	
	FROM MISSION M, VOL V, (
	SELECT E.NUM_MISSION AS numero, COUNT(E.NUM_MISSION) AS Nombre
	FROM ESCALE E
	GROUP BY E.NUM_MISSION
	HAVING COUNT( E.NUM_MISSION ) = 1
	)
	
	WHERE numero = M.NUM
	AND M.VILLE_DEP = 'Créteil'
	AND M.NUM = V.NUM_MISSION;
	-- MARCHE

-- 9 ° ) Quels sont les pilotes qui ne sont jamais allés Ã  Annecy ?

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
    and ev.id_vol = v.num_vol
		and pn.fonction  = 'pilote'
		and M.num = V.num_mission (+)
		and M.ville_arr != 'Annecy'
		and E.num_mission = M.num (+);
	--	and E.ville != 'Annecy';
	
-- 10 ° ) Quels sont les vols au départ de Créteil ayant une escale maximum ?

--MARCHE PAS A ADAPTER

SELECT MIS.NUM_VOL, MIS.VILLE_DEP, MAX(COUNT(*)) 
FROM MISSION MIS, VOL V, ESCALE E
WHERE MIS.NUM_VOL = V.NUM_VOL
AND MIS.VILLE_DEP = 'CRETEIL'
GROUP BY MIS.VILLE_DEP ;
--2EME SOLUTION juste u ntest
SELECT MAX(COUNT(*)),MIS.VILLE_DEP
FROM ESCALE E, MISSION MIS
WHERE E.NUM_MISSION = MIS.NUM
GROUP BY MIS.VILLE_DEP ;




-- 11 ° ) Quels sont les vols ayant été effectués sans escale ?

--MARCHE A PRIORI A TESTER 

	Select num_vol
	from vol
	where num_mission not in (Select num_mission from escale);

-- 12 ° ) Quels sont les avions actuellement en vol Ã  ce jour et cette heure ?

--MARCHE A TESTER, PROBLEME AMBIGUITI AU DEPART SUR DATE_DEPART AVANT DERNIERE CONDITION. RESOLU CAR DEF SUR MISSION M CAR PLUS PETITE MAILLE QUE VOL 

	Select type_avion
	from AVION a, vol v, mission m, escale e
	where m.num = v.num_mission
	and e.num_mission = m.num
	and a.id = v.avion
	and M.date_depart = to_char(sysdate,'DD/MM/YYYY')
	and TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) in m.h_dep;

-- 13 ° ) Quelle est la liste des passagers du vol du 03/06/2014 entre Enghien et Annecy ?

--MARCHE A PRIORI A TESTER 

	Select c.nom,c.prenom
	from client c, Reservation r, mission m, vol v
	where c.id = r.id_client
	and r.id_vol = m.num
	and v.num_mission = m.num
	and m.date_depart = '03/06/2014'
	and m.ville_dep = 'Enghien'
	and m.ville_arr = 'Annecy';
