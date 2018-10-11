drop database if exists geometryDash;
create database if not exists geometryDash DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use geometryDash;
#tabla usuarios
drop table if exists usuario;
create table if not exists usuario(
idUsuario int not null auto_increment,
usuario varchar(50) not null unique,
contrasenha varchar(50) not null,
CONSTRAINT PK_Usuario primary key(idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#tabla datos de cada usuario
drop table if exists datos_usuario;
create table if not exists datos_usuario(
id int not null auto_increment,
nombre varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
apellidos varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci not null,
email varchar(100) not null unique,
usuario varchar(50) not null unique,
contrasenha varchar(50) not null,
CONSTRAINT PK_Usuario primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#tabla puntuaciones de todos
drop table if exists puntuaciones;
create table if not exists puntuaciones(
id int not null auto_increment,
puntuacion int not null,
nivel enum('1','2','3','4'),
user_id int not null,
CONSTRAINT PK_Puntuaciones primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
#tabla de ruta imagenes- perfil usuarios
drop table if exists img_usuario_servidor;
create table if not exists img_usuario_servidor(
idUsuario int not null,
src varchar(150) not null,
constraint PK_img_usuario_ruta primary key(idUsuario)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

#añadimos una foreign key a kla tabla usuario para que tenga que coincidir con la tabla datos_usuario
ALTER TABLE usuario ADD CONSTRAINT usuario_datosUsuario_FK FOREIGN KEY (idUsuario)
REFERENCES datos_usuario (id) ON DELETE CASCADE ON UPDATE CASCADE;

#añadimos al foreign key de la tabla usuarios a puntuaciones
ALTER TABLE puntuaciones ADD CONSTRAINT Puntuaciones_usuario_FK FOREIGN KEY (user_id)
REFERENCES usuario (idUsuario) ON DELETE CASCADE ON UPDATE CASCADE;

#alteramos la tabla img_usuario_servidor para apadirle la foreign key de la tabla usuario(idUsuario)
alter table img_usuario_servidor add constraint usuario_imgUsuario_FK foreign key (idUsuario)
references usuario (idUsuario) on delete cascade on update cascade;

#alteramos al tabla datos_cliente para añadir algunos campos "no obligatorios" 
#que podras rellenar en tu perfil.
alter table datos_usuario add column telefono int(15) after contrasenha;
alter table datos_usuario add column direccion varchar(100) after telefono;
alter table datos_usuario add column biografia varchar(400) after direccion;

