
--***Persona***
create or replace function laboratorio.crear_persona(integer, integer, char, varchar, varchar, varchar) returns integer as $$
declare
  id_departamento alias for $1;
  rut alias for $2;
  dv alias for $3;
  nombres alias for $4;
  apellido_paterno alias for $5;
  apellido_materno alias for $6;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.persona (id_departamento, rut, dv, nombres, apellido_paterno, apellido_materno)
	values(id_departamento, rut, dv, nombres, apellido_paterno, apellido_materno)
    returning laboratorio.persona.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_persona(1,22222222,'9','nombre ejemplo','encalda','castañeda');


create or replace function laboratorio.leer_persona(integer,integer,integer) returns setof laboratorio.persona as $$
declare
    persona_id alias for $1;
    departamento_id alias for $2;
    rut_persona alias for $3;
begin
	return query
	select * from laboratorio.persona
    where id = persona_id or
    id_departamento = departamento_id or
    rut = rut_persona;
end; $$
language plpgsql

--select laboratorio.leer_persona(1,1,null);


create or replace function laboratorio.actualizar_persona(integer, integer, integer, integer, varchar, varchar, varchar) returns boolean as $$
	declare
		identificador alias for $1;
		departamento alias for $2;
		rut_parametro alias for $3;
		dv_parametro alias for $4;
		nombres_parametro alias for $5;
		apellido_paterno_parametro alias for $6;
		apellido_materno_parametro alias for $7;
		fecha_actual timestamptz := now ();
	begin
		update laboratorio.persona set id_departamento = departamento, 
		rut = rut_parametro,
		dv = dv_parametro, 
		nombres = nombres_parametro,
		apellido_paterno = apellido_paterno_parametro,	
		apellido_materno = apellido_materno_parametro,
		fecha_actualizacion = fecha_actual
		where id = identificador;
		return true;
	end; $$
	language plpgsql;

--select laboratorio.actualizar_persona(1,3,77777777,'9','nombres actualizados','apellido P actualizado','apellido M actualizado');

--***Incidencia***
create or replace function laboratorio.crear_incidencia(integer, integer, integer, integer, integer, integer, text) returns integer as $$
declare
  id_sistema alias for $1;
  id_categoria alias for $2;
  id_categoria_cierre alias for $3;
  id_prioridad alias for $4;
  id_canal alias for $5;
  id_incidencia_asociada alias for $6;
  sintomas alias for $7;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.incidencia (id_sistema, id_categoria, id_categoria_cierre, id_prioridad, id_canal, id_incidencia_asociada, sintomas)
	values(id_sistema, id_categoria, id_categoria_cierre, id_prioridad, id_canal, id_incidencia_asociada, sintomas)
    returning laboratorio.incidencia.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_incidencia(1,1,1,1,1,null,'se cae');


create or replace function laboratorio.leer_incidencia(integer, integer, integer, integer) returns setof laboratorio.incidencia as $$
declare
    incidencia_id alias for $1;
    sistema_id alias for $2;
    categoria_cierre_id alias for $3;
    prioridad_id alias for $4;
begin
	return query
	select * from laboratorio.incidencia
    where id = incidencia_id or
    id_sistema = sistema_id or
    id_categoria_cierre = categoria_cierre_id or
    id_prioridad = prioridad_id;
end; $$
language plpgsql;

--select laboratorio.leer_incidencia(1,1,null);


--- Update Incidencia ---
create or replace function laboratorio.actualizar_incidencia(identificador int, newsintomas text, cierre boolean, sistema int, categoria int, cat_cierre int, prioridad int, canal int, incidencia_asoc int)
	returns integer
	as
	$$
	declare
		fecha_actual timestamptz := now();
		devolver int := -1;
	begin
		if cierre is true then
			update laboratorio.incidencia set fecha_cierre = fecha_actual
			where id = identificador;
		end if;
		update laboratorio.incidencia set sintomas = newsintomas,
		id_sistema = sistema,
		id_categoria = categoria,
		id_categoria_cierre = cat_cierre,
		id_prioridad = prioridad,
		id_canal = canal,
		id_incidencia_asociada = incidencia_asoc,
		fecha_actualizacion = fecha_actual
		where id = identificador
		returning laboratorio.incidencia.id into devolver;
		return devolver;
	end
	$$
	language plpgsql;

--select laboratorio.actualizar_incidencia(1,'sintomas actualizados',true,1,1,2,4,3,null);

