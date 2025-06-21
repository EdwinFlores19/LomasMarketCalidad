DROP TABLE caja;

CREATE TABLE `caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `inicio` decimal(10,2) DEFAULT NULL,
  `ventas` decimal(10,2) DEFAULT NULL,
  `abonos` decimal(10,2) DEFAULT NULL,
  `egresos` decimal(10,2) DEFAULT NULL,
  `creditos` decimal(10,2) DEFAULT NULL,
  `total_efectivo` decimal(10,2) DEFAULT NULL,
  `usuario` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `usuario` (`usuario`),
  CONSTRAINT `caja_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO caja VALUES("161","2024-11-23 15:15:51","200.00","135.00","0.00","0.00","0.00","335.00","1","2");
INSERT INTO caja VALUES("162","2024-11-23 16:33:21","200.00","0.00","0.00","0.00","0.00","200.00","1","2");
INSERT INTO caja VALUES("163","2024-11-25 08:54:31","200.00","0.00","0.00","0.00","0.00","200.00","1","2");
INSERT INTO caja VALUES("164","2024-11-25 09:10:29","200.00","0.00","0.00","0.00","0.00","200.00","1","2");
INSERT INTO caja VALUES("165","2024-11-25 10:54:57","200.00","0.00","0.00","0.00","0.00","200.00","1","2");
INSERT INTO caja VALUES("166","2024-11-25 12:12:03","200.00","0.00","0.00","0.00","0.00","200.00","1","2");
INSERT INTO caja VALUES("167","2024-11-25 13:37:26","200.00","0.00","0.00","0.00","0.00","200.00","1","2");



DROP TABLE cliente;

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `nit` varchar(20) DEFAULT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcliente`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO cliente VALUES("1","6031807920003k","Cliente regular","88888888","EL RAMA","2021-12-05 15:47:39","1","1");



DROP TABLE compras;

CREATE TABLE `compras` (
  `nocompra` bigint(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `usuario` int(20) NOT NULL,
  `caja` int(11) NOT NULL,
  `codproveedor` int(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `totalcompra` decimal(10,2) NOT NULL,
  `abono` decimal(10,2) NOT NULL,
  PRIMARY KEY (`nocompra`),
  KEY `usuario` (`usuario`),
  KEY `codproveedor` (`codproveedor`),
  KEY `caja` (`caja`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`codproveedor`) REFERENCES `proveedor` (`codproveedor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compras_ibfk_3` FOREIGN KEY (`caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




DROP TABLE configuracion;

CREATE TABLE `configuracion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nit` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `iva` decimal(10,2) NOT NULL,
  `foto` varchar(200) NOT NULL,
  `moneda` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO configuracion VALUES("1","6232912905005C","Lomas Market","Lomas Market","852892553","lomasmarket@gmail.com","Santiago de Surco","0.00"," ","S/.");



DROP TABLE detalle_recibo;

