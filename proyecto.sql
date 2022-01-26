

START TRANSACTION;

CREATE TABLE `figura` (
  `cod_figura` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `color` text NOT NULL,
  `cod_plano` int(11) NOT NULL
) 

CREATE TABLE `jefeProyecto` (
  `cod_jefeProyecto` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `direccion` text NOT NULL,
  `telefono` int(11) NOT NULL,
  `cod_proyecto` int(11) DEFAULT NULL
) 


CREATE TABLE `linea` (
  `id_linea` int(11) NOT NULL,
  `longitud` int(11) NOT NULL,
  `puntos` int(2) NOT NULL
) 



CREATE TABLE `plano` (
  `cod_plano` int(11) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `arquitectos` text NOT NULL,
  `dibujo_plano` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`dibujo_plano`)),
  `num_figuras` int(11) DEFAULT NULL
) 


CREATE TABLE `poligono` (
  `num_lineas` int(11) NOT NULL,
  `id_linea` int(11) DEFAULT NULL
) 

CREATE TABLE `proyecto` (
  `cod_proyecto` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `cod_jefeProyecto` int(11) NOT NULL,
  `cod_plano` int(11) NOT NULL
) 


CREATE TABLE `relacionLineaPoligono` (
  `id_linea` int(11) NOT NULL,
  `num_lineas` int(11) NOT NULL
) 


ALTER TABLE `figura`
  ADD PRIMARY KEY (`cod_figura`),
  ADD UNIQUE KEY `cod_plano_2` (`cod_plano`),
  ADD KEY `cod_plano` (`cod_plano`);


ALTER TABLE `jefeProyecto`
  ADD PRIMARY KEY (`cod_jefeProyecto`),
  ADD KEY `cod_proyecto` (`cod_proyecto`);


ALTER TABLE `linea`
  ADD PRIMARY KEY (`id_linea`);


ALTER TABLE `plano`
  ADD PRIMARY KEY (`cod_plano`),
  ADD KEY `num_figuras` (`num_figuras`);


ALTER TABLE `poligono`
  ADD PRIMARY KEY (`num_lineas`),
  ADD KEY `id_linea` (`id_linea`);


ALTER TABLE `proyecto`
  ADD PRIMARY KEY (`cod_proyecto`),
  ADD UNIQUE KEY `cod_jefeProyecto_2` (`cod_jefeProyecto`),
  ADD KEY `cod_jefeProyecto` (`cod_jefeProyecto`,`cod_plano`),
  ADD KEY `plano` (`cod_plano`);


ALTER TABLE `relacionLineaPoligono`
  ADD PRIMARY KEY (`id_linea`,`num_lineas`),
  ADD KEY `id_linea` (`id_linea`,`num_lineas`),
  ADD KEY `poligono` (`num_lineas`);


ALTER TABLE `jefeProyecto`
  ADD CONSTRAINT `jefeproyecto_ibfk_1` FOREIGN KEY (`cod_jefeProyecto`) REFERENCES `proyecto` (`cod_jefeProyecto`) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `linea`
  ADD CONSTRAINT `linea_ibfk_1` FOREIGN KEY (`id_linea`) REFERENCES `relacionLineaPoligono` (`id_linea`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `plano`
  ADD CONSTRAINT `plano_ibfk_1` FOREIGN KEY (`cod_plano`) REFERENCES `figura` (`cod_plano`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `proyecto`
  ADD CONSTRAINT `jefe` FOREIGN KEY (`cod_jefeProyecto`) REFERENCES `jefeProyecto` (`cod_jefeProyecto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `plano` FOREIGN KEY (`cod_plano`) REFERENCES `plano` (`cod_plano`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `relacionLineaPoligono`
  ADD CONSTRAINT `linea` FOREIGN KEY (`id_linea`) REFERENCES `linea` (`id_linea`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `poligono` FOREIGN KEY (`num_lineas`) REFERENCES `poligono` (`num_lineas`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;