--***Bitacora***
create or replace function laboratorio.crear_bitacora(integer, integer, integer, integer, integer) returns integer as $$
declare
  id_incidencia alias for $1;
  id_etapa alias for $2;
  id_actividad alias for $3;
  id_estado alias for $4;
  id_persona alias for $5;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.bitacora (id_incidencia, id_etapa, id_actividad, id_estado, id_persona)
	values(id_incidencia, id_etapa, id_actividad, id_estado, id_persona)
    returning laboratorio.bitacora.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_bitacora(1,1,1,1,1);


create or replace function laboratorio.leer_bitacora(integer, integer, integer, integer) returns setof laboratorio.bitacora as $$
declare
    bitacora_id alias for $1;
    incidencia_id alias for $2;
    etapa_id alias for $3;
    persona_id alias for $4;
begin
	return query
	select * from laboratorio.bitacora
    where id = bitacora_id or
    id_incidencia = incidencia_id or
    id_etapa = etapa_id or
    id_persona = persona_id;
end; $$
language plpgsql

--select laboratorio.leer_bitacora(3,null,null,null);


create or replace function laboratorio.actualizar_bitacora(identificador int, incidencia int, etapa int, actividad int,  estado int, persona int, valor boolean) 
	returns integer
	as	
	$$
	declare 
		fecha_actual timestamptz := now ();
		devolver int := -1;
	begin
		update laboratorio.bitacora set id_incidencia = incidencia, 
		id_etapa = etapa, 
		id_actividad = actividad, 
		id_estado = estado,	
		id_persona = persona,
		fecha_actualizacion = fecha_actual,
		activo = valor
		where id = identificador
		returning laboratorio.bitacora.id into devolver;
		return devolver;
	end
	$$
	language plpgsql;

--select laboratorio.actualizar_bitacora(3,1,2,2,2,2,true);

--***Producto***
create or replace function laboratorio.crear_producto(integer, integer, varchar, text) returns integer as $$
declare
  id_tipo_producto alias for $1;
  id_actividad alias for $2;
  glosa alias for $3;
  contenido alias for $4;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.producto (id_tipo_product, id_actividad, glosa, contenido)
	values(id_tipo_producto, id_actividad, glosa, contenido)
    returning laboratorio.producto.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_producto(1,1,'glosa prueba','contenido prueba');


create or replace function laboratorio.leer_producto(integer, integer, integer) returns setof laboratorio.producto as $$
declare
    producto_id alias for $1;
    tipo_producto_id alias for $2;
    actividad_id alias for $3;
begin
	return query
	select * from laboratorio.producto
    where id = producto_id or
    id_tipo_product = tipo_producto_id or
    id_actividad = actividad_id;
end; $$
language plpgsql;

--select laboratorio.leer_producto(1,1,null);


create or replace function laboratorio.actualizar_producto(identificador int, tipo_product int, actividad int, p_glosa varchar,  p_contenido text) 
	returns boolean
	as	
	$$
	declare
	  fecha_actual timestamptz := now();
	begin
	  update laboratorio.producto set 
	  id_tipo_product = tipo_product, 
	  id_actividad = actividad, 
	  glosa = p_glosa, 
	  contenido = p_contenido,	 
	  fecha_actualizacion = fecha_actual
	  where id = identificador;
	  return true;
	end;
	$$
	language plpgsql;

--select laboratorio.actualizar_producto(1,1,1,'glosa actualizada','contenido actualizado');

--***Personal_Rol_Incidencia**
create or replace function laboratorio.crear_persona_rol_incidencia(integer, integer, integer) returns integer as $$
declare
  id_persona alias for $1;
  id_rol alias for $2;
  id_incidencia alias for $3;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.persona_rol_incidencia (id_persona, id_rol, id_incidencia)
	values(id_persona, id_rol, id_incidencia)
    returning laboratorio.persona_rol_incidencia.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_persona_rol_incidencia(1,1,1);


create or replace function laboratorio.leer_persona_rol_incidencia(integer, integer, integer) returns setof laboratorio.persona_rol_incidencia as $$
declare
    persona_id alias for $1;
    rol_id alias for $2;
    incidencia_id alias for $3;
begin
	return query
	select * from laboratorio.persona_rol_incidencia
    where id_persona = persona_id or
    id_rol = rol_id or
    id_incidencia = incidencia_id;
end; $$
language plpgsql;

