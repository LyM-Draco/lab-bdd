insert into laboratorio.estado_incidencia (codigo, glosa) values('ING', 'Ingresado');
insert into laboratorio.estado_incidencia (codigo, glosa) values('PRO', 'En Proceso');
insert into laboratorio.estado_incidencia (codigo, glosa) values('PAU', 'Pausado');
insert into laboratorio.estado_incidencia (codigo, glosa) values('CIE', 'Cerrado');

insert into laboratorio.tipo_producto (codigo, glosa) values('DOC', 'Documentacion');
insert into laboratorio.tipo_producto (codigo, glosa) values('SOFT', 'Software');
insert into laboratorio.tipo_producto (codigo, glosa) values('ACU', 'Algún acuerdo escrito entre partes');
insert into laboratorio.tipo_producto (codigo, glosa) values('OTRO', 'Otros tipos de producto');

insert into laboratorio.etapa (codigo, glosa) values('DET', 'Detección de incidencia');
insert into laboratorio.etapa (codigo, glosa) values('ANA', 'Análisis de incidencia');
insert into laboratorio.etapa (codigo, glosa) values('CONT', 'Contención de la incidencia');
insert into laboratorio.etapa (codigo, glosa) values('ELI', 'Eliminación de la incidencia');
insert into laboratorio.etapa (codigo, glosa) values('REC', 'Recuperación del laboratorio.sistema');

insert into laboratorio.tipo_actividad (codigo, glosa) values('CLA', 'Clasificación. Determinar el nivel de prioridad');
insert into laboratorio.tipo_actividad (codigo, glosa) values('INV', 'Investigación. Identificar, analizar y documentar todos los sintomas');
insert into laboratorio.tipo_actividad (codigo, glosa) values('DIA', 'Diagnóstico. Determinar la ubicación y posibles correciones');
insert into laboratorio.tipo_actividad (codigo, glosa) values('ESC', 'Escalamiento. Transferencia del incidente hacía el siguiente nivel de soporte');
insert into laboratorio.tipo_actividad (codigo, glosa) values('SOL', 'Solución. Restablecer el servicio y mejorar la satisfacción del usuario');
insert into laboratorio.tipo_actividad (codigo, glosa) values('CER', 'Cierre. Cerrar el incidente, usuario confirma la solución del problema, se cierra la incidencia documentando el cierre.');
insert into laboratorio.tipo_actividad (codigo, glosa) values('MON', 'Monitorización. Seguimiento y comunicación del incidente.');
insert into laboratorio.tipo_actividad (codigo, glosa) values('RAM', 'Ramificación. Creación de nueva incidencia en base a la incidencia actual');
insert into laboratorio.tipo_actividad (codigo, glosa) values('OTRO', 'Otro tipo de actividad');

insert into laboratorio.canal (codigo, glosa) values('COR', 'Correo');
insert into laboratorio.canal (codigo, glosa) values('FON', 'Teléfono');
insert into laboratorio.canal (codigo, glosa) values('PSO', 'Plataforma Soporte');
insert into laboratorio.canal (codigo, glosa) values('OTRO', 'Otros canales');

insert into laboratorio.pais (codigo, nombre) values('CL', 'Chile');
insert into laboratorio.pais (codigo, nombre) values('PER', 'Perú');
insert into laboratorio.pais (codigo, nombre) values('ESP', 'España');
insert into laboratorio.pais (codigo, nombre) values('BRZ', 'Brazil');
insert into laboratorio.pais (codigo, nombre) values('CAN', 'Canada');

insert into laboratorio.sucursal (id_pais, codigo, direccion) values(1, 'SUC1','direccion ficticia 1 #1111');
insert into laboratorio.sucursal (id_pais, codigo, direccion) values(2, 'SUC2','direccion ficticia 2 #2222');
insert into laboratorio.sucursal (id_pais, codigo, direccion) values(3, 'SUC3','direccion ficticia 3 #3333');
insert into laboratorio.sucursal (id_pais, codigo, direccion) values(4, 'SUC4','direccion ficticia 4 #4444');
insert into laboratorio.sucursal (id_pais, codigo, direccion) values(5, 'SUC5','direccion ficticia 5 #5555');

insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(1, 'TWEB', 'Transferencias Web');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(1, 'COB', 'laboratorio.sistema de cobranza');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(2, 'ICOT', 'laboratorio.sistema para información de cotizaciones');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(2, 'STL', 'Aplicación Web Son Tus Lucas');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(3, 'PAC', 'Portal Atención al Cliente');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(3, 'IDEP', 'Interposición de demandas');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(4, 'GDEP', 'Gestión de demandas');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(4, 'ALMA', 'Atacama Large Milimiter Array');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(5, 'LSST', 'Large Synoptic Survey Telescope');
insert into laboratorio.sistema (id_sucursal, codigo, glosa) values(5, 'E-ELT', 'European Extremely Large Telescope');

insert into laboratorio.categoria (codigo, glosa) values('INU', 'Incidencia Nueva');
insert into laboratorio.categoria (codigo, glosa) values('IRE', 'Incidencia Recurrente');
insert into laboratorio.categoria (codigo, glosa) values('IPI', 'Incidencia Producto de otra incidencia');

insert into laboratorio.categoria_cierre (codigo, glosa) values ('CSA', 'Cerrado Satisfactoriamente');
insert into laboratorio.categoria_cierre (codigo, glosa) values ('CIN', 'Cerrado Insatisfactoriamente');
insert into laboratorio.categoria_cierre (codigo, glosa) values ('CNI', 'Cerrado con generación de nueva incidencia');

insert into laboratorio.prioridad (codigo, glosa) values('BAJA', 'Prioridad Baja');
insert into laboratorio.prioridad (codigo, glosa) values('MED', 'Prioridad Media');
insert into laboratorio.prioridad (codigo, glosa) values('ALTA', 'Prioridad Alta');
insert into laboratorio.prioridad (codigo, glosa) values('URG', 'Prioridad Máxima, urgente');

insert into laboratorio.departamento (codigo, glosa) values('OPE', 'Operaciones');
insert into laboratorio.departamento (codigo, glosa) values('TES', 'Tesorería');
insert into laboratorio.departamento (codigo, glosa) values('RRHH', 'Recursos Humanos');
insert into laboratorio.departamento (codigo, glosa) values('DES', 'Desarrollo de software' );
insert into laboratorio.departamento (codigo, glosa) values('SIS', 'laboratorio.sistemas y soporte');

insert into laboratorio.rol (codigo, glosa) values('RESP', 'Responsable de incidencia');
insert into laboratorio.rol (codigo, glosa) values('SOLU', 'Encargado de definir accion o solución a tomar');
insert into laboratorio.rol (codigo, glosa) values('IMPL', 'Encargado de  implementar alguna acción o solución');
insert into laboratorio.rol (codigo, glosa) values('CLI', 'Usuario afectado por incidencia');
insert into laboratorio.rol (codigo, glosa) values('INF', 'Informate de incidencia');

