create database usach_lab_incidencias;

--***SCHEMA***
create user admin_lab with encrypted password 'lab_adm';
grant all privileges on database usach_lab_incidencias to admin_lab;
\connect usach_lab_incidencias;
CREATE SCHEMA IF NOT EXISTS laboratorio AUTHORIZATION admin_lab;

--***GRUPOS***

-- lectura
create role lectura;
grant connect on database usach_lab_incidencias to lectura;
--revoke all privileges on schema laboratorio from lectura;
grant usage on schema laboratorio to lectura;
grant select on all tables in schema laboratorio to lectura;

alter default privileges in schema laboratorio grant select on tables to lectura;


 -- escritura
create role escritura;
grant connect on database usach_lab_incidencias to escritura;
--revoke all privileges on schema laboratorio from escritura;
grant usage on schema laboratorio to escritura;
grant insert on tables to escritura;
grant update on tables to escritura;
alter default privileges in schema laboratorio grant insert on tables to escritura;
alter default privileges in schema laboratorio grant update on tables to escritura;


-- ejecución
create role ejecucion;
grant connect on database usach_lab_incidencias to ejecucion;
--revoke all privileges on schema laboratorio from ejecucion;
grant usage on schema laboratorio to ejecucion;
grant execute on all functions in schema laboratorio to ejecucion;


--***Usuarios***
create user lector with encrypted password 'lab_lect';
grant lectura to lector;

create user manipulador with encrypted password 'lab_mani';
grant lectura to manipulador;
grant escritura to manipulador;

create user ejecutor with encrypted password 'lab_eje';
grant ejecucion to ejecutor;