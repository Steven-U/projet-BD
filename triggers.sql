


--TRIGGER

--La capacité de ces appareils est comprise entre 15 et 30 places en fonction des types. 
CREATE OR REPLACE TRIGGER check_place AFTER
UPDATE OR INSERT ON AVION
DECLARE 
    nbplace NUMBER(2);
BEGIN
    SELECT capacite INTO nbplace
    FROM AVION;
    
    if (nbplace<15 or nbplace>30) then
      raise_application_error ( -20002, 'La capacité doit être compris entre 15 et 30 places.');
    endif;
end; 

-- Trigger qui vérifie que l'heure de départ < l'heure d'arrivée
--vérifie la ville de départ et d'arrivée
CREATE OR REPLACE TRIGGER checkville AFTER
UPDATE OR INSERT ON VOL
DECLARE 
ville_dep varchar(15);
ville_arr varchar(15);
h_dep varchar(15);
h_arr varchar(15);
BEGIN
SELECT ville_dep, ville_arr, h_Depart, h_arr
FROM VOL;
if (ville_dep = ville_arr or h_dep>h_arr) then
    raise_application_error(-20225,'Insertion impossible !');
end if;
END;

--La législation aérienne impose une révision tous les 6 mois ou toutes les 500 heures
--de vols sous peine d’interdiction de vol. 




--Pour le personnel navigant qui compose les équipages, il est nécessaire de suivre
--leur nombre d’heures de vol du mois en cours ainsi que la totalité du nombre d’heures de vol.
--Le nombre d’heures maximum de vol mensuel est de 50 (temps d’escale comrpise) pour n’importe quel personnel navigant
