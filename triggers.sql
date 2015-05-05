-- Trigger qui vérifie que l'heure de départ < l'heure d'arrivée
CREATE TRIGGER T1 ON VOL
FOR INSERT
AS
BEGIN
DECLARE @v_depart varchar(15)
DECLARE @v_arrivée varchar(15)
DECLARE @h_depart datetime
DECLARE @h_arrivée %type
SELECT @ville_dep=AeroportDepart, @ville_dep=AeroportArrivée, @h_Depart=h_dep, @h_arrivée=h_arr
FROM INSERTED
IF @ville_dep = @ville_arr OR @h_dep>@h_arr
BEGIN
RAISERROR(‘Insertion impossible !!’, 16, 1)
ROLLBACK
END
END 

--TRIGGER

--La capacité de ces appareils est comprise entre 15 et 30 places en fonction des types. 
CREATE OR REPLACE TRIGGER check_place AFTER
UPDATE OR INSERT ON AVION
DECLARE nbplace NUMBER(2);
BEGIN
SELECT capacite
INTO nbplace
FROM AVION
if (nbplace<15 or nbplace>30) then
  raise_application_error ( -20002, 'La capacité doit être compris entre 15 et 30 places.');
end;  


--La législation aérienne impose une révision tous les 6 mois ou toutes les 500 heures
--de vols sous peine d’interdiction de vol. 
CREATE OR REPLACE TRIGGER check_revision AFTER
UPDATE OR INSERT ON AVION
DECLARE nbheure NUMBER(3);
BEGIN
SELECT nbheure
INTO nbplace
FROM AVION
WHERE;
end;  



--Pour le personnel navigant qui compose les équipages, il est nécessaire de suivre
--leur nombre d’heures de vol du mois en cours ainsi que la totalité du nombre d’heures de vol.
--Le nombre d’heures maximum de vol mensuel est de 50 (temps d’escale comrpise) pour n’importe quel personnel navigant