--select laboratorio.leer_persona_rol_incidencia(1,null,null);


create or replace function laboratorio.actualizar_persona_rol_incidencia(integer, integer, integer)
	returns integer
	as
	$$
	declare
		identificador alias for $1;
  		newrol alias for $2;
  		newincidencia alias for $3;
  		fecha_actual timestamptz := now();
  		devolver int := -1;
	begin
		update laboratorio.persona_rol_incidencia set id_rol = newrol,
		id_incidencia = newincidencia,
		fecha_actualizacion = fecha_actual
		where id_persona = identificador
		returning laboratorio.persona_rol_incidencia.id into devolver;
		return devolver;
	end;
	$$
language plpgsql; 

--select laboratorio.actualizar_persona_rol_incidencia(1,2,2);

--***Sistema***
create or replace function laboratorio.crear_sistema(integer, varchar, varchar) returns integer as $$
declare
  id_sucursal alias for $1;
  codigo alias for $2;
  glosa alias for $3;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.sistema (id_sucursal, codigo, glosa)
	values(id_sucursal, codigo, glosa)
    returning laboratorio.sistema.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_sistema(1,'JaJa', 'glosa prueba');


create or replace function laboratorio.leer_sistema(integer, integer, varchar) returns setof laboratorio.sistema as $$
declare
    sistema_id alias for $1;
    sucursal_id alias for $2;
    codigo_sistema alias for $3;
begin
	return query
	select * from laboratorio.sistema
	where id = sistema_id or
	id_sucursal = sucursal_id or
	codigo = codigo_sistema;
end; $$
language plpgsql;

--select laboratorio.leer_sistema(1,1,null);


create or replace function laboratorio.actualizar_sistema(identificador int, newsucursal int, newcodigo varchar, newglosa varchar)
	returns integer
	as
	$$
	declare
		fecha_actual timestamptz := now();
		devolver int := -1;
	begin
		update laboratorio.sistema set id_sucursal = newsucursal,
		codigo = newcodigo,
		glosa = newglosa,
		fecha_actualizacion = fecha_actual
		where id = identificador
		returning laboratorio.sistema.id into devolver;
		return devolver;
	end;
	$$
language plpgsql; 

--select laboratorio.actualizar_sistema(1,2,'Jaju','glosa reactualizada');


--***Sucursal***
create or replace function laboratorio.crear_sucursal(integer, varchar, varchar) returns integer as $$
declare
  id_pais alias for $1;
  codigo alias for $2;
  direccion alias for $3;
  id_nuevo_registro integer := -1;
begin
	insert into laboratorio.sucursal (id_pais, codigo, direccion)
	values(id_pais, codigo, direccion)
    returning laboratorio.sucursal.id into id_nuevo_registro;
   
	return id_nuevo_registro;
end; $$
language plpgsql;

--select laboratorio.crear_sucursal(1,'JUJU','direccion prueba');


create or replace function laboratorio.leer_sucursal(integer, integer, varchar) returns setof laboratorio.sucursal as $$
declare
    sucursal_id alias for $1;
    pais_id alias for $2;
    codigo_sucursal alias for $3;
begin
	return query
	select * from laboratorio.sucursal
    where id = sucursal_id or
    id_pais = pais_id or
    codigo = codigo_sucursal;
end; $$
language plpgsql;

--select laboratorio.leer_sucursal(2,1,'JUJU');


create or replace function laboratorio.actualizar_sucursal(identificador int, p_id_pais int, p_codigo varchar, p_direccion varchar) 
	returns boolean
	as	
	$$
	declare
	  fecha_actual timestamptz := now();
	begin
	  update laboratorio.sucursal set 
	  id_pais = p_id_pais, 
	  codigo = p_codigo, 
	  direccion = p_direccion, 	 
	  fecha_actualizacion = fecha_actual
	  where id = identificador;
	  return true;
	end;
	$$
	language plpgsql;

--select laboratorio.actualizar_sucursal(2,1,'JOJU','direccion actualizada');


--***Transversales***
create or replace function laboratorio.borrado_logico(nombre_tabla text, id_registro integer) returns boolean as $$
declare
    fecha_actual timestamptz := now();
begin
	execute format('update %s set eliminado = true, fecha_eliminacion = $1 where id= $2', nombre_tabla)
	using fecha_actual, id_registro;
	return true;
end; $$
language plpgsql;

--select laboratorio.borrado_logico('laboratorio.sucursal', 6);