CREATE TABLE `detalle_recibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noventa` bigint(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `saldo_anterior` decimal(10,2) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `saldo_actual` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `caja` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `noventa` (`noventa`),
  KEY `usuario` (`usuario`),
  KEY `caja` (`caja`),
  CONSTRAINT `detalle_recibo_ibfk_1` FOREIGN KEY (`noventa`) REFERENCES `venta` (`noventa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_recibo_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_recibo_ibfk_3` FOREIGN KEY (`caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




DROP TABLE detalle_recibo_compra;

CREATE TABLE `detalle_recibo_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nocompra` bigint(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `saldo_anterior` decimal(10,2) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `saldo_actual` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `caja` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nocompra` (`nocompra`),
  KEY `usuario` (`usuario`),
  KEY `caja` (`caja`),
  CONSTRAINT `detalle_recibo_compra_ibfk_1` FOREIGN KEY (`nocompra`) REFERENCES `compras` (`nocompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_recibo_compra_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_recibo_compra_ibfk_3` FOREIGN KEY (`caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




DROP TABLE detalle_temp;

CREATE TABLE `detalle_temp` (
  `correlativo` int(11) NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `codproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`correlativo`),
  KEY `codproducto` (`codproducto`),
  KEY `token_user` (`token_user`),
  CONSTRAINT `detalle_temp_ibfk_1` FOREIGN KEY (`codproducto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1960 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO detalle_temp VALUES("1959","c4ca4238a0b923820dcc509a6f75849b","2012","1","110.00","135.00");



DROP TABLE detalle_temp_compra;

CREATE TABLE `detalle_temp_compra` (
  `correlativo` int(11) NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `codproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`correlativo`),
  KEY `token_user` (`token_user`),
  KEY `codproducto` (`codproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




DROP TABLE detalleventa;

CREATE TABLE `detalleventa` (
  `correlativo` bigint(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `noventa` bigint(11) DEFAULT NULL,
  `codproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`correlativo`),
  KEY `codproducto` (`codproducto`),
  KEY `noventa` (`noventa`),
  CONSTRAINT `detalleventa_ibfk_1` FOREIGN KEY (`noventa`) REFERENCES `venta` (`noventa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalleventa_ibfk_2` FOREIGN KEY (`codproducto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1544 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO detalleventa VALUES("1543","2024-11-23 15:16:54","1188","2012","1","110.00","135.00","2");



DROP TABLE egresos;

CREATE TABLE `egresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `descripcion` text NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `caja` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caja` (`caja`),
  CONSTRAINT `egresos_ibfk_1` FOREIGN KEY (`caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




DROP TABLE entradas;

CREATE TABLE `entradas` (
  `correlativo` bigint(11) NOT NULL AUTO_INCREMENT,
  `nocompra` bigint(11) NOT NULL,
  `codproducto` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`correlativo`),
  KEY `codproducto` (`codproducto`),
  KEY `usuario_id` (`usuario_id`),
  KEY `nocompra` (`nocompra`),
  CONSTRAINT `entradas_ibfk_2` FOREIGN KEY (`codproducto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entradas_ibfk_3` FOREIGN KEY (`nocompra`) REFERENCES `compras` (`nocompra`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=897 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;




DROP TABLE producto;

CREATE TABLE `producto` (
  `codproducto` int(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `proveedor` int(11) DEFAULT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `existencia` int(11) NOT NULL,
  `foto` text DEFAULT NULL,
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT 1,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`codproducto`),
  KEY `proveedor` (`proveedor`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`proveedor`) REFERENCES `proveedor` (`codproveedor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2088 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO producto VALUES("1325","DTSI20W5012","ACEITE 20W50 1.2 LTS","1","247.50","280.00","10","img_378a975b453639d824d34353a99bacbe.jpg","2022-01-13 20:23:17","1","1");
INSERT INTO producto VALUES("1326","DTSI20W502R","ACEITE 20W50 1 LTS","1","207.00","235.00","16","img_dc399ccd8b13e81ce0326821c3b42ae9.jpg","2022-01-13 20:24:46","1","1");
INSERT INTO producto VALUES("1327","DTSI20W503R","ACEITE 20W50 3R 1 LTS","1","193.50","220.00","7","img_08b718c6b302e9e9462e8a1a4449bc3c.jpg","2022-01-13 20:25:52","1","1");
INSERT INTO producto VALUES("1552","7042292656","ACEITE RALLYE 140","1","155.00","175.00","9","img_ffd0cdeb3006a16c5073673d846a5a39.jpg","2022-02-11 16:11:35","1","1");
INSERT INTO producto VALUES("1553","MO402","ACEITE LION SAE 40","1","123.35","155.00","15","img_ea10e057fb6c6c85d052180b61762702.jpg","2022-02-11 16:17:41","1","1");
INSERT INTO producto VALUES("1554","15C9BF","ACEITE CASTROL CRB MAX 15W-40","1","960.74","1080.00","0","img_ec5afd5d4f512d8b6ccdf3838852fc29.jpg","2022-02-11 16:19:04","1","1");
INSERT INTO producto VALUES("1555","15D9C1","ACEITE CASTROL ACTEVO 4T 20W-50","1","237.46","260.00","8","img_b2adf96d67c8e73f4023fb450ae7f656.jpg","2022-02-11 16:20:17","1","1");
INSERT INTO producto VALUES("1556","MN7104-1","ACEITE MANNOL MNTS4 15W-40 ","1","124.71","165.00","15","img_7eab08200a0eac1198a184f47a5ed9eb.jpg","2022-02-11 16:22:20","1","1");
INSERT INTO producto VALUES("1557","1030SNGF5BL","ACEITE ULTRA PLUS 10W-30","1","145.00","170.00","11","img_9005a00d6bfcebe68ac554e4d4a1e7e4.jpg","2022-02-11 16:23:36","1","1");
INSERT INTO producto VALUES("1558","800-10-4","LIQUIDO DE FRENO FREE ROJO","1","53.69","65.00","11","img_2d3f21673b30a6dcbdd75e36865f23f1.jpg","2022-02-11 16:24:59","1","1");
INSERT INTO producto VALUES("1559","800-10-3","LIQUIDO DE FRENO BLANCO","1","53.69","65.00","0","img_9bef084aa68a55d1b0476f89fab85543.jpg","2022-02-11 16:25:43","1","1");
INSERT INTO producto VALUES("1560","15D2C4","Aceite Castrol Essential 4T 20W-50","1","189.29","230.00","5","img_cc0f017a87be402fae0d8837ef3926d0.jpg","2022-02-11 16:26:49","1","1");
INSERT INTO producto VALUES("2011","1349","LUBRICANTE DE CADENA LIQUI MOLI","1","305.00","360.00","3","img_producto.png","2022-07-08 18:54:38","1","1");
INSERT INTO producto VALUES("2012","ACEITE HIDRAULICO RO","1350","1","110.00","135.00","1","img_producto.png","2022-07-08 18:55:49","1","1");
INSERT INTO producto VALUES("2087","1351","Aceite 2 tiempo","1","250.00","300.00","0","img_producto.png","2022-09-15 15:04:09","1","1");



DROP TABLE proveedor;

CREATE TABLE `proveedor` (
  `codproveedor` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(100) DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` bigint(11) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT 1,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`codproveedor`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO proveedor VALUES("1","Mercado","Mercado","99999999","Managua","2021-09-21 15:52:42","1","1");



DROP TABLE rol;

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO rol VALUES("1","Administrador");
INSERT INTO rol VALUES("2","Supervisor");
INSERT INTO rol VALUES("3","Vendedor");



DROP TABLE usuario;

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `usuario` varchar(15) DEFAULT NULL,
  `clave` varchar(100) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  PRIMARY KEY (`idusuario`),
  KEY `rol` (`rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO usuario VALUES("1","Admin","admin@gmail.com","admin","81dc9bdb52d04dc20036dbd8313ed055","1","1");
INSERT INTO usuario VALUES("39","Matio Peña","matio@gmail.com","matio","81dc9bdb52d04dc20036dbd8313ed055","3","1");
INSERT INTO usuario VALUES("40","Matias","matias@gmail.com","matias","827ccb0eea8a706c4c34a16891f84e7b","2","1");



DROP TABLE venta;

CREATE TABLE `venta` (
  `noventa` bigint(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario` int(11) DEFAULT NULL,
  `caja` int(11) NOT NULL,
  `codcliente` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `totalventa` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `abono` decimal(10,2) NOT NULL,
  PRIMARY KEY (`noventa`),
  KEY `usuario` (`usuario`),
  KEY `codcliente` (`codcliente`),
  KEY `caja` (`caja`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`codcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1189 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO venta VALUES("1188","2024-11-23 15:16:54","1","161","1","2","135.00","0.00","0.00");



