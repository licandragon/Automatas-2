-- version usada base de datos: 10.4.32-MariaDB
drop database if exists `refacciones_bot`;
create database `refacciones_bot` DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
use `refacciones_bot`;

create table usuarios(
    usuario_id int auto_increment,
    uid_telegram BIGINT,
    primary key (usuario_id)
);

create table marcas(
    marca_id INT auto_increment,
    nombre varchar(255) not null,
     primary key (marca_id)
);

create table provedores(
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
    marca_id int not null,
    modelo varchar(255) not null,
    año INT,
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
    imagen varchar(255) default 'https://www.shutterstock.com/image-vector/no-image-available-sign-internet-600nw-261719003.jpg',
    activo boolean default true,
    stock int,
    precio double,
    primary key (refaccion_id),
    unique (numero_parte),
    foreign key (provedor_id) references provedores(proveedor_id),
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


INSERT INTO `marcas` (`nombre`)  VALUES ('Kenhwort');

INSERT INTO `provedores` (nombre) VALUES
('TRP'),
('Volvo Parts'),
('Scania Parts'),
('Kenworth Parts'),
('Freightliner Parts');


INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','540','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','953','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C500B','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C550','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C550','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','C550','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1973');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1974');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1975');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1976');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1977');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1978');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1979');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1980');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1981');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1982');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K100C','1983');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K300','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K500','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K500','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K500','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','K500','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T170','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T2000','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T270','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T300','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T370','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400B','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400B','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400B','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400B','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T400B','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T440','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T450B','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T460','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T460','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T460','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T460','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T470','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600A','1984');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600A','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600A','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600A','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T600A','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T603','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T660','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T680','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T700','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800B','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800SH','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T800W','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T802','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T803','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','T880','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2011');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2012');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2013');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2016');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2014');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2015');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2017');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2021');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2018');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2019');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2020');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1983');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1984');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','2022');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900','1982');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2005');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1996');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1997');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1998');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1999');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2000');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2001');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2002');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2003');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2004');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1994');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1995');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1989');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1990');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1991');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1992');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1993');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1983');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1984');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1985');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1986');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1987');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1988');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2006');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2007');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2008');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','1982');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2009');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2010');
INSERT INTO `camiones` (`marca_id`,`modelo`,`Año`) VALUES ('1','W900B','2011');



INSERT INTO `refacciones` (nombre, numero_parte, provedor_id, categoria_id, descripcion, especificaciones, imagen,activo, stock, precio)
VALUES ('TAMBOR DE FRENOS 15X4 DELANTERO TRP','DB154B', '1','4','TAMBOR DE FRENOS 15X4 DELANTERO TRP',
    '{"Unidad de medida": "Cada elemento",
        "Código VMRS": "013-001-023 [Tambor freno delantero]",
        "Tornillo Circular": "11.25",
        "Tamaño Hoyo de Tornillo": "1.28",
        "Orificios de Tornillos": "10",
        "Medida de Frenos": "15 x 4",
        "Diámetro de Guía": "8.78",
        "Tamaño": "15",
        "Se usa con": "Hub Pilot – Front Steer",
        "Peso (lb)": "70",
        "Tipo de Rueda": "Disco"
    }', 'https://mex.trpparts.com/es/refacciones/acoples/tambor/db154b?Id=3765b598-5780-4ec8-9bef-f9521d7b65d9#', true, 50, 1500.45);
INSERT INTO `refacciones` (nombre, numero_parte, provedor_id, categoria_id, descripcion, especificaciones, imagen,activo, stock, precio)
VALUES ('Faro BEAM-SEALED 4537 13V 100W',' LB4537', '1','2','luces de bulbo sellado! Estos productos de alta calidad son producidos por un proveedor confiable de equipo original en iluminación automotriz y ahora están disponibles través de su proveedor local: Misma calidad, servicio y entrega.',
    '{"Unidad de medida": "Cada elemento",
      "Código VMRS": "013-001-023 [Tambor freno delantero]",
      "Caracteristicas y Beneficios" : "Reflejo reducido para uso legal en la carretera Cumple los estándares de puntos del Departamento de Transporte (DOT) específicos del producto  las normas SAE específicas del producto"
    }', 'https://trp-assets.anthology-digital.com/assets/LB4537_P01_FRO_ALL-HIGH.png', true, 50, 1500.45);
INSERT INTO `refacciones` (nombre, numero_parte, provedor_id, categoria_id, descripcion, especificaciones, imagen,activo, stock, precio)
VALUES ('INTERRUPTOR-LUZ DIRECCIONAL','TL10750', '1','2','luces de bulbo sellado! Estos productos de alta calidad son producidos por un proveedor confiable de equipo original en iluminación automotriz y ahora están disponibles través de su proveedor local: Misma calidad, servicio y entrega.',
    '{"Description": "INTERRUPTOR-LUZ DIRECCIONAL",
        "Unidad de medida": "Cada elemento",
        "Código VMRS": "034-003-016 [Interruptor:  funcionamiento de la señal de viraje]",
        "Reemplaza": "Peterbilt: 16-06432",
        "Tipo": "11 Cables"}'
    , 'https://trp-assets.anthology-digital.com/assets/TL10750_P01_FRO_ALL-HIGH.png', true, 15, 200);

