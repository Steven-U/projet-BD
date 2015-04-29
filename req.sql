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

--Quelle est la date de la dernière révision et le nom du mécanicien l'ayant effectué de l'appareil immatriculé 2345297400 ?

--Les deux marche, préférence pour la deuxieme

select max(date_rev), nom_mecanicien
from AVION av, REVISION rev
where av.id = rev.id_av
and av.immatriculation = '2345297400'
GROUP BY rev.date_rev, rev.nom_mecanicien

Select date_rev, nom_mecanicien
From avion av, revision re
where av.id = re.id_av
and av.immatriculation = '2345297400' 
and date_rev = (Select max(date_rev) from revision);

--Quel est le nom du salarié de la catégorie navigant ayant le plus gros salaire ?
--1ere semble de marcher

	Select nom, prenom
	from personnel_nav
	where salaire = (Select max(salaire) from personnel_nav)

--Quel est le nom du salarié le plus récemment embauché ? MARCHE PAS POUR LE MOMENT
	Select nom, prenom
	from personnel_nav, personnel_sol
	where date_emb = (Select max(date_emb) from personnel_nav,personnel_sol);

	--deuxième solution, parce qu'on avait pas spécifié à quelle table appartenait nom et prénom
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
												  Select personnel_sol.DATE_EMB from personnel_sol);
									  
--Quels sont les salaires moyens par fonction classés par ordre décroissants ? MARCHE PAS
	
	select * from
	(
	Select avg(salaire),fonction
	from personnel_nav
	group by fonction
	union
	select avg(salaire),fonction
	from personnel_sol
	group by fonction
	)
	order by avg(salaire) desc;

--Quelle est la mission de vol comportant le plus d'escales ?

	Requete 5 A REVOIR :
	Select *
	from (
	  select id_mission, count(id_mission)
	  from escale
	  group by id_mission 
	  order by count(id_mission) desc 
		  )
	where rownum >1 ;


	WITH A AS
	(
	Select m.num, COUNT(*) AS N,
		   MAX(count(*)) OVER() AS M -- Over retourne toutes les valeurs max
	FROM   MISSION m, ESCALE e
	Where e.num_mission = m.num
	GROUP BY m.num)
	SELECT M.num
	FROM   A
	WHERE  M = N;

--Quelle est la ville comportant le plus de mission de vols au départ et Ã  l'arrivée confondus ?

	--à finir...
	Select * FROM
	(
	SELECT num, ville_arr as Ville
	FROM MISSION
	UNION
	SELECT num, ville_dep as Ville
	FROM MISSION
	)
	Where Ville 

--Quel est le nom du pilote affecté au vol du 19 décembre 2014 au départ de Créteil Ã  10h00 ?

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

--Quel est le prochain vol Ã  destination d'Annecy au départ de Créteil ?








--Quels sont les pilotes qui ne sont jamais allés Ã  Annecy ?
	SELECT
		pn.nom, pn.prenom,
		M.num,
		M.ville_dep,
		M.ville_arr
	FROM
		personnel_nav pn, vol V, MISSION M, ESCALE E
	Where 
		pn.id = v.id (+)
		and pn.fonction  = 'pilote'
		and M.num = V.num_mission (+)
		and M.ville_arr != 'Annecy'
		and E.num_mission = M.num (+)
		and E.ville != 'Annecy';
	
--Quels sont les vols au départ de Créteil ayant une escale maximum ?







--Quels sont les vols ayant été effectués sans escale ?

	Select num_vol
	from vol
	where num_mission not in (Select num_mission from escale);

--Quels sont les avions actuellement en vol Ã  ce jour et cette heure ?

	Select type_avion
	from AVION a, vol v, mission m, escale e
	where m.num = v.num_mission
	and e.num_mission = m.num
	and a.id = v.avion
	and date_depart = to_char(sysdate,'DD/MM/YYYY')
	and TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) in m.h_dep;

--Quelle est la liste des passagers du vol du 03/06/2014 entre Enghien et Annecy ?

	Select c.nom,c.prenom
	from client c, Reservation r, mission m, vol v
	where c.id = r.id_client
	and r.id_vol = m.num
	and v.num_mission = m.num
	and m.date_depart = '03/06/2014'
	and m.ville_dep = 'Enghien'
	and m.ville_arr = 'Annecy';
