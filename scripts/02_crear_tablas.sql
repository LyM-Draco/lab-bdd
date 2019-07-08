create table laboratorio.tipo_actividad(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa text,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.actividad(
  id serial primary key,
  id_tipo_actividad integer references laboratorio.tipo_actividad not null;
  descripcion text,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.tipo_producto(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.producto(
  id serial primary key,
  id_tipo_product integer references laboratorio.tipo_producto not null,
  id_actividad integer references laboratorio.actividad not null,
  glosa varchar(300),
  contenido text,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.etapa(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.estado_incidencia(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.departamento(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.persona(
  id serial primary key,
  id_departamento integer references laboratorio.departamento not null,
  rut integer unique not null,
  dv char(1),
  nombres varchar(100),
  apellido_paterno varchar(60),
  apellido_materno varchar(60),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.rol(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.canal(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.pais(
  id serial primary key,
  codigo varchar(5) unique not null,
  nombre varchar(50) unique not null,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.sucursal(
  id serial primary key,
  id_pais integer references laboratorio.pais not null,
  codigo varchar(5) unique not null,
  direccion varchar(300) not null,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.sistema(
  id serial primary key,
  id_sucursal integer references laboratorio.sucursal not null,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.categoria(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.categoria_cierre(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.prioridad(
  id serial primary key,
  codigo varchar(5) unique not null,
  glosa varchar(300),
  fecha_creacion timestamptz default now() not null,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.incidencia
(
  id serial primary key,
  id_sistema integer references laboratorio.sistema not null,
  id_categoria integer references laboratorio.categoria not null,
  id_categoria_cierre integer references laboratorio.categoria_cierre not null,
  id_prioridad integer references laboratorio.prioridad not null,
  id_canal integer references laboratorio.canal not null,
  id_incidencia_asociada integer references laboratorio.incidencia,
  sintomas text not null,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_cierre timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.persona_rol_incidencia(
  id serial primary key,
  id_persona integer references laboratorio.persona not null,
  id_rol integer references laboratorio.rol not null,
  id_incidencia integer references laboratorio.incidencia not null,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  eliminado boolean default false not null
);

create table laboratorio.bitacora
(
  id serial primary key,
  id_incidencia integer references laboratorio.incidencia not null,
  id_etapa integer references laboratorio.etapa not null,
  id_actividad integer references laboratorio.actividad not null,
  id_estado integer references laboratorio.estado_incidencia not null,
  id_persona integer references laboratorio.persona not null,
  fecha_creacion timestamptz default now() not null,
  fecha_actualizacion timestamptz,
  fecha_eliminacion timestamptz,
  activo boolean default true not null,
  eliminado boolean default false not null
);