-- Inserciones para la tabla 'refacciones'
INSERT INTO `refacciones` (nombre, numero_parte, provedor_id, categoria_id, descripcion, especificaciones, activo, stock, precio) VALUES
('Filtro de aceite para camión Volvo FH12/FH16', 'FH12-FH16-OF1', '2', '16', 'Filtro de aceite de alta calidad para camiones Volvo FH12/FH16', '{"Compatibilidad": "Camiones Volvo FH12/FH16", "Material del filtro": "Papel especial", "Eficiencia de filtración": "99.5%"}', true, 50, 25.99),
('Pastillas de freno delanteras para camión Scania R Series', 'R-Series-BP1', '3', '4', 'Pastillas de freno de alta calidad para camiones Scania R Series', '{"Compatibilidad": "Camiones Scania R Series", "Material": "Material de fricción cerámico", "Durabilidad": "Resistente al desgaste"}',  true, 100, 49.99),
('Faro delantero LED para camión Kenworth T680', 'T680-LED-HL', '4', '2', 'Faro delantero LED de alta intensidad para camiones Kenworth T680', '{"Compatibilidad": "Camiones Kenworth T680", "Tipo de luz": "LED", "Potencia": "100W"}', true, 30, 199.99),
('Espejo lateral para camión Freightliner Cascadia', 'Cascadia-Mirror-L', '5', '11', 'Espejo lateral de repuesto para camiones Freightliner Cascadia', '{"Compatibilidad": "Camiones Freightliner Cascadia", "Tipo": "Espejo de gran angular", "Material": "Plástico resistente"}', true, 20, 149.99),
('Compresor de aire para camión International Prostar', 'Prostar-AC1', '1', '6', 'Compresor de aire de repuesto para camiones International Prostar', '{"Compatibilidad": "Camiones International Prostar", "Tipo": "Compresor de aire de pistón", "Capacidad": "20 CFM"}', true, 10, 399.99),
('Batería de arranque para camión Volvo FH12/FH16', 'FH12-FH16-BAT1', '2', '1', 'Batería de arranque de alta potencia para camiones Volvo FH12/FH16', '{"Compatibilidad": "Camiones Volvo FH12/FH16", "Tipo": "Batería de plomo-ácido", "Capacidad": "1000 CCA"}',true, 40, 149.99),
('Alternador para camión Scania R Series', 'R-Series-ALT1', '3', '9', 'Alternador de alta capacidad para camiones Scania R Series', '{"Compatibilidad": "Camiones Scania R Series", "Tipo": "Alternador de corriente alterna", "Potencia": "200 amperios"}', true, 20, 299.99),
('Luces traseras LED para camión Kenworth T680', 'T680-LED-TL', '4', '2', 'Luces traseras LED de alta calidad para camiones Kenworth T680', '{"Compatibilidad": "Camiones Kenworth T680", "Tipo de luz": "LED", "Potencia": "50W"}',  true, 25, 99.99),
('Sensor de temperatura del motor para camión Freightliner Cascadia', 'Cascadia-Engine-Temp-Sensor', '5', '8', 'Sensor de temperatura del motor de repuesto para camiones Freightliner Cascadia', '{"Compatibilidad": "Camiones Freightliner Cascadia", "Tipo": "Sensor de temperatura del refrigerante", "Precisión": "±1°C"}',  true, 30, 79.99),
('Ventilador del radiador para camión International Prostar', 'Prostar-Radiator-Fan', '1', '10', 'Ventilador del radiador de repuesto para camiones International Prostar', '{"Compatibilidad": "Camiones International Prostar", "Tipo": "Ventilador eléctrico", "Diámetro": "20 pulgadas"}',  true, 15, 129.99),
('Termostato para camión Volvo FH12/FH16', 'FH12-FH16-Thermostat', '2', '10', 'Termostato de repuesto para camiones Volvo FH12/FH16', '{"Compatibilidad": "Camiones Volvo FH12/FH16", "Material": "Acero inoxidable", "Rango de temperatura": "160-190°F"}', true, 35, 39.99),
('Amortiguador trasero para camión Scania R Series', 'R-Series-RS', '3', '12', 'Amortiguador trasero de alta resistencia para camiones Scania R Series', '{"Compatibilidad": "Camiones Scania R Series", "Tipo": "Amortiguador de gas", "Durabilidad": "Resistencia a la corrosión"}',  true, 18, 149.99),
('Tapa del tanque de combustible para camión Kenworth T680', 'T680-Fuel-Cap', '4', '11', 'Tapa del tanque de combustible de repuesto para camiones Kenworth T680', '{"Compatibilidad": "Camiones Kenworth T680", "Material": "Aluminio fundido", "Cierre": "Con llave"}',  true, 40, 19.99),
('Caja de cambios para camión International Prostar', 'Prostar-Transmission', '1', '14', 'Caja de cambios de repuesto para camiones International Prostar', '{"Compatibilidad": "Camiones International Prostar", "Tipo": "Transmisión manual de 10 velocidades"}',  true, 10, 1999.99),
('Inyector de combustible para camión Volvo FH12/FH16', 'FH12-FH16-Fuel-Inj', '2', '9', 'Inyector de combustible de repuesto para camiones Volvo FH12/FH16', '{"Compatibilidad": "Camiones Volvo FH12/FH16", "Tipo": "Inyector de combustible diésel", "Flujo": "200 cc/min"}',  true, 15, 299.99),
('Bombilla para faro delantero de camión Scania R Series', 'R-Series-Headlight-Bulb', '3', '2', 'Bombilla de repuesto para faro delantero de camiones Scania R Series', '{"Compatibilidad": "Camiones Scania R Series", "Tipo de luz": "Halógena", "Potencia": "100W"}', true, 50, 9.99),
('Parachoques delantero para camión Kenworth T680', 'T680-Front-Bumper', '4', '11', 'Parachoques delantero de repuesto para camiones Kenworth T680', '{"Compatibilidad": "Camiones Kenworth T680", "Material": "Acero galvanizado", "Estilo": "Estilo OEM"}', true, 5, 599.99),
('Rueda trasera para camión Freightliner Cascadia', 'Cascadia-Rear-Wheel', '5', '15', 'Rueda trasera de repuesto para camiones Freightliner Cascadia', '{"Compatibilidad": "Camiones Freightliner Cascadia", "Material": "Aluminio forjado", "Diámetro": "22.5 pulgadas"}', true, 8, 799.99),
('Válvula EGR para camión International Prostar', 'Prostar-EGR-Valve', '1', '8', 'Válvula de recirculación de gases de escape de repuesto para camiones International Prostar', '{"Compatibilidad": "Camiones International Prostar", "Tipo": "Válvula EGR electrónica", "Compatibilidad con normativas": "EPA 2010"}', true, 20, 499.99),
('Motor de arranque para camión Volvo FH12/FH16', 'FH12-FH16-Starter-Motor', '2', '6', 'Motor de arranque de repuesto para camiones Volvo FH12/FH16', '{"Compatibilidad": "Camiones Volvo FH12/FH16", "Tipo": "Motor de arranque de 24V", "Potencia": "5 kW"}',  true, 12, 399.99),
('Tensor de correa para camión Scania R Series', 'R-Series-Belt-Tensioner', '3', '7', 'Tensor de correa de repuesto para camiones Scania R Series', '{"Compatibilidad": "Camiones Scania R Series", "Material": "Acero reforzado", "Durabilidad": "Resistencia a la corrosión"}',  true, 25, 149.99),
('Espejo retrovisor para camión Kenworth T680', 'T680-Rearview-Mirror', '4', '11', 'Espejo retrovisor de repuesto para camiones Kenworth T680', '{"Compatibilidad": "Camiones Kenworth T680", "Tipo": "Espejo convexo", "Ajuste": "Eléctrico"}', true, 15, 89.99),
('Amortiguador delantero para camión Freightliner Cascadia', 'Cascadia-Front-Shock', '5', '12', 'Amortiguador delantero de repuesto para camiones Freightliner Cascadia', '{"Compatibilidad": "Camiones Freightliner Cascadia", "Tipo": "Amortiguador de gas", "Diseño": "Monotubo"}',  true, 22, 99.99),
('Bomba de agua para camión International Prostar', 'Prostar-Water-Pump', '1', '6', 'Bomba de agua de repuesto para camiones International Prostar', '{"Compatibilidad": "Camiones International Prostar", "Tipo": "Bomba de agua centrífuga", "Flujo máximo": "50 GPM"}',  true, 18, 149.99);

INSERT INTO `camiones_refacciones` VALUES (38, 1);
INSERT INTO `camiones_refacciones` VALUES (241, 1);
INSERT INTO `camiones_refacciones` VALUES (300, 3);
INSERT INTO `camiones_refacciones` VALUES (304, 3);
INSERT INTO `camiones_refacciones` (camion_id, refaccion_id) VALUES
(1, 1),
(1, 4),
(2, 3),
(3, 2),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 11),
(11, 12),
(12, 13),
(13, 14),
(14, 15),
(15, 16),
(16, 17),
(17, 18),
(18, 19),
(19, 20),
(20, 21),
(21, 22),
(22, 23),
(23, 24),
(24, 25);

