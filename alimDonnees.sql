
 
--AVION : 5 appareils
INSERT INTO AVION (id,immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'2345297400','A231','01/01/2015','0','150','A231');
INSERT INTO AVION (id, immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'8798124687','B522','01/01/2012','20','100','B522');
INSERT INTO AVION (id, immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'8798124687','B522','01/01/2012','20','100','B522');
INSERT INTO AVION (id, immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'4578932161','A320','01/03/2013','150','150','A320');
INSERT INTO AVION (id, immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'6578421349','B650','01/01/2014','300','200','B650');
INSERT INTO AVION (id, immatriculation,type_avion,date_MS,nb_h_vol_dr,capacite,modele) VALUES (SEQAVION.nextval,'5784932421','A320','01/02/2014','100','100','A320');
  
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Fernando','Alonso','0102030405','1 rue de Paris','3000','pilote','01/02/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Jules', 'Bianchi','0103030406','2 rue de Paris','3200','pilote','01/01/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Sebastian','Vettel','0102030608','3 rue de Paris','3500','pilote','01/03/2013');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Michael' ,'Schumacher','0108721674','4 rue de Paris','4000','pilote','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Lewis', 'Hamilton','0102030907','5 rue de Paris','2800','pilote','01/02/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Alain','Prost','0198730420','6 rue de Paris','4000','pilote','01/08/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Kimi', 'Räikkönen','0103065420','7 rue de Paris','4000','pilote','01/12/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Felipe', 'Massa','0109030420','8 rue de Paris','3600','pilote','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Mark', 'Webber','0103030460','9 rue de Paris','2900','pilote','01/04/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Jenson', 'Button','0103030460','10 rue de Paris','3200','pilote','01/09/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Sébastien', 'Bourdais','0103030460','11 rue de Paris','2300','pilote','01/01/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Romain', 'Grosjean','0103030460','12 rue de Paris','2400','pilote','01/05/2014');

--personnel nol : 15 Hotesses/Stewards
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqpersnav.nextval,'Scarlett','Johansson','0102030405','1 rue de Paris','3000','Hotesse','01/02/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Cameron', 'Diaz','0103030406','2 rue de Paris','2000','Hotesse','01/01/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqpersnav.nextval,'Natalie', 'Portman','0102030608','3 rue de Paris','1900','Hotesse','01/03/2013');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Marion' ,'Cotillard','0108721674','4 rue de Paris','2500','Hotesse','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqpersnav.nextval,'Penélope', 'Cruz','0102030907','5 rue de Paris','2800','Hotesse','01/02/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Monica','Bellucci','0198730420','6 rue de Paris','2500','Hotesse','01/08/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Julia', 'Roberts','0103065420','7 rue de Paris','4000','Hotesse','01/12/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Nicole', 'Kidman','0109030420','8 rue de Paris','2400','Hotesse','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Angelina', 'Jolie','0103030460','9 rue de Paris','2300','Hotesse','01/04/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Michelle', 'Pfeiffer','0103030460','10 rue de Paris','2200','Hotesse','01/09/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval, 'Sharon', 'Stone','0103029460','11 rue de Paris','2300','Hotesse','01/01/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Jennifer', 'Lawrence','0103300460','12 rue de Paris','2400','Hotesse','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval, 'George', 'Clooney','0103030460','13 rue de Paris','2300','Steward','01/01/2015');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Jean', 'Dujardin','0103037460','14 rue de Paris','2000','Steward','01/05/2014');
INSERT INTO personnel_nav (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqpersnav.nextval,'Matt', 'Damon','0103036514','15 rue de Paris','3000','Steward','01/06/2014');



--3 mécaniciens et 4 administratifs.
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqperssol.nextval,'Bob','Johansson','0102030405','1 rue de Paris','1200','mécanicien','01/02/2014');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqperssol.nextval,'Simon', 'Diaz','0103030406','2 rue de Paris','1500','mécanicien','01/01/2014');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqperssol.nextval,'Fred', 'Portman','0102030608','3 rue de Paris','1900','mécanicien','01/03/2013');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqperssol.nextval,'Anna' ,'Tomie','0108721674','4 rue de Paris','2000','administratif','01/05/2014');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES(seqperssol.nextval,'David', 'Luiz','0102030907','5 rue de Paris','2500','administratif','01/02/2015');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqperssol.nextval,'Allen','Fétid','0198730420','6 rue de Paris','2800','administratif','01/08/2014');
INSERT INTO personnel_sol  (id,prenom,nom,tel,adr,salaire,fonction,date_emb) VALUES (seqperssol.nextval,'Al', 'Dente','0103065420','7 rue de Paris','3000','administratif','01/12/2014');

--Clients : 3
INSERT INTO client(id,prenom,nom,tel) values (seqclient.nextval, 'Jean','Tille','0154976532');
INSERT INTO client(id,prenom,nom,tel) values (seqclient.nextval, 'Paul','Louis','0154976538');
INSERT INTO client(id,prenom,nom,tel) values (seqclient.nextval, 'Charles','Lau','0154976542');

--Mission : 8
 --num             NUMBER NOT NULL,
 --  num_vol          varchar2(10) NOT NULL,
  -- date_depart     DATE NOT NULL,
 --  h_dep             NUMBER NOT NULL,
  -- id_avion             NUMBER NOT NULL,
  -- ville_dep         varchar2(50) NOT NULL,
  -- ville_arr         varchar2(50) NOT NULL,
 
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval,'1','19/12/2014','10', '1', 'Créteil','Annecy');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '2','19/12/2014','14', '1', 'Annecy','Créteil');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '3','20/12/2014','11', '2', 'Léman','Marseille');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '4','20/12/2014','11', '2','Marseille','Léman');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '5','27/12/2014','10', '3','Créteil','Brest');

INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '6','27/12/2014','14','3','Brest','Créteil');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '7','27/12/2014','13','4','Léman','Lyon');
INSERT INTO mission(num, num_vol,date_depart ,h_dep,id_avion,ville_dep,ville_arr) values (seqmission.nextval, '8','27/12/2014','16','4','Lyon','Léman');

--Escale
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '1','Enghien','10','3');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '2','Enghien','17','1');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '3','Annecy','10','3');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '4','Annecy','10','3');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '5','Enghien','11','1');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '5','Trouville','12','1');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '6','Trouville','15','2');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '6','Enghien','17','1');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '7','Annecy','14','1');
INSERT INTO escale(num, num_mission ,ville ,h_arr,duree) values (seqescale.nextval, '8','Annecy','17','1');

INSERT INTO revision (id,id_av,date_rev,rapport,h_total_vol,h_der_rev,nom_mecanicien) values (seqrevision.nextval,'13','01/01/2015','roue','1000','500','Diaz');
INSERT INTO revision (id,id_av,date_rev,rapport,h_total_vol,h_der_rev,nom_mecanicien) values (seqrevision.nextval,'13','01/10/2014','volant','500','500','Diaz');
