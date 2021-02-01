use franciscoa_versionador2;

drop table if exists log_entrada;
drop table if exists logs;
drop table if exists versiones;   
drop table if exists proyectos_det;    
drop table if exists proyectos_cab;
drop table if exists archivos_vinculados;
drop table if exists transacciones;   
drop table if exists usuarios;

create table usuarios(
	id_usuario int auto_increment primary key,
    nombre varchar(30) not null
    );

create table transacciones(
	id_transaccion int auto_increment primary key,
    id_usuario int not null,
    fecha timestamp not null,
    comentario varchar(250),
    foreign key (id_usuario) references usuarios(id_usuario)
    );

create table log_entrada(
	ip varchar(15) primary key,  
    id_usuario int not null,
    pc varchar(30) not null,
    fecha timestamp not null,
    foreign key (id_usuario) references usuarios(id_usuario)
    );
    
create table logs(
	id_usuario int not null,
    fecha timestamp not null,
    accion varchar(20) not null,
    foreign key (id_usuario) references usuarios(id_usuario)
    );

create table proyectos_cab(
	id_proyecto int primary key auto_increment,    
    id_usuario int not null,
    nombre varchar(30) not null,
    descripcion varchar(100) not null,
    carpeta_base varchar(100) not null,
    activo varchar(30) not null,
    creado_dia timestamp default current_timestamp,
    foreign key (id_usuario) references usuarios(id_usuario)
    );     
    
create table proyectos_det(
	id_archivo int primary key auto_increment,
    id_proyecto int not null,
    id_usuario int not null,
    archivo varchar(40) not null,
    destino varchar(30) not null,
    foreign key (id_proyecto) references proyectos_cab(id_proyecto),
    foreign key (id_usuario) references usuarios(id_usuario)
    );
    
create table versiones(
	id_version int primary key auto_increment,
    id_transaccion int not null,
    id_archivo int not null,
    id_usuario int not null,
    fecha timestamp not null,
    tipo varchar(20) not null,
    foreign key (id_transaccion) references transacciones(id_transaccion),
    foreign key (id_archivo) references proyectos_det(id_archivo),
    foreign key (id_usuario) references usuarios(id_usuario)
    );

create table archivos_vinculados(
	id_proyecto int not null,
    id_archivo int not null
    );
