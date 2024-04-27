-- version usada base de datos: 10.4.32-MariaDB
drop database if exists `refacciones_bot`;
create database `refacciones_bot` DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
use `refacciones_bot`;

create table usuarios(
    usuario_id int auto_increment,
    uid_telegram varchar(255),
    primary key (usuario_id)
);

create table marcas(
    marca_id INT auto_increment,
    nombre varchar(255) not null,
     primary key (marca_id)
);

create table provedoores(
    proveedor_id INT auto_increment,
    nombre varchar(255) not null,
    primary key (proveedor_id)
);

create table categorias(
    categoria_id INT auto_increment,
    nombre varchar(255) not null,
    primary key (categoria_id)
);

create table camiones(
    camion_id int auto_increment,
    marca_id int,
    modelo varchar(255) not null,
    año tinyint(4),
    primary key (camion_id),
    foreign key (marca_id) references marcas(marca_id)
);

create table refacciones(
    refaccion_id int auto_increment,
    nombre varchar(255) not null ,
    numero_parte varchar(128) not null ,
    provedor_id int not null ,
    categoria_id int not null ,
    descripcion text,
    especificaciones json,
    imagen varchar(255),
    activo boolean default true,
    stock int,
    precio double,
    primary key (refaccion_id),
    unique (numero_parte),
    foreign key (provedor_id) references provedoores(proveedor_id),
    foreign key (categoria_id) references categorias(categoria_id)
);

create table camiones_refacciones(
    camion_id int not null ,
    refaccion_id int not null,
    primary key (camion_id,refaccion_id),
    foreign key (camion_id) references camiones(camion_id),
    foreign key (refaccion_id) references refacciones(refaccion_id)
);

INSERT INTO `categorias` (`nombre`)
VALUES
('Baterías y cargadores'),
('Iluminación y cableado'),
('Accesorios'),
('Frenos'),
('Postratamiento'),
('Sistema de aire acondicionado'),
('Motor'),
('Escape y admisión'),
('Sistemas de combustible y encendido'),
('Sistema de refrigeración'),
('Carrocería, cabina y chasis'),
('Accesorios de bus y remolque'),
('Dirección y suspensión'),
('Tren motriz'),
('Ruedas y neumáticos'),
('Líquidos, Lubricantes y Productos Quimicos'),
('Herramientas'),
('Accesorios de montaje y piezas de repuesto'),
('Sistemas híbridos');

