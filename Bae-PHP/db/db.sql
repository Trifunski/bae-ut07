-- -----------------------------------------------------
-- Schema bdb_basededastos
-- -----------------------------------------------------
START TRANSACTION;
SET time_zone = "+00:00";
DROP SCHEMA IF EXISTS `bdb_basededastos`;
CREATE DATABASE bdb_basededastos;
use bdb_basededastos;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`paginaweb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`paginaweb` (
  `Cod_Pagina` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Estado` INT NULL DEFAULT NULL,
  `UsuariosActivos` INT NULL DEFAULT NULL,
  `UsuariosRegistrados` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO `bdb_basededastos`.`paginaweb` (`Nombre`, `Estado`, `UsuariosActivos`, `UsuariosRegistrados`) VALUES 
('Europa', 1, 10, 100),
('Asia', 0, 5, 50),
('America Norte', 1, 50, 500),
('America Sur', 1, 20, 200),
('Oceanía', 1, 15, 150);

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`grafico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`grafico` (
  `Cod_Grafico` INT NOT NULL AUTO_INCREMENT,
  `IntervaloTiempo` TIME NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  `PAGINAWEB_Cod_Pagina1` INT NOT NULL,
  PRIMARY KEY (`Cod_Grafico`, `PAGINAWEB_Cod_Pagina`),
  INDEX `fk_GRAFICO_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina1` ASC),
  CONSTRAINT `fk_GRAFICO_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina1`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdb_basededastos`.`activos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`activos` (
  `Cod_Activo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Simbolo` VARCHAR(45) NULL DEFAULT NULL,
  `Precios` DECIMAL(10,0) NULL DEFAULT NULL,
  `GRAFICO_Cod_Grafico` INT NOT NULL,
  `GRAFICO_PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Activo`),
  INDEX `fk_ACTIVOS_GRAFICO1_idx` (`GRAFICO_Cod_Grafico` ASC, `GRAFICO_PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_ACTIVOS_GRAFICO1`
    FOREIGN KEY (`GRAFICO_Cod_Grafico` , `GRAFICO_PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`grafico` (`Cod_Grafico` , `PAGINAWEB_Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`articulos` (
  `cod_articulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `texto` VARCHAR(1000) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `categoria` varchar(45) NOT NULL,
  `Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`cod_articulo`),
  CONSTRAINT `fk_ARTICULOS_PAGINAWEB1`
    FOREIGN KEY (`Cod_Pagina`) REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `bdb_basededastos`.`articulos` (`nombre`, `texto`, `fecha_creacion`, `categoria`, `Cod_Pagina`)
VALUES
  ('Artículo 1', 'Contenido del artículo 1 de la página 1', CURDATE(), 'forex', 1),
  ('Artículo 2', 'Contenido del artículo 2 de la página 1', CURDATE(), 'criptomonedas', 1),
  ('Artículo 3', 'Contenido del artículo 3 de la página 1', CURDATE(), 'acciones', 1),
  ('Artículo 1', 'Contenido del artículo 1 de la página 2', CURDATE(), 'futuros', 2),
  ('Artículo 2', 'Contenido del artículo 2 de la página 2', CURDATE(), 'bonos', 2),
  ('Artículo 3', 'Contenido del artículo 3 de la página 2', CURDATE(), 'forex', 2),
  ('Artículo 1', 'Contenido del artículo 1 de la página 3', CURDATE(), 'criptomonedas', 3),
  ('Artículo 2', 'Contenido del artículo 2 de la página 3', CURDATE(), 'acciones', 3),
  ('Artículo 3', 'Contenido del artículo 3 de la página 3', CURDATE(), 'futuros', 3),
  ('Artículo 1', 'Contenido del artículo 1 de la página 4', CURDATE(), 'bonos', 4),
  ('Artículo 2', 'Contenido del artículo 2 de la página 4', CURDATE(), 'forex', 4),
  ('Artículo 3', 'Contenido del artículo 3 de la página 4', CURDATE(), 'criptomonedas', 4),
  ('Artículo 1', 'Contenido del artículo 1 de la página 5', CURDATE(), 'acciones', 5),
  ('Artículo 2', 'Contenido del artículo 2 de la página 5', CURDATE(), 'futuros', 5),
  ('Artículo 3', 'Contenido del artículo 3 de la página 5', CURDATE(), 'bonos', 5);


CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`historico_articulos` (
  `cod_articulo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `texto` VARCHAR(1000) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `categoria` varchar(45) NOT NULL,
  `Cod_Pagina` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`comentarios` (
  `cod_comentario` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(1000) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `likes` int(11) NULL,
  `cod_articulo` int(11) NOT NULL,
  PRIMARY KEY (`cod_comentario`),
  FOREIGN KEY (`cod_articulo`) REFERENCES `articulos` (`cod_articulo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `bdb_basededastos`.`comentarios` (`texto`, `fecha_creacion`, `likes`, `cod_articulo`)
VALUES
  ('Primer comentario para el Artículo 1.', CURDATE(), 5, 1),
  ('Segundo comentario para el Artículo 1.', CURDATE(), 8, 1),
  ('Primer comentario para el Artículo 2.', CURDATE(), 3, 2),
  ('Segundo comentario para el Artículo 2.', CURDATE(), 6, 2),
  ('Primer comentario para el Artículo 3.', CURDATE(), 2, 3),
  ('Segundo comentario para el Artículo 3.', CURDATE(), 4, 3),
  ('Primer comentario para el Artículo 4.', CURDATE(), 7, 4),
  ('Segundo comentario para el Artículo 4.', CURDATE(), 1, 4),
  ('Primer comentario para el Artículo 5.', CURDATE(), 9, 5),
  ('Segundo comentario para el Artículo 5.', CURDATE(), 3, 5),
  ('Primer comentario para el Artículo 6.', CURDATE(), 6, 6),
  ('Segundo comentario para el Artículo 6.', CURDATE(), 2, 6),
  ('Primer comentario para el Artículo 7.', CURDATE(), 4, 7),
  ('Segundo comentario para el Artículo 7.', CURDATE(), 7, 7),
  ('Primer comentario para el Artículo 8.', CURDATE(), 1, 8),
  ('Segundo comentario para el Artículo 8.', CURDATE(), 5, 8),
  ('Primer comentario para el Artículo 9.', CURDATE(), 3, 9),
  ('Segundo comentario para el Artículo 9.', CURDATE(), 9, 9),
  ('Primer comentario para el Artículo 10.', CURDATE(), 8, 10),
  ('Segundo comentario para el Artículo 10.', CURDATE(), 2, 10),
  ('Primer comentario para el Artículo 11.', CURDATE(), 5, 11),
  ('Segundo comentario para el Artículo 11.', CURDATE(), 4, 11),
  ('Primer comentario para el Artículo 12.', CURDATE(), 7, 12),
  ('Segundo comentario para el Artículo 12.', CURDATE(), 1, 12),
  ('Primer comentario para el Artículo 13.', CURDATE(), 3, 13),
  ('Segundo comentario para el Artículo 13.', CURDATE(), 6, 13),
  ('Primer comentario para el Artículo 14.', CURDATE(), 2, 14),
  ('Segundo comentario para el Artículo 14.', CURDATE(), 4, 14);

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`brokers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`brokers` (
  `Cod_Broker` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `TiempoContrato` TIME NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Broker`),
  INDEX `fk_BROKERS_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_BROKERS_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdb_basededastos`.`foro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`foro` (
  `Cod_Foro` INT NOT NULL AUTO_INCREMENT,
  `NombreDebate` VARCHAR(45) NULL DEFAULT NULL,
  `CantidadUsuarios` INT NULL DEFAULT NULL,
  `CantidadRespuestas` INT NULL DEFAULT NULL,
  `FechaCreacion` DATE NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Foro`),
  INDEX `fk_FORO_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_FORO_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`chat` (
  `Cod_Chat` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Texto` VARCHAR(45) NULL DEFAULT NULL,
  `FechaCreacion` DATE NULL DEFAULT NULL,
  `FORO_Cod_Foro` INT NOT NULL,
  PRIMARY KEY (`Cod_Chat`),
  INDEX `fk_CHAT_FORO1_idx` (`FORO_Cod_Foro` ASC),
  CONSTRAINT `fk_CHAT_FORO1`
    FOREIGN KEY (`FORO_Cod_Foro`)
    REFERENCES `bdb_basededastos`.`foro` (`Cod_Foro`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`servidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`servidor` (
  `Cod_Servidor` INT NOT NULL AUTO_INCREMENT,
  `Caracteristicas` VARCHAR(45) NULL DEFAULT NULL,
  `ServidoresActivos` INT NULL DEFAULT NULL,
  `ServidoresMantenimiento` INT NULL DEFAULT NULL,
  `ServidoresInactivos` INT NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Servidor`, `PAGINAWEB_Cod_Pagina`),
  INDEX `fk_SERVIDOR_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_SERVIDOR_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`contienen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`contienen` (
  `SERVIDOR_Cod_Servidor` INT NOT NULL,
  `SERVIDOR_PAGINAWEB_Cod_Pagina` INT NOT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`SERVIDOR_Cod_Servidor`, `SERVIDOR_PAGINAWEB_Cod_Pagina`, `PAGINAWEB_Cod_Pagina`),
  INDEX `fk_SERVIDOR_has_PAGINAWEB_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  INDEX `fk_SERVIDOR_has_PAGINAWEB_SERVIDOR1_idx` (`SERVIDOR_Cod_Servidor` ASC, `SERVIDOR_PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_SERVIDOR_has_PAGINAWEB_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`),
  CONSTRAINT `fk_SERVIDOR_has_PAGINAWEB_SERVIDOR1`
    FOREIGN KEY (`SERVIDOR_Cod_Servidor` , `SERVIDOR_PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`servidor` (`Cod_Servidor` , `PAGINAWEB_Cod_Pagina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`usuarios` (
  `Cod_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `FechaCreacion` DATE NULL DEFAULT NULL,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `ImagenPerfil` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_Usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`cuentas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`cuentas` (
  `Cod_Cuenta` INT NOT NULL AUTO_INCREMENT,
  `Usuario` VARCHAR(45) NOT NULL,
  `CorreoElectronico` VARCHAR(45) NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  `Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Cuenta`),
  CONSTRAINT `fK_CUENTAS_PAGINAWEB1`
    FOREIGN KEY (`Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`empleados` (
  `Cod_Empleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `Edad` INT NULL DEFAULT NULL,
  `FechaNacimiento` DATE NULL DEFAULT NULL,
  `DNI` INT NULL DEFAULT NULL,
  `Telefono` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_Empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`formacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`formacion` (
  `Cod_Formacion` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `FechaHoraClase` DATE NULL DEFAULT NULL,
  `EMPLEADOS_Cod_Empleado` INT NOT NULL,
  PRIMARY KEY (`Cod_Formacion`),
  INDEX `fk_FORMACION_EMPLEADOS_idx` (`EMPLEADOS_Cod_Empleado` ASC),
  CONSTRAINT `fk_FORMACION_EMPLEADOS1`
    FOREIGN KEY (`EMPLEADOS_Cod_Empleado`)
    REFERENCES `bdb_basededastos`.`empleados` (`Cod_Empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`formas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`formas` (
  `Cod_Formas` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NULL DEFAULT NULL,
  `Cantidad` INT NULL DEFAULT NULL,
  `PosicionGrafico` INT NULL DEFAULT NULL,
  `Color` VARCHAR(45) NULL DEFAULT NULL,
  `Tamaño` INT NULL DEFAULT NULL,
  `GRAFICO_Cod_Grafico` INT NOT NULL,
  `GRAFICO_PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Formas`),
  INDEX `fk_FORMAS_GRAFICO1_idx` (`GRAFICO_Cod_Grafico` ASC, `GRAFICO_PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_FORMAS_GRAFICO1`
    FOREIGN KEY (`GRAFICO_Cod_Grafico` , `GRAFICO_PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`grafico` (`Cod_Grafico` , `PAGINAWEB_Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`inversionistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`inversionistas` (
  `Cod_Inversionistas` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Pais` VARCHAR(45) NULL DEFAULT NULL,
  `FechaIcorporacion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_Inversionistas`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`patrocinadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`patrocinadores` (
  `Cod_Patrocinador` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Pais` VARCHAR(45) NULL DEFAULT NULL,
  `TiempoPatrocinio` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_Patrocinador`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`sucursal` (
  `Cod_Sucursal` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Pais` VARCHAR(45) NULL DEFAULT NULL,
  `Ingresos` DECIMAL(10,0) NULL DEFAULT NULL,
  `INVERSIONISTAS_Cod_Inversionistas` INT NOT NULL,
  `PATROCINADORES_Cod_Patrocinador` INT NOT NULL,
  PRIMARY KEY (`Cod_Sucursal`),
  INDEX `fk_SUCURSAL_INVESIONISTAS1_idx` (`INVERSIONISTAS_Cod_Inversionistas` ASC),
  INDEX `fk_SUCURSAL_PATROCINADORES1_idx` (`PATROCINADORES_Cod_Patrocinador` ASC),
  CONSTRAINT `fk_SUCURSAL_INVERSIONISTAS1`
    FOREIGN KEY (`INVERSIONISTAS_Cod_Inversionistas`)
    REFERENCES `bdb_basededastos`.`inversionistas` (`Cod_Inversionistas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SUCURSAL_PATROCINADORES1`
    FOREIGN KEY (`PATROCINADORES_Cod_Patrocinador`)
    REFERENCES `bdb_basededastos`.`patrocinadores` (`Cod_Patrocinador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`gestiona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`gestiona` (
  `SUCURSAL_Cod_Sucursal` INT NOT NULL,
  `SERVIDOR_Cod_Servidor` INT NOT NULL,
  PRIMARY KEY (`SUCURSAL_Cod_Sucursal`, `SERVIDOR_Cod_Servidor`),
  INDEX `fk_SUCURSAL_has_SERVIDOR_SERVIDOR1_idx` (`SERVIDOR_Cod_Servidor` ASC),
  INDEX `fk_SUCURSAL_has_SERVIDOR_SUCURSAL1_idx` (`SUCURSAL_Cod_Sucursal` ASC),
  CONSTRAINT `fk_SUCURSAL_has_SERVIDOR_SERVIDOR1`
    FOREIGN KEY (`SERVIDOR_Cod_Servidor`)
    REFERENCES `bdb_basededastos`.`servidor` (`Cod_Servidor`),
  CONSTRAINT `fk_SUCURSAL_has_SERVIDOR_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_Cod_Sucursal`)
    REFERENCES `bdb_basededastos`.`sucursal` (`Cod_Sucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`indicadores` (
  `Cod_Indicador` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Tipo` VARCHAR(45) NULL DEFAULT NULL,
  `NumIndicadores` INT NULL DEFAULT NULL,
  `GRAFICO_Cod_Grafico` INT NULL DEFAULT NULL,
  `GRAFICO_PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Indicador`),
  INDEX `fk_INDICADORES_GRAFICO1_idx` (`GRAFICO_Cod_Grafico` ASC, `GRAFICO_PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_INDICADORES_GRAFICO1`
    FOREIGN KEY (`GRAFICO_Cod_Grafico` , `GRAFICO_PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`grafico` (`Cod_Grafico` , `PAGINAWEB_Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`mantiene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`mantiene` (
  `EMPLEADOS_Cod_Empleado` INT NOT NULL,
  `SERVIDOR_Cod_Servidor` INT NOT NULL,
  `SERVIDOR_PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`EMPLEADOS_Cod_Empleado`, `SERVIDOR_Cod_Servidor`, `SERVIDOR_PAGINAWEB_Cod_Pagina`),
  INDEX `fk_EMPLEADOS_has_SERVIDOR_SERVIDOR1_idx` (`SERVIDOR_Cod_Servidor` ASC, `SERVIDOR_PAGINAWEB_Cod_Pagina` ASC),
  INDEX `fk_EMPLEADOS_has_SERVIDOR_EMPLEADOS1_idx` (`EMPLEADOS_Cod_Empleado` ASC),
  CONSTRAINT `fk_EMPLEADOS_has_SERVIDOR_EMPLEADOS1`
    FOREIGN KEY (`EMPLEADOS_Cod_Empleado`)
    REFERENCES `bdb_basededastos`.`empleados` (`Cod_Empleado`),
  CONSTRAINT `fk_EMPLEADOS_has_SERVIDOR_SERVIDOR1`
    FOREIGN KEY (`SERVIDOR_Cod_Servidor` , `SERVIDOR_PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`servidor` (`Cod_Servidor` , `PAGINAWEB_Cod_Pagina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`mercado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`mercado` (
  `Cod_Mercado` INT NOT NULL AUTO_INCREMENT,
  `Pais` VARCHAR(45) NULL DEFAULT NULL,
  `Categoria` VARCHAR(45) NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Mercado`, `PAGINAWEB_Cod_Pagina`),
  INDEX `fk_MERCADO_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_MERCADO_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`planes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`planes` (
  `Cod_Plan` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Precio` DECIMAL(10,0) NULL DEFAULT NULL,
  `NumGrafico` INT NULL DEFAULT NULL,
  `NumUsuario` INT NULL DEFAULT NULL,
  `NumIndicadores` INT NULL DEFAULT NULL,
  `TiempoActivo` TIME NULL DEFAULT NULL,
  `PAGINAWEB_Cod_Pagina` INT NOT NULL,
  PRIMARY KEY (`Cod_Plan`, `PAGINAWEB_Cod_Pagina`),
  INDEX `fk_PLANES_PAGINAWEB1_idx` (`PAGINAWEB_Cod_Pagina` ASC),
  CONSTRAINT `fk_PLANES_PAGINAWEB1`
    FOREIGN KEY (`PAGINAWEB_Cod_Pagina`)
    REFERENCES `bdb_basededastos`.`paginaweb` (`Cod_Pagina`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO `bdb_basededastos`.`planes` (`Nombre`, `Precio`, `NumGrafico`, `NumUsuario`, `NumIndicadores`, `TiempoActivo`, `PAGINAWEB_Cod_Pagina`)
VALUES
  ('Plan 1', 9.99, 5, 10, 3, '08:00:00', 1),
  ('Plan 2', 19.99, 10, 20, 5, '12:00:00', 1),
  ('Plan 3', 29.99, 15, 30, 7, '24:00:00', 1),
  ('Plan 1', 9.99, 5, 10, 3, '08:00:00', 2),
  ('Plan 2', 19.99, 10, 20, 5, '12:00:00', 2),
  ('Plan 3', 29.99, 15, 30, 7, '24:00:00', 2),
  ('Plan 1', 9.99, 5, 10, 3, '08:00:00', 3),
  ('Plan 2', 19.99, 10, 20, 5, '12:00:00', 3),
  ('Plan 3', 29.99, 15, 30, 7, '24:00:00', 3),
  ('Plan 1', 9.99, 5, 10, 3, '08:00:00', 4),
  ('Plan 2', 19.99, 10, 20, 5, '12:00:00', 4),
  ('Plan 3', 29.99, 15, 30, 7, '24:00:00', 4),
  ('Plan 1', 9.99, 5, 10, 3, '08:00:00', 5),
  ('Plan 2', 19.99, 10, 20, 5, '12:00:00', 5),
  ('Plan 3', 29.99, 15, 30, 7, '24:00:00', 5);

-- -----------------------------------------------------
-- Table `bdb_basededastos`.`tiene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdb_basededastos`.`tiene` (
  `SUCURSAL_Cod_Sucursal` INT NOT NULL,
  `EMPLEADOS_Cod_Empleado` INT NOT NULL,
  PRIMARY KEY (`SUCURSAL_Cod_Sucursal`, `EMPLEADOS_Cod_Empleado`),
  INDEX `fk_SUCURSAL_has_EMPLEADOS_EMPLEADO1_idx` (`EMPLEADOS_Cod_Empleado` ASC),
  INDEX `fk_SUCURSAL_has_EMPLEADOS_SUCURSAL1_idx` (`SUCURSAL_Cod_Sucursal` ASC),
  CONSTRAINT `fk_SUCURSAL_has_EMPLEADOS_EMPLEADO1`
    FOREIGN KEY (`EMPLEADOS_Cod_Empleado`)
    REFERENCES `bdb_basededastos`.`empleados` (`Cod_Empleado`),
  CONSTRAINT `fk_SUCURSAL_has_EMPLEADOS_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_Cod_Sucursal`)
    REFERENCES `bdb_basededastos`.`sucursal` (`Cod_Sucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

COMMIT;

DELIMITER //

CREATE PROCEDURE agregar_articulo(
    IN p_nombre VARCHAR(255), 
    IN p_texto TEXT, 
    IN p_fecha_creacion DATE, 
    IN p_categoria VARCHAR(255), 
    IN p_cod_pagina INT
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM articulos
    WHERE nombre = p_nombre;
    
    IF v_count > 0 THEN
        SELECT 'Ya existe un artículo con el mismo nombre' AS mensaje;
    ELSEIF INSTR(p_texto, 'hola') > 0 THEN
        SELECT 'El texto del artículo no puede la palabra hola' AS mensaje;
    ELSE
        INSERT INTO articulos (nombre, texto, fecha_creacion, categoria, Cod_Pagina)
        VALUES (p_nombre, p_texto, p_fecha_creacion, p_categoria, p_cod_pagina);
    
        IF ROW_COUNT() > 0 THEN
            SELECT 'Articulo agregado correctamente' AS mensaje;
        ELSE
            SELECT 'Ocurrió un error inesperado al agregar el Articulo' AS mensaje;
        END IF;
    END IF;
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE eliminar_articulo(
  IN p_cod_articulo INT, 
  OUT p_resultado VARCHAR(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_resultado = 'Ocurrió un error inesperado al eliminar el Articulo';
    END;

    DELETE FROM articulos WHERE cod_articulo = p_cod_articulo;

    IF ROW_COUNT() > 0 THEN
        SET p_resultado = 'Articulo eliminado correctamente';
    ELSE
        SET p_resultado = 'No se encontró ningún artículo con el código especificado';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trigger_eliminar_articulo
    AFTER DELETE ON articulos
    FOR EACH ROW
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM historico_articulos
            WHERE cod_articulo = OLD.cod_articulo
        ) THEN
            INSERT INTO historico_articulos (
                cod_articulo, 
                nombre, 
                texto, 
                fecha_creacion, 
                categoria, 
                cod_pagina
            )
            VALUES (
                OLD.cod_articulo, 
                OLD.nombre, 
                OLD.texto, 
                OLD.fecha_creacion, 
                OLD.categoria, 
                OLD.cod_pagina
            );
        END IF;
    END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE listar_articulo(
    IN cod_pagina_param INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al obtener el Listado de Articulos' AS error_message;
    END;

    SELECT DISTINCT cod_articulo, nombre, texto, fecha_creacion, categoria
    FROM articulos
    WHERE cod_pagina = cod_pagina_param;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE total_articulo(IN codpag INT)
BEGIN
    DECLARE cod INT;
    DECLARE total INT DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT cod_articulo FROM articulos WHERE cod_pagina = codpag;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN CUR;

    read_loop: LOOP
        FETCH cur INTO cod;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SET total = total + 1;
    END LOOP;

    CLOSE cur;

    SELECT total AS total_articulos;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modificar_articulo
(
    IN p_cod_articulo INT,
    IN p_nombre VARCHAR(255),
    IN p_texto TEXT,
    IN p_fecha_creacion DATE,
    IN p_categoria VARCHAR(255)
)
BEGIN
    DECLARE errorMessage VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 errorMessage = MESSAGE_TEXT;
        SELECT CONCAT('Ocurrió un error: ', errorMessage) AS ErrorMessage;
    END;

    UPDATE articulos
    SET nombre = p_nombre,
        texto = p_texto,
        fecha_creacion = p_fecha_creacion,
        categoria = p_categoria
    WHERE cod_articulo = p_cod_articulo;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Articulo modificado correctamente' AS Message;
    ELSE
        SELECT 'No se encontró el Articulo con el código especificado' AS Message;
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtener_articulo(IN cod_articulo INT)
BEGIN
    SELECT *
    FROM articulos
    WHERE cod_articulo = cod_articulo;
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE agregar_comentario (
    IN p_texto VARCHAR(255),
    IN p_fecha_creacion DATETIME,
    IN p_likes INT,
    IN p_cod_articulo INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        SELECT 'Ocurrió un error: ', MYSQL_ERRNO, ' - ', MYSQL_ERROR;
    END;

    START TRANSACTION;
    
    INSERT INTO comentarios (texto, fecha_creacion, likes, cod_articulo)
    VALUES (p_texto, p_fecha_creacion, p_likes, p_cod_articulo);
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Comentario agregado correctamente';
    ELSE
        SELECT 'Ocurrió un error inesperado al agregar el Comentario';
    END IF;

    COMMIT;
END//

DELIMITER;

DELIMITER //

CREATE PROCEDURE modificar_comentario(
    IN p_cod_comentario INT,
    IN p_texto VARCHAR(255)
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        SELECT 'Ocurrió un error inesperado al editar el Comentario' AS message;
    END;

    UPDATE comentarios
    SET texto = p_texto
    WHERE cod_comentario = p_cod_comentario;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Comentario editado correctamente' AS message;
    ELSE
        SELECT 'El Comentario no existe' AS message;
    END IF;
END//

DELIMITER;

DELIMITER //

CREATE PROCEDURE eliminar_comentario(IN cod_comentario INT)
BEGIN
    BEGIN
        DELETE FROM comentarios WHERE cod_comentario = cod_comentario;
        SELECT 'Comentario eliminado correctamente' AS Message;
    END;
END//

DELIMITER ;


DELIMITER //
CREATE PROCEDURE listar_comentario(IN id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al obtener el Listado de Comentarios' AS Message;
    END;
    
    SELECT DISTINCT * FROM comentarios WHERE Cod_Articulo = id;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtener_comentario(IN cod_comentario INT)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = 1;
        SELECT CONCAT('Ocurrió un error: ', SQLEXCEPTION.MESSAGE) AS error_message;
    END;

    SELECT * FROM comentarios WHERE cod_comentario = cod_comentario;

    IF error_occurred = 0 THEN
        SELECT * FROM comentarios WHERE cod_comentario = cod_comentario;
    ELSE
        SELECT 'Ocurrió un error inesperado al obtener el Comentario' AS error_message;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE agregar_pagina (
    IN p_nombre VARCHAR(255),
    IN p_estado VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar la Pagina' AS mensaje;
    END;

    START TRANSACTION;

    INSERT INTO paginaweb (nombre, estado)
    VALUES (p_nombre, p_estado);

    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT 'Creado correctamente' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar la Pagina' AS mensaje;
    END IF;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE modificar_pagina(
    IN p_cod_pagina INT,
    IN p_nombre VARCHAR(255),
    IN p_estado VARCHAR(255)
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al modificar la página' AS message;
    END;
    
    DECLARE exit handler for sqlwarning
    BEGIN
        ROLLBACK;
        SELECT 'Advertencia: Ocurrió una advertencia al modificar la página' AS message;
    END;

    START TRANSACTION;

    UPDATE paginaweb
    SET nombre = p_nombre, estado = p_estado
    WHERE cod_pagina = p_cod_pagina;

    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT 'Página modificada correctamente' AS message;
    ELSE
        ROLLBACK;
        SELECT 'No se encontró la página con el código especificado' AS message;
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE eliminar_pagina(
  IN cod_pagina INT
)
BEGIN
    DELETE FROM paginaweb WHERE cod_pagina = cod_pagina;
END//

DELIMITER;

DELIMITER //

CREATE PROCEDURE listar_pagina()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al listar la página' AS Result;
    END;

    IF EXISTS (SELECT * FROM information_schema.tables WHERE table_name = 'paginaweb') THEN
        SELECT *
        FROM paginaweb
        ORDER BY Estado DESC;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La tabla paginaweb no existe';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtener_pagina(
  IN cod_pagina INT
)
BEGIN
    SELECT * FROM paginaweb WHERE cod_pagina = cod_pagina;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE agregar_plan(
    IN p_Nombre VARCHAR(255),
    IN p_Precio DECIMAL(10, 2),
    IN p_NumGrafico INT,
    IN p_NumUsuario INT,
    IN p_NumIndicadores INT,
    IN p_CodPagina INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END;

    START TRANSACTION;

    IF p_NumGrafico > 20 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END IF;

    INSERT INTO planes (Nombre, Precio, NumGrafico, NumUsuario, NumIndicadores, PAGINAWEB_Cod_Pagina)
    VALUES (p_Nombre, p_Precio, p_NumGrafico, p_NumUsuario, p_NumIndicadores, p_CodPagina);

    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan agregado correctamente';
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar el Plan';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE modificar_plan
(
    IN p_CodPlan INT,
    IN p_Nombre VARCHAR(255),
    IN p_Precio DECIMAL(10,2),
    IN p_NumGrafico INT,
    IN p_NumUsuario INT,
    IN p_NumIndicadores INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END;

    START TRANSACTION;

    IF p_NumGrafico > 20 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END IF;

    UPDATE planes
    SET Nombre = p_Nombre,
        Precio = p_Precio,
        NumGrafico = p_NumGrafico,
        NumUsuario = p_NumUsuario,
        NumIndicadores = p_NumIndicadores
    WHERE Cod_Plan = p_CodPlan;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan modificado correctamente' AS Result;
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al modificar el Plan' AS Result;
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE eliminar_plan(IN p_Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT CONCAT('Ocurrió un error: ', ERROR_MESSAGE()) AS ErrorMessage;
    END;
    
    DELETE FROM planes WHERE Cod_Plan = p_Cod_Plan;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan eliminado correctamente' AS Message;
    ELSE
        SELECT 'Ocurrió un error inesperado al eliminar el Plan' AS ErrorMessage;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE listar_plan(IN Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al listar los Planes' AS Message;
    END;

    SELECT * FROM planes WHERE PAGINAWEB_Cod_Pagina = Cod_Plan ORDER BY Cod_Plan;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtener_plan(IN p_Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error: ' || SQLERRM;
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT * FROM planes WHERE Cod_Plan = p_Cod_Plan;

    IF FOUND_ROWS() > 0 THEN
        SELECT * FROM planes WHERE Cod_Plan = p_Cod_Plan LIMIT 1;
    ELSE
        SELECT 'Ocurrió un error inesperado al obtener el Plan';
    END IF;

    COMMIT;
END //

DELIMITER ;
