--Supression des tables

drop table AVION cascade constraints;
drop table REVISION cascade constraints;
drop table personnel_sol cascade constraints;
drop table personnel_nav cascade constraints;
drop table Client cascade constraints;
drop table vol cascade constraints;
drop table Mission cascade constraints;
drop table escale cascade constraints;
drop table Equipage_Vol cascade constraints;
drop table Reservation cascade constraints;

--Supression des séquences
DROP SEQUENCE seqavion;
DROP SEQUENCE seqclient;
DROP SEQUENCE seqescale;
DROP SEQUENCE seqmission;
DROP SEQUENCE seqpersnav;
DROP SEQUENCE seqperssol;
DROP SEQUENCE seqreservation;
DROP SEQUENCE seqrevision;
DROP SEQUENCE seqvol;

--Suppression des triggers


