--1. Tiempo promedio que cada sistema pasa en cada etapa de una incidencia
create or replace function laboratorio.tiempo_promedio_sistema_etapa(out codigo, out eta_codigo, out tiempo_promedio) 
    returns setof record
    as 
    $$
    begin
        return query
        select 
        sis.codigo,
        duracion_incidencia_etapa.eta_codigo ,
        avg(tiempo_etapa_incidencia) as tiempo_promedio
        from (
                select 
                inc.id as inc_id,
                eta.codigo as eta_codigo,
                max(bita.fecha_creacion) - min(bita.fecha_creacion) as tiempo_etapa_incidencia
                from laboratorio.incidencia as inc
                join laboratorio.bitacora as bita on bita.id_incidencia = inc.id
                join laboratorio.etapa as eta on eta.id = bita.id_etapa
                group by inc.id, eta.codigo
            ) as duracion_incidencia_etapa
        join laboratorio.incidencia as inc on inc.id = duracion_incidencia_etapa.inc_id
        join laboratorio.sistema as sis on sis.id = inc.id_sistema
        group by sis.codigo, duracion_incidencia_etapa.eta_codigo
    end;
    $$ language plpgsql;


--2. Tipo de producto más producido en incidentes graves ordenado por país
create or replace function laboratorio.tipo_producto_incidentes_graves(out nombre_pais, out codigo_tipo_prod) 
    returns setof record
    as 
    $$
    begin
        return query
        with cantidad_tpr_pai as (
            select 
            pai.nombre as nombre_pais,
            tpr.codigo as codigo_tipo_prod,
            count(tpr.codigo) as cantidad_tipo_producto,
            rank() over(partition by pai.nombre order by count(tpr.codigo) desc) as ranking
            from laboratorio.pais as pai
            join laboratorio.sucursal as suc on suc.id_pais = pai.id
            join laboratorio.sistema as sis on sis.id_sucursal = suc.id
            join laboratorio.incidencia as inc on inc.id_sistema = sis.id
            join laboratorio.prioridad as pri on pri.id = inc.id_prioridad
            join laboratorio.bitacora as bita on bita.id_incidencia = inc.id
            join laboratorio.actividad as act on act.id = bita.id_actividad
            join laboratorio.producto as prod on prod.id_actividad = act.id
            join laboratorio.tipo_producto as tpr on tpr.id = prod.id_tipo_product
            where pri.codigo = 'URG'
            group by pai.nombre, tpr.codigo
        )
        select nombre_pais, codigo_tipo_prod
        from cantidad_tpr_pai
        where ranking = 1
        order by nombre_pais
    end;
    $$ language plpgsql;


--3. Pais con mayor cantidad de incidencias con prioridad BAJA
create or replace function laboratorio.tipo_producto_incidentes_graves(out nombre_pais, out cantidad_incidencias) 
    returns setof record
    as 
    $$
    begin
        return query
        select pai.nombre as nombre_pais, count(inc.id) as cantidad_incidencias 
        from laboratorio.pais as pai
        join laboratorio.sucursal as suc on suc.id_pais = pai.id
        join laboratorio.sistema as sis on sis.id_sucursal = suc.id
        join laboratorio.incidencia as inc on inc.id_sistema = sis.id
        join laboratorio.prioridad as pri on pri.id = inc.id_prioridad
        where pri.codigo = 'BAJA'
        group by pai.nombre
        order by count(inc.id) desc
        limit 1
    end;
    $$ language plpgsql;


--4. Sucursal con menor cantidad de incidencias con prioridad ALTA
create or replace function laboratorio.tipo_producto_incidentes_graves(out nombre_sucursal, out cantidad_incidencias) 
    returns setof record
    as 
    $$
    begin
        return query
        select suc.codigo as nombre_sucursal, count(inc.id) as cantidad_incidencias 
        from laboratorio.sucursal as suc
        join laboratorio.sistema as sis on sis.id_sucursal = suc.id
        join laboratorio.incidencia as inc on inc.id_sistema = sis.id
        join laboratorio.prioridad as pri on pri.id = inc.id_prioridad
        where pri.codigo = 'ALTA'
        group by suc.codigo
        order by count(inc.id) asc
        limit 1
    end;
    $$ language plpgsql;