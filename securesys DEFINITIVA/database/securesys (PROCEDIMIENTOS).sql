-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-03-2025 a las 02:28:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Base de datos: `securesys`
--
CREATE DATABASE IF NOT EXISTS securesys;
USE securesys;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `tipo` enum('Residencial','Comercial','Industrial','Gubernamental') NOT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `documento_fiscal` varchar(50) NOT NULL,
  `direccion` text DEFAULT NULL,
  `coordenadas` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `contacto_emergencia` varchar(255) DEFAULT NULL,
  `nivel_riesgo` enum('Bajo','Medio','Alto') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `contrato_vigente` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `tipo`, `razon_social`, `documento_fiscal`, `direccion`, `coordenadas`, `telefono`, `contacto_emergencia`, `nivel_riesgo`, `fecha_inicio`, `contrato_vigente`) VALUES
(1, 'Comercial', 'Empresa Alpha S.A.', 'ABC123456', 'Av. Principal 123', '10.1234,-67.5678', '123456789', 'Carlos López', 'Medio', '2024-01-10', 1),
(2, 'Residencial', 'Juan Pérez', 'DEF789012', 'Calle Secundaria 456', '10.5678,-67.1234', '987654321', 'Ana Pérez', 'Bajo', '2023-11-15', 1),
(3, 'Industrial', 'Fábrica XYZ Ltda.', 'GHI345678', 'Zona Industrial 789', '10.8765,-67.2345', '555555555', 'Mario Torres', 'Alto', '2022-09-30', 1),
(4, 'Gubernamental', 'Ministerio de Seguridad', 'JKL901234', 'Plaza Central 1000', '10.6789,-67.8765', '777777777', 'Oficial Ramírez', '', '2021-05-20', 1),
(5, 'Comercial', 'Tech Solutions S.A.', 'MNO567890', 'Calle Innovación 500', '10.5432,-67.7654', '666666666', 'Lucía Méndez', 'Medio', '2023-03-12', 1),
(6, 'Residencial', 'Pedro González', 'PQR123456', 'Av. Libertador 321', '10.6543,-67.8765', '333333333', 'José González', 'Bajo', '2024-02-28', 1),
(7, 'Industrial', 'Metalurgia 2000 C.A.', 'STU789012', 'Carretera 5, Galpón 7', '10.7890,-67.4321', '888888888', 'Luis Rodríguez', 'Alto', '2022-12-10', 1),
(8, 'Gubernamental', 'Alcaldía Local', 'VWX345678', 'Edificio Municipal, Centro', '10.4321,-67.7890', '999999999', 'María Gómez', '', '2023-06-05', 1),
(9, 'Comercial', 'Supermercado ABC', 'YZA901234', 'Boulevard 10', '10.2109,-67.6543', '444444444', 'Esteban Morales', 'Medio', '2023-08-20', 1),
(10, 'Residencial', 'Sofía Herrera', 'BCD567890', 'Calle de la Paz 99', '10.8765,-67.2109', '222222222', 'Carlos Herrera', 'Bajo', '2024-01-01', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunicaciones_emergencia`
--

CREATE TABLE `comunicaciones_emergencia` (
  `comunicacion_id` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `origen` enum('Cliente','Sensor','Vigilante') NOT NULL,
  `medio` enum('Teléfono','Radio','Sistema automatizado') NOT NULL,
  `instalacion_id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `operador_id` int(11) NOT NULL,
  `clasificacion_urgencia` enum('Baja','Media','Alta') NOT NULL,
  `protocolo_activado` text DEFAULT NULL,
  `respuesta_enviada` text DEFAULT NULL,
  `tiempo_resolucion` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comunicaciones_emergencia`
--

INSERT INTO `comunicaciones_emergencia` (`comunicacion_id`, `fecha_hora`, `origen`, `medio`, `instalacion_id`, `mensaje`, `operador_id`, `clasificacion_urgencia`, `protocolo_activado`, `respuesta_enviada`, `tiempo_resolucion`) VALUES
(1, '2025-03-20 14:30:00', 'Cliente', 'Teléfono', 1, 'Intruso detectado en el perímetro', 1, 'Alta', 'Patrulla enviada', 'Incidente resuelto', '00:15:00'),
(2, '2025-03-21 09:45:00', 'Sensor', 'Sistema automatizado', 2, 'Alarma activada en acceso principal', 2, 'Media', 'Verificación en curso', 'Guardia enviado', '00:10:00'),
(3, '2025-03-22 18:20:00', 'Vigilante', 'Radio', 3, 'Sospechoso merodeando la zona', 3, 'Alta', 'Supervisión reforzada', 'Policía alertada', '00:25:00'),
(4, '2025-03-23 22:10:00', 'Cliente', 'Teléfono', 4, 'Ruido sospechoso en bodega', 4, 'Baja', 'Supervisión remota', 'Observación continua', '00:05:00'),
(5, '2025-03-24 07:30:00', 'Sensor', 'Sistema automatizado', 5, 'Corte de energía en instalaciones', 5, 'Media', 'Revisión eléctrica', 'Técnico notificado', '00:20:00'),
(6, '2025-03-25 13:00:00', 'Vigilante', 'Radio', 6, 'Paquete sospechoso en la entrada', 6, 'Alta', 'Verificación inmediata', 'Equipo antibombas alertado', '00:30:00'),
(7, '2025-03-26 16:45:00', 'Cliente', 'Teléfono', 7, 'Vehículo desconocido en zona privada', 7, 'Media', 'Control vehicular', 'Registro en bitácora', '00:10:00'),
(8, '2025-03-27 19:15:00', 'Sensor', 'Sistema automatizado', 8, 'Apertura no autorizada de acceso', 8, 'Alta', 'Patrulla de emergencia', 'Guardia desplegado', '00:18:00'),
(9, '2025-03-28 11:50:00', 'Vigilante', 'Radio', 9, 'Persona con actitud sospechosa', 9, 'Baja', 'Observación y reporte', 'Reporte generado', '00:07:00'),
(10, '2025-03-29 20:40:00', 'Cliente', 'Teléfono', 10, 'Fuego detectado en cocina', 10, 'Alta', 'Protocolo contra incendios', 'Bomberos llamados', '00:12:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivos`
--

CREATE TABLE `dispositivos` (
  `dispositivo_id` int(11) NOT NULL,
  `instalacion_id` int(11) NOT NULL,
  `numero_serie` varchar(50) NOT NULL,
  `tipo` enum('Cámara','Sensor','Alarma','Control Acceso') NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `fecha_instalacion` date DEFAULT NULL,
  `caracteristicas` text DEFAULT NULL,
  `cobertura` text DEFAULT NULL,
  `conexiones` text DEFAULT NULL,
  `ultimo_mantenimiento` date DEFAULT NULL,
  `estado_operativo` enum('Operativo','En reparación','Fuera de servicio') NOT NULL,
  `garantia` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dispositivos`
--

INSERT INTO `dispositivos` (`dispositivo_id`, `instalacion_id`, `numero_serie`, `tipo`, `marca`, `modelo`, `ubicacion`, `fecha_instalacion`, `caracteristicas`, `cobertura`, `conexiones`, `ultimo_mantenimiento`, `estado_operativo`, `garantia`) VALUES
(1, 1, 'SN001', 'Cámara', 'Hikvision', 'DS-2CD2142FWD-I', 'Entrada principal', '2023-05-10', 'Resolución 1080p, visión nocturna', '120°', 'Red cableada', '2024-02-20', 'Operativo', 1),
(2, 2, 'SN002', 'Sensor', 'Honeywell', '5800PIR-RES', 'Pasillo', '2023-06-15', 'Infrarrojo pasivo', '8 metros', 'Inalámbrico', '2024-03-10', 'Operativo', 1),
(3, 3, 'SN003', 'Alarma', 'ADT', 'ADT-110', 'Oficina', '2022-11-20', 'Alarma sonora 110dB', 'Toda la oficina', 'Red cableada', '2024-01-25', 'Operativo', 1),
(4, 4, 'SN004', 'Control Acceso', 'ZKTeco', 'F18', 'Entrada principal', '2021-09-05', 'Huella dactilar y tarjeta', '1 puerta', 'Red cableada', '2023-12-10', 'Operativo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidentes_seguridad`
--

CREATE TABLE `incidentes_seguridad` (
  `incidente_id` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `instalacion_id` int(11) NOT NULL,
  `zona` varchar(255) DEFAULT NULL,
  `tipo` enum('Intrusión','Robo','Incendio','Agresión') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `personal_involucrado` text DEFAULT NULL,
  `respuesta_implementada` text DEFAULT NULL,
  `tiempo_reaccion` int(11) DEFAULT NULL,
  `danos_perdidas` text DEFAULT NULL,
  `informe_policial` text DEFAULT NULL,
  `seguimiento` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `incidentes_seguridad`
--

INSERT INTO `incidentes_seguridad` (`incidente_id`, `fecha_hora`, `instalacion_id`, `zona`, `tipo`, `descripcion`, `personal_involucrado`, `respuesta_implementada`, `tiempo_reaccion`, `danos_perdidas`, `informe_policial`, `seguimiento`) VALUES
(1, '2024-02-01 14:30:00', 1, 'Entrada Principal', 'Intrusión', 'Persona no autorizada intentó ingresar.', 'Carlos Martínez', 'Se activó protocolo de seguridad y se escoltó fuera.', 3, 'Sin daños.', 'No requerido.', 'Vigilancia reforzada en la entrada.'),
(2, '2024-02-05 22:15:00', 2, 'Almacén', 'Robo', 'Hurto de equipos electrónicos detectado.', 'Luis Pérez, Ricardo Torres', 'Se notificó a la policía y se revisaron cámaras.', 7, 'Pérdida de 2 laptops.', 'Denuncia realizada.', 'Instalación de nuevas cerraduras.'),
(3, '2024-05-10 18:45:00', 3, 'Estacionamiento', 'Agresión', 'Empleado reportó un altercado con un visitante.', 'María Gómez', 'Se llamó a seguridad interna y se resolvió pacíficamente.', 5, 'No hubo daños físicos.', 'No requerido.', 'Se revisaron grabaciones y se advirtió al visitante.'),
(4, '2024-09-15 03:10:00', 4, 'Pasillo C', 'Intrusión', 'Movimiento sospechoso detectado en cámaras.', 'Ana Ramírez', 'Se realizó patrullaje y no se encontró amenaza.', 4, 'Sin daños.', 'No requerido.', 'Se reforzó iluminación en la zona.'),
(5, '2024-01-18 12:00:00', 5, 'Área de carga', 'Robo', 'Se reportó la sustracción de mercancía.', 'Javier Sánchez', 'Se cerraron accesos y se revisaron cámaras.', 6, 'Pérdida de 5 paquetes.', 'Reporte policial en curso.', 'Se implementó control de acceso biométrico.'),
(6, '2024-03-22 07:30:00', 6, 'Sala de servidores', 'Incendio', 'Pequeño conato de incendio en cableado eléctrico.', 'Elena López', 'Extintores usados y se llamó a bomberos.', 2, 'Sin pérdidas mayores.', 'Informe de bomberos.', 'Se revisó y mejoró el sistema eléctrico.'),
(7, '2024-07-25 20:20:00', 7, 'Recepción', 'Agresión', 'Un visitante alterado empujó a un guardia.', 'Ricardo Torres', 'Se contuvo la situación y se llamó a la policía.', 3, 'Lesión leve en el guardia.', 'Denuncia presentada.', 'Capacitación en manejo de conflictos.'),
(8, '2024-10-27 16:55:00', 8, 'Bodega', 'Robo', 'Se detectó forzamiento de cerraduras.', 'Patricia Fernández', 'Se revisó con la policía y se aseguraron las puertas.', 8, 'Daños en cerraduras.', 'Investigación en curso.', 'Se reforzaron medidas de seguridad.'),
(9, '2024-08-29 23:40:00', 9, 'Patio trasero', 'Intrusión', 'Se detectó a una persona merodeando.', 'Diego Rojas', 'Se realizó inspección y no hubo incidentes mayores.', 5, 'Sin daños.', 'No requerido.', 'Mayor vigilancia en la zona.'),
(10, '0000-00-00 00:00:00', 10, 'Oficina principal', 'Robo', 'Intento de robo en archivo de documentos.', 'Natalia Castillo', 'Guardia intervino y evitó el hurto.', 4, 'Sin pérdidas.', 'No requerido.', 'Se reforzó seguridad en el área.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_incidentes`
--

CREATE TABLE `informes_incidentes` (
  `informe_id` int(11) NOT NULL,
  `incidente_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `informes_incidentes`
--

INSERT INTO `informes_incidentes` (`informe_id`, `incidente_id`) VALUES
(1, 2),
(1, 5),
(2, 1),
(2, 3),
(3, 6),
(4, 4),
(4, 8),
(5, 7),
(6, 9),
(7, 10),
(8, 2),
(9, 5),
(10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_servicio`
--

CREATE TABLE `informes_servicio` (
  `informe_id` int(11) NOT NULL,
  `periodo_cubierto` varchar(50) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `instalaciones` text DEFAULT NULL,
  `servicios_prestados` text DEFAULT NULL,
  `cumplimiento` text DEFAULT NULL,
  `incidentes` text DEFAULT NULL,
  `recomendaciones` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `evaluacion_general` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `informes_servicio`
--

INSERT INTO `informes_servicio` (`informe_id`, `periodo_cubierto`, `cliente_id`, `instalaciones`, `servicios_prestados`, `cumplimiento`, `incidentes`, `recomendaciones`, `observaciones`, `evaluacion_general`) VALUES
(1, 'Enero 2025', 1, 'Instalación A, Instalación B', 'Vigilancia 24/7, Control de accesos', 'Cumplimiento del 98%', '2 incidentes menores reportados', 'Mayor iluminación en perímetro', 'Buen desempeño del personal', 'Muy satisfactorio'),
(2, 'Febrero 2025', 2, 'Instalación C', 'Supervisión y patrullaje', 'Cumplimiento del 95%', '1 intento de intrusión detectado', 'Reforzar rondas nocturnas', 'Requiere ajuste en protocolos', 'Satisfactorio'),
(3, 'Marzo 2025', 3, 'Instalación D', 'Escolta VIP y monitoreo', 'Cumplimiento del 99%', 'Sin incidentes', 'Mantener protocolos actuales', 'Atención rápida del equipo', 'Excelente'),
(4, 'Abril 2025', 4, 'Instalación E, Instalación F', 'Seguridad en eventos', 'Cumplimiento del 97%', '1 robo menor en zona común', 'Mayor control en accesos', 'Coordinación efectiva', 'Muy satisfactorio'),
(5, 'Mayo 2025', 5, 'Instalación G', 'Resguardo perimetral', 'Cumplimiento del 96%', '1 conato de incendio controlado', 'Revisión de equipos contra incendios', 'Reacción rápida del personal', 'Satisfactorio'),
(6, 'Junio 2025', 6, 'Instalación H', 'Supervisión y monitoreo de cámaras', 'Cumplimiento del 99%', '1 altercado en recepción', 'Capacitación en manejo de conflictos', 'Mejor coordinación con recepción', 'Excelente'),
(7, 'Julio 2025', 7, 'Instalación I', 'Patrullaje nocturno', 'Cumplimiento del 94%', '2 reportes de actividad sospechosa', 'Más presencia en zonas vulnerables', 'Buen nivel de respuesta', 'Satisfactorio'),
(8, 'Agosto 2025', 8, 'Instalación J', 'Seguridad industrial', 'Cumplimiento del 97%', '1 falla en cerraduras detectada', 'Mantenimiento preventivo en accesos', 'Buena comunicación con cliente', 'Muy satisfactorio'),
(9, 'Septiembre 2025', 9, 'Instalación K', 'Protección de activos', 'Cumplimiento del 98%', 'Sin incidentes', 'Seguir con protocolos actuales', 'Personal altamente capacitado', 'Excelente'),
(10, 'Octubre 2025', 10, 'Instalación L', 'Control de accesos y escolta', 'Cumplimiento del 96%', '1 intento de ingreso no autorizado', 'Mejorar control documental', 'Tiempo de reacción adecuado', 'Satisfactorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instalaciones`
--

CREATE TABLE `instalaciones` (
  `instalacion_id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `direccion` text NOT NULL,
  `coordenadas` varchar(100) DEFAULT NULL,
  `superficie` decimal(10,2) DEFAULT NULL,
  `perimetro` decimal(10,2) DEFAULT NULL,
  `planos` blob DEFAULT NULL,
  `accesos` text DEFAULT NULL,
  `zonas_criticas` text DEFAULT NULL,
  `nivel_seguridad` enum('Bajo','Medio','Alto','Máximo') NOT NULL,
  `horarios_operacion` text DEFAULT NULL,
  `personal_habitual` text DEFAULT NULL,
  `bienes_valor` text DEFAULT NULL,
  `protocolo_especifico` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instalaciones`
--

INSERT INTO `instalaciones` (`instalacion_id`, `cliente_id`, `tipo`, `direccion`, `coordenadas`, `superficie`, `perimetro`, `planos`, `accesos`, `zonas_criticas`, `nivel_seguridad`, `horarios_operacion`, `personal_habitual`, `bienes_valor`, `protocolo_especifico`) VALUES
(1, 1, 'Oficina', 'Av. Principal 123', '10.1234,-67.5678', 200.00, 50.00, NULL, '2 entradas principales', 'Sala de servidores', 'Medio', '08:00-18:00', '5 empleados', 'Computadoras, cajas fuertes', 'Protocolo de evacuación'),
(2, 2, 'Residencia', 'Calle Secundaria 456', '10.5678,-67.1234', 120.00, 40.00, NULL, '1 puerta principal, 1 trasera', 'Cochera', 'Bajo', '24 horas', 'Familia Pérez', 'Electrodomésticos, vehículos', 'Alarma automática'),
(3, 3, 'Fábrica', 'Zona Industrial 789', '10.8765,-67.2345', 1000.00, 200.00, NULL, 'Entrada principal, acceso carga', 'Zona de químicos', 'Alto', '06:00-20:00', '50 empleados', 'Maquinaria pesada', 'Extintores y rutas de escape'),
(4, 4, 'Ministerio', 'Plaza Central 1000', '10.6789,-67.8765', 5000.00, 500.00, NULL, '3 entradas con control', 'Área de archivos', 'Máximo', '07:00-17:00', '100 funcionarios', 'Documentos clasificados', 'Protocolos de acceso y emergencias'),
(5, 5, 'Tienda', 'Calle Innovación 500', '10.5432,-67.7654', 300.00, 70.00, NULL, '2 accesos', 'Caja fuerte', 'Medio', '09:00-21:00', '10 empleados', 'Dinero en efectivo', 'Seguridad privada'),
(6, 6, 'Casa', 'Av. Libertador 321', '10.6543,-67.8765', 150.00, 35.00, NULL, '1 entrada principal', 'Habitación principal', 'Bajo', '24 horas', 'Familia González', 'Joyería, electrónica', 'Sistema de cámaras'),
(7, 7, 'Almacén', 'Carretera 5, Galpón 7', '10.7890,-67.4321', 800.00, 150.00, NULL, 'Entrada principal y secundaria', 'Zona de almacenamiento', 'Alto', '06:00-18:00', '20 empleados', 'Mercancía', 'Sistema de alarmas y guardias'),
(8, 8, 'Edificio Público', 'Edificio Municipal, Centro', '10.4321,-67.7890', 3000.00, 400.00, NULL, '3 accesos con torniquetes', 'Oficina del alcalde', 'Máximo', '07:00-19:00', '50 empleados', 'Equipos de oficina', 'Control de accesos biométricos'),
(9, 9, 'Supermercado', 'Boulevard 10', '10.2109,-67.6543', 900.00, 180.00, NULL, '2 accesos principales', 'Zona de cajas registradoras', 'Medio', '07:00-23:00', '30 empleados', 'Dinero en efectivo', 'Sistema de alarmas y cámaras'),
(10, 10, 'Residencia', 'Calle de la Paz 99', '10.8765,-67.2109', 130.00, 38.00, NULL, '1 puerta principal', 'Garaje', 'Bajo', '24 horas', 'Familia Herrera', 'Electrodomésticos, dinero en efectivo', 'Sistema de cámaras y alarmas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_seguridad`
--

CREATE TABLE `personal_seguridad` (
  `empleado_id` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `documento_identidad` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` text DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `licencia_seguridad` varchar(50) NOT NULL,
  `formacion` text DEFAULT NULL,
  `certificaciones` text DEFAULT NULL,
  `experiencia` int(11) DEFAULT NULL CHECK (`experiencia` >= 0),
  `especializacion` enum('Vigilante','Escolta','Supervisor') NOT NULL,
  `disponibilidad_turnos` text DEFAULT NULL,
  `instalacion_asignada` int(11) DEFAULT NULL,
  `evaluacion_periodica` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal_seguridad`
--

INSERT INTO `personal_seguridad` (`empleado_id`, `nombres`, `apellidos`, `documento_identidad`, `fecha_nacimiento`, `direccion`, `telefono`, `licencia_seguridad`, `formacion`, `certificaciones`, `experiencia`, `especializacion`, `disponibilidad_turnos`, `instalacion_asignada`, `evaluacion_periodica`) VALUES
(1, 'Carlos', 'Martínez', 'V12345678', '1985-06-10', 'Calle A 123', '555111222', 'LS001', 'Vigilante profesional', 'Certificado en manejo de crisis', 5, 'Vigilante', 'Turnos rotativos', 1, 'Aprobado'),
(2, 'María', 'Gómez', 'V87654321', '1990-03-25', 'Av. B 456', '555222333', 'LS002', 'Supervisión de seguridad', 'Certificado en defensa personal', 7, '', 'Turnos fijos', 2, 'Aprobado'),
(3, 'Luis', 'Pérez', 'V11223344', '1988-09-12', 'Calle C 789', '555333444', 'LS003', 'Escolta VIP', 'Certificado en manejo de armas', 10, 'Escolta', 'Nocturno', 3, 'Aprobado'),
(4, 'Ana', 'Ramírez', 'V44332211', '1995-12-05', 'Av. D 321', '555444555', 'LS004', 'Control de accesos', 'Certificado en vigilancia electrónica', 3, 'Vigilante', 'Diurno', 4, 'Pendiente'),
(5, 'Javier', 'Sánchez', 'V55443322', '1983-07-20', 'Calle E 654', '555555666', 'LS005', 'Tácticas de defensa', 'Certificado en primeros auxilios', 8, 'Supervisor', 'Turnos rotativos', 5, 'Aprobado'),
(6, 'Elena', 'López', 'V66778899', '1992-04-15', 'Av. F 987', '555666777', 'LS006', 'Vigilante profesional', 'Certificado en detección de amenazas', 6, 'Vigilante', 'Turnos fijos', 6, 'Aprobado'),
(7, 'Ricardo', 'Torres', 'V99887766', '1987-01-30', 'Calle G 159', '555777888', 'LS007', 'Supervisión de seguridad', 'Certificado en manejo de conflictos', 9, 'Supervisor', 'Turnos rotativos', 7, 'Pendiente'),
(8, 'Patricia', 'Fernández', 'V11224466', '1991-08-08', 'Av. H 753', '555888999', 'LS008', 'Escolta VIP', 'Certificado en conducción evasiva', 4, 'Escolta', 'Diurno', 8, 'Aprobado'),
(9, 'Diego', 'Rojas', 'V22335577', '1993-11-02', 'Calle I 951', '555999000', 'LS009', 'Control de accesos', 'Certificado en tecnología de seguridad', 5, 'Vigilante', 'Nocturno', 9, 'Aprobado'),
(10, 'Natalia', 'Castillo', 'V33446688', '1996-05-17', 'Av. J 852', '555000111', 'LS010', 'Vigilante profesional', 'Certificado en seguridad perimetral', 2, 'Vigilante', 'Turnos rotativos', 10, 'Pendiente'),
(11, 'Carlos', 'Martínez', 'V12343678', '1985-06-10', 'Calle A 123', '555111222', 'LS001', 'Vigilante profesional', 'Certificado en manejo de crisis', 5, 'Vigilante', 'Turnos rotativos', 1, 'Aprobado'),
(12, 'María', 'Gómez', 'H87654321', '1990-03-25', 'Av. B 456', '555222333', 'LS002', 'Supervisión de seguridad', 'Certificado en defensa personal', 7, 'Supervisor', 'Turnos fijos', 2, 'Aprobado'),
(13, 'Luis', 'Pérez', 'G11223344', '1988-09-12', 'Calle C 789', '555333444', 'LS003', 'Escolta VIP', 'Certificado en manejo de armas', 10, 'Escolta', 'Nocturno', 3, 'Aprobado'),
(14, 'Ana', 'Ramírez', 'L44332211', '1995-12-05', 'Av. D 321', '555444555', 'LS004', 'Control de accesos', 'Certificado en vigilancia electrónica', 3, 'Vigilante', 'Diurno', 4, 'Pendiente'),
(15, 'Javier', 'Sánchez', 'P55443322', '1983-07-20', 'Calle E 654', '555555666', 'LS005', 'Tácticas de defensa', 'Certificado en primeros auxilios', 8, 'Supervisor', 'Turnos rotativos', 5, 'Aprobado'),
(16, 'Elena', 'López', 'W66778899', '1992-04-15', 'Av. F 987', '555666777', 'LS006', 'Vigilante profesional', 'Certificado en detección de amenazas', 6, 'Vigilante', 'Turnos fijos', 6, 'Aprobado'),
(17, 'Ricardo', 'Torres', 'T99887766', '1987-01-30', 'Calle G 159', '555777888', 'LS007', 'Supervisión de seguridad', 'Certificado en manejo de conflictos', 9, 'Supervisor', 'Turnos rotativos', 7, 'Pendiente'),
(18, 'Patricia', 'Fernández', 'O11224466', '1991-08-08', 'Av. H 753', '555888999', 'LS008', 'Escolta VIP', 'Certificado en conducción evasiva', 4, 'Escolta', 'Diurno', 8, 'Aprobado'),
(19, 'Diego', 'Rojas', 'I22335577', '1993-11-02', 'Calle I 951', '555999000', 'LS009', 'Control de accesos', 'Certificado en tecnología de seguridad', 5, 'Vigilante', 'Nocturno', 9, 'Aprobado'),
(20, 'Natalia', 'Castillo', 'U33446688', '1996-05-17', 'Av. J 852', '555000111', 'LS010', 'Vigilante profesional', 'Certificado en seguridad perimetral', 2, 'Vigilante', 'Turnos rotativos', 10, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_turnos`
--

CREATE TABLE `personal_turnos` (
  `empleado_id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal_turnos`
--

INSERT INTO `personal_turnos` (`empleado_id`, `turno_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 4),
(3, 3),
(3, 5),
(4, 4),
(5, 5),
(6, 6),
(6, 8),
(7, 7),
(7, 9),
(8, 8),
(9, 9),
(10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rondas_vigilancia`
--

CREATE TABLE `rondas_vigilancia` (
  `ronda_id` int(11) NOT NULL,
  `instalacion_id` int(11) NOT NULL,
  `personal_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rondas_vigilancia`
--

INSERT INTO `rondas_vigilancia` (`ronda_id`, `instalacion_id`, `personal_id`, `fecha`, `hora`, `observaciones`) VALUES
(1, 1, 3, '2025-03-01', '08:00:00', 'Todo en orden, sin novedades.'),
(2, 2, 5, '2025-03-02', '12:30:00', 'Se detectó una cerradura forzada, se reportó.'),
(3, 3, 7, '2025-03-03', '15:45:00', 'Patrullaje realizado sin incidentes.'),
(4, 4, 2, '2025-03-04', '10:15:00', 'Se encontraron puertas mal cerradas, se aseguraron.'),
(5, 5, 4, '2025-03-05', '22:00:00', 'Actividad sospechosa en zona de carga, se reforzó seguridad.'),
(6, 6, 6, '2025-03-06', '07:30:00', 'Verificación de cámaras de seguridad, sin anomalías.'),
(7, 7, 1, '2025-03-07', '19:00:00', 'Luces exteriores apagadas, se reportó al mantenimiento.'),
(8, 8, 8, '2025-03-08', '23:15:00', 'Vehículo no identificado en estacionamiento, se verificó.'),
(9, 9, 9, '2025-03-09', '16:20:00', 'Revisión de extintores, todos en condiciones óptimas.'),
(10, 10, 10, '2025-03-10', '05:45:00', 'Sistema de alarmas activado por error, se reconfiguró.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos_vigilancia`
--

CREATE TABLE `turnos_vigilancia` (
  `turno_id` int(11) NOT NULL,
  `instalacion_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `puestos_cubrir` varchar(255) DEFAULT NULL,
  `supervisor` int(11) DEFAULT NULL,
  `equipamiento_requerido` varchar(255) DEFAULT NULL,
  `consignas` text DEFAULT NULL,
  `relevos` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turnos_vigilancia`
--

INSERT INTO `turnos_vigilancia` (`turno_id`, `instalacion_id`, `fecha`, `hora_inicio`, `hora_fin`, `puestos_cubrir`, `supervisor`, `equipamiento_requerido`, `consignas`, `relevos`) VALUES
(1, 1, '2025-03-25', '08:00:00', '16:00:00', 'Entrada principal, Recepción', 2, 'Radio, Linterna', 'Revisar credenciales de acceso', 'Cambio a las 16:00 con turno nocturno'),
(2, 2, '2025-03-25', '16:00:00', '00:00:00', 'Perímetro externo', 5, 'Cámara portátil, Chaleco reflectante', 'Patrullaje cada 30 min', 'Relevo con turno diurno a las 08:00'),
(3, 3, '2025-03-25', '00:00:00', '08:00:00', 'Zona de carga', 7, 'Detector de metales', 'Verificar vehículos y carga', 'Cambio de guardia con turno matutino'),
(4, 4, '2025-03-26', '08:00:00', '16:00:00', 'Zona de oficinas', 2, 'Radio', 'Permitir solo personal autorizado', 'Entrega de informe al supervisor'),
(5, 5, '2025-03-26', '16:00:00', '00:00:00', 'Acceso a estacionamiento', 6, 'Linterna, Bastón de seguridad', 'Inspeccionar vehículos sospechosos', 'Relevo con turno nocturno'),
(6, 6, '2025-03-26', '00:00:00', '08:00:00', 'Pasillos internos', 3, 'Cámara portátil', 'Reportar actividad sospechosa', 'Cambio con turno matutino'),
(7, 7, '2025-03-27', '08:00:00', '16:00:00', 'Zona VIP', 8, 'Detector de metales', 'Vigilancia estricta', 'Relevo con turno vespertino'),
(8, 8, '2025-03-27', '16:00:00', '00:00:00', 'Puerta de empleados', 5, 'Lista de empleados', 'Control de ingreso', 'Entrega de informe de actividad'),
(9, 9, '2025-03-28', '00:00:00', '08:00:00', 'Patio de maniobras', 7, 'Dron de vigilancia', 'Monitoreo constante', 'Relevo a las 08:00'),
(10, 10, '2025-03-28', '08:00:00', '16:00:00', 'Recepción y áreas comunes', 6, 'Chaleco antibalas', 'Revisar visitas y proveedores', 'Informe de incidencias a supervisor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos_empresa`
--

CREATE TABLE `vehiculos_empresa` (
  `vehiculo_id` int(11) NOT NULL,
  `numero_flota` varchar(20) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `anio` int(11) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `caracteristicas` text DEFAULT NULL,
  `equipamiento_especial` text DEFAULT NULL,
  `conductor_habitual` int(11) DEFAULT NULL,
  `zona_asignada` int(11) DEFAULT NULL,
  `kilometraje` int(11) DEFAULT 0,
  `consumo_promedio` decimal(5,2) DEFAULT NULL,
  `ultimo_mantenimiento` date DEFAULT NULL,
  `estado` enum('Activo','En mantenimiento','Dado de baja') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos_empresa`
--

INSERT INTO `vehiculos_empresa` (`vehiculo_id`, `numero_flota`, `tipo`, `marca`, `modelo`, `anio`, `matricula`, `caracteristicas`, `equipamiento_especial`, `conductor_habitual`, `zona_asignada`, `kilometraje`, `consumo_promedio`, `ultimo_mantenimiento`, `estado`) VALUES
(1, 'FL-001', 'Camioneta', 'Toyota', 'Hilux', 2020, 'ABC123', '4x4, blindada', 'GPS, Radio', 1, 1, 50000, 12.50, '2024-02-15', 'Activo'),
(2, 'FL-002', 'Motocicleta', 'Honda', 'CB500X', 2022, 'DEF456', 'Alta movilidad', 'Luces LED', 2, 2, 12000, 3.80, '2024-03-10', 'Activo'),
(3, 'FL-003', 'Sedán', 'Ford', 'Focus', 2019, 'GHI789', 'Económico', 'Cámara de reversa', 3, NULL, 70000, 8.20, '2024-01-20', 'En mantenimiento'),
(4, 'FL-004', 'Camioneta', 'Chevrolet', 'Silverado', 2021, 'JKL012', 'Carga pesada', 'Blindaje nivel 3', 4, 4, 25000, 10.50, '2024-02-28', 'Activo'),
(5, 'FL-005', 'Motocicleta', 'Yamaha', 'XTZ250', 2023, 'MNO345', 'Off-road', 'Escape modificado', 5, 5, 8000, 4.20, '2024-03-05', 'Activo'),
(6, 'FL-006', 'SUV', 'Jeep', 'Cherokee', 2018, 'PQR678', 'Todo terreno', 'Sirena, luces LED', 6, 6, 90000, 11.00, '2024-01-10', 'Dado de baja'),
(7, 'FL-007', 'Pickup', 'Nissan', 'Frontier', 2020, 'STU901', 'Doble cabina', 'Radio UHF', 7, 7, 45000, 9.70, '2024-02-05', 'Activo'),
(8, 'FL-008', 'Sedán', 'Hyundai', 'Elantra', 2022, 'VWX234', 'Eficiencia de combustible','GPS', 8, 8, 15000, 7.50, '2024-03-12', 'Activo'),
(9, 'FL-009', 'Camioneta', 'Dodge', 'Durango', 2021, 'YZA567', 'Blindada nivel 2', 'Cámaras 360°', 9, 9, 30000, 9.80, '2024-02-18', 'Activo'),
(10, 'FL-010', 'Motocicleta', 'Kawasaki', 'Versys 650', 2020, 'BCD890', 'Uso urbano y carretera', 'Alforjas laterales', 10, NULL, 25000, 4.00, '2024-03-01', 'En mantenimiento');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`),
  ADD UNIQUE KEY `documento_fiscal` (`documento_fiscal`),
  ADD KEY `idx_cliente_tipo` (`tipo`);

--
-- Indices de la tabla `comunicaciones_emergencia`
--
ALTER TABLE `comunicaciones_emergencia`
  ADD PRIMARY KEY (`comunicacion_id`),
  ADD KEY `instalacion_id` (`instalacion_id`),
  ADD KEY `operador_id` (`operador_id`);

--
-- Indices de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD PRIMARY KEY (`dispositivo_id`),
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD KEY `instalacion_id` (`instalacion_id`),
  ADD KEY `idx_dispositivo_tipo` (`tipo`);

--
-- Indices de la tabla `incidentes_seguridad`
--
ALTER TABLE `incidentes_seguridad`
  ADD PRIMARY KEY (`incidente_id`),
  ADD KEY `instalacion_id` (`instalacion_id`),
  ADD KEY `idx_incidente_tipo_fecha` (`tipo`,`fecha_hora`);

--
-- Indices de la tabla `informes_incidentes`
--
ALTER TABLE `informes_incidentes`
  ADD PRIMARY KEY (`informe_id`,`incidente_id`),
  ADD KEY `incidente_id` (`incidente_id`);

--
-- Indices de la tabla `informes_servicio`
--
ALTER TABLE `informes_servicio`
  ADD PRIMARY KEY (`informe_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `instalaciones`
--
ALTER TABLE `instalaciones`
  ADD PRIMARY KEY (`instalacion_id`),
  ADD KEY `idx_instalacion_cliente` (`cliente_id`);

--
-- Indices de la tabla `personal_seguridad`
--
ALTER TABLE `personal_seguridad`
  ADD PRIMARY KEY (`empleado_id`),
  ADD UNIQUE KEY `documento_identidad` (`documento_identidad`),
  ADD KEY `instalacion_asignada` (`instalacion_asignada`),
  ADD KEY `idx_empleado_especializacion` (`especializacion`);

--
-- Indices de la tabla `personal_turnos`
--
ALTER TABLE `personal_turnos`
  ADD PRIMARY KEY (`empleado_id`,`turno_id`),
  ADD KEY `turno_id` (`turno_id`);

--
-- Indices de la tabla `rondas_vigilancia`
--
ALTER TABLE `rondas_vigilancia`
  ADD PRIMARY KEY (`ronda_id`),
  ADD KEY `instalacion_id` (`instalacion_id`),
  ADD KEY `personal_id` (`personal_id`);

--
-- Indices de la tabla `turnos_vigilancia`
--
ALTER TABLE `turnos_vigilancia`
  ADD PRIMARY KEY (`turno_id`),
  ADD KEY `instalacion_id` (`instalacion_id`),
  ADD KEY `supervisor` (`supervisor`);

--
-- Indices de la tabla `vehiculos_empresa`
--
ALTER TABLE `vehiculos_empresa`
  ADD PRIMARY KEY (`vehiculo_id`),
  ADD UNIQUE KEY `numero_flota` (`numero_flota`),
  ADD UNIQUE KEY `matricula` (`matricula`),
  ADD KEY `conductor_habitual` (`conductor_habitual`),
  ADD KEY `zona_asignada` (`zona_asignada`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `comunicaciones_emergencia`
--
ALTER TABLE `comunicaciones_emergencia`
  MODIFY `comunicacion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  MODIFY `dispositivo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `incidentes_seguridad`
--
ALTER TABLE `incidentes_seguridad`
  MODIFY `incidente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `informes_servicio`
--
ALTER TABLE `informes_servicio`
  MODIFY `informe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `instalaciones`
--
ALTER TABLE `instalaciones`
  MODIFY `instalacion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_seguridad`
--
ALTER TABLE `personal_seguridad`
  MODIFY `empleado_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `rondas_vigilancia`
--
ALTER TABLE `rondas_vigilancia`
  MODIFY `ronda_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `turnos_vigilancia`
--
ALTER TABLE `turnos_vigilancia`
  MODIFY `turno_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `vehiculos_empresa`
--
ALTER TABLE `vehiculos_empresa`
  MODIFY `vehiculo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comunicaciones_emergencia`
--
ALTER TABLE `comunicaciones_emergencia`
  ADD CONSTRAINT `comunicaciones_emergencia_ibfk_1` FOREIGN KEY (`instalacion_id`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comunicaciones_emergencia_ibfk_2` FOREIGN KEY (`operador_id`) REFERENCES `personal_seguridad` (`empleado_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD CONSTRAINT `dispositivos_ibfk_1` FOREIGN KEY (`instalacion_id`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `incidentes_seguridad`
--
ALTER TABLE `incidentes_seguridad`
  ADD CONSTRAINT `incidentes_seguridad_ibfk_1` FOREIGN KEY (`instalacion_id`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `informes_incidentes`
--
ALTER TABLE `informes_incidentes`
  ADD CONSTRAINT `informes_incidentes_ibfk_1` FOREIGN KEY (`informe_id`) REFERENCES `informes_servicio` (`informe_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `informes_incidentes_ibfk_2` FOREIGN KEY (`incidente_id`) REFERENCES `incidentes_seguridad` (`incidente_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `informes_servicio`
--
ALTER TABLE `informes_servicio`
  ADD CONSTRAINT `informes_servicio_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `instalaciones`
--
ALTER TABLE `instalaciones`
  ADD CONSTRAINT `instalaciones_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `personal_seguridad`
--
ALTER TABLE `personal_seguridad`
  ADD CONSTRAINT `personal_seguridad_ibfk_1` FOREIGN KEY (`instalacion_asignada`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `personal_turnos`
--
ALTER TABLE `personal_turnos`
  ADD CONSTRAINT `personal_turnos_ibfk_1` FOREIGN KEY (`empleado_id`) REFERENCES `personal_seguridad` (`empleado_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `personal_turnos_ibfk_2` FOREIGN KEY (`turno_id`) REFERENCES `turnos_vigilancia` (`turno_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `rondas_vigilancia`
--
ALTER TABLE `rondas_vigilancia`
  ADD CONSTRAINT `rondas_vigilancia_ibfk_1` FOREIGN KEY (`instalacion_id`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rondas_vigilancia_ibfk_2` FOREIGN KEY (`personal_id`) REFERENCES `personal_seguridad` (`empleado_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `turnos_vigilancia`
--
ALTER TABLE `turnos_vigilancia`
  ADD CONSTRAINT `turnos_vigilancia_ibfk_1` FOREIGN KEY (`instalacion_id`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turnos_vigilancia_ibfk_2` FOREIGN KEY (`supervisor`) REFERENCES `personal_seguridad` (`empleado_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `vehiculos_empresa`
--
ALTER TABLE `vehiculos_empresa`
  ADD CONSTRAINT `vehiculos_empresa_ibfk_1` FOREIGN KEY (`conductor_habitual`) REFERENCES `personal_seguridad` (`empleado_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vehiculos_empresa_ibfk_2` FOREIGN KEY (`zona_asignada`) REFERENCES `instalaciones` (`instalacion_id`) ON DELETE SET NULL;
COMMIT;

--PROCEDIMIENTOS REQUERIDOS 

--PROCEDIMIENTOS ALMACENADOS
DELIMITER $$

-- 1. Registrar una nueva instalación con sus características de seguridad
CREATE PROCEDURE RegistrarInstalacionProtegida(
    IN cliente_id INT,
    IN tipo VARCHAR(50),
    IN direccion TEXT,
    IN coordenadas VARCHAR(100),
    IN superficie DECIMAL(10,2),
    IN perimetro DECIMAL(10,2),
    IN nivel_seguridad ENUM('Bajo','Medio','Alto','Máximo')
)
BEGIN
    INSERT INTO instalaciones (cliente_id, tipo, direccion, coordenadas, superficie, perimetro, nivel_seguridad)
    VALUES (cliente_id, tipo, direccion, coordenadas, superficie, perimetro, nivel_seguridad);
END $$

-- 2. Asignar personal de seguridad a turnos de vigilancia
CREATE PROCEDURE AsignarTurnoVigilancia(
    IN empleado_id INT,
    IN turno_id INT
)
BEGIN
    INSERT INTO personal_turnos (empleado_id, turno_id)
    VALUES (empleado_id, turno_id);
END $$

-- 3. Configurar dispositivos de seguridad en una instalación
CREATE PROCEDURE ConfigurarDispositivosSeguridad(
    IN instalacion_id INT,
    IN numero_serie VARCHAR(50),
    IN tipo ENUM('Cámara','Sensor','Alarma','Control Acceso'),
    IN marca VARCHAR(50),
    IN modelo VARCHAR(50),
    IN ubicacion VARCHAR(255),
    IN estado_operativo ENUM('Operativo','En reparación','Fuera de servicio')
)
BEGIN
    INSERT INTO dispositivos (instalacion_id, numero_serie, tipo, marca, modelo, ubicacion, estado_operativo)
    VALUES (instalacion_id, numero_serie, tipo, marca, modelo, ubicacion, estado_operativo);
END $$

-- 4. Registrar un incidente de seguridad con su respuesta
CREATE PROCEDURE RegistrarIncidenteSeguridad(
    IN instalacion_id INT,
    IN fecha_hora DATETIME,
    IN zona VARCHAR(255),
    IN tipo ENUM('Intrusión','Robo','Incendio','Agresión'),
    IN descripcion TEXT,
    IN personal_involucrado TEXT,
    IN respuesta_implementada TEXT,
    IN tiempo_reaccion INT
)
BEGIN
    INSERT INTO incidentes_seguridad (instalacion_id, fecha_hora, zona, tipo, descripcion, personal_involucrado, respuesta_implementada, tiempo_reaccion)
    VALUES (instalacion_id, fecha_hora, zona, tipo, descripcion, personal_involucrado, respuesta_implementada, tiempo_reaccion);
END $$

-- 5. Programar rondas de vigilancia para una instalación
CREATE PROCEDURE ProgramarRondasVigilancia(
    IN instalacion_id INT,
    IN personal_id INT,
    IN fecha DATE,
    IN hora TIME,
    IN observaciones TEXT
)
BEGIN
    INSERT INTO rondas_vigilancia (instalacion_id, personal_id, fecha, hora, observaciones)
    VALUES (instalacion_id, personal_id, fecha, hora, observaciones);
END $$

DELIMITER ;



--TRIGGERS
DELIMITER $$

-- 1. Verifica que el personal asignado tenga licencias vigentes antes de confirmar el turno
CREATE TRIGGER TR_VerificarLicenciaPersonal
BEFORE INSERT ON personal_turnos
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM personal_seguridad WHERE empleado_id = NEW.empleado_id AND licencia_seguridad IS NOT NULL) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El personal no tiene licencia vigente';
    END IF;
END $$

-- 2. Actualiza estadísticas de incidentes por tipo y zona tras cada nuevo registro
CREATE TRIGGER TR_ActualizarEstadisticasIncidentes
AFTER INSERT ON incidentes_seguridad
FOR EACH ROW
BEGIN
    UPDATE informes_incidentes
    SET informe_id = informe_id + 1
    WHERE incidente_id = NEW.incidente_id;
END $$

-- 3. Registra necesidades de mantenimiento para dispositivos tras un incidente reportado
CREATE TRIGGER TR_RegistrarMantenimientoDispositivo
AFTER INSERT ON incidentes_seguridad
FOR EACH ROW
BEGIN
    UPDATE dispositivos
    SET estado_operativo = 'En reparación'
    WHERE dispositivo_id IN (SELECT dispositivo_id FROM dispositivos WHERE instalacion_id = NEW.instalacion_id);
END $$

-- 4. Actualiza el nivel de riesgo asignado a un cliente tras incidentes
CREATE TRIGGER TR_ActualizarNivelRiesgoCliente
AFTER INSERT ON incidentes_seguridad
FOR EACH ROW
BEGIN
    UPDATE clientes
    SET nivel_riesgo = 
        CASE 
            WHEN nivel_riesgo = 'Bajo' THEN 'Medio'
            WHEN nivel_riesgo = 'Medio' THEN 'Alto'
            WHEN nivel_riesgo = 'Alto' THEN 'Alto'
        END
    WHERE cliente_id = (SELECT cliente_id FROM instalaciones WHERE instalacion_id = NEW.instalacion_id);
END $$

-- 5. Verifica el cumplimiento de rondas programadas y genera una alerta si hay retrasos
CREATE TRIGGER TR_ControlarCumplimientoRondas
AFTER INSERT ON rondas_vigilancia
FOR EACH ROW
BEGIN
    IF (NEW.hora < TIME(NOW())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '¡Ronda de vigilancia no cumplida a tiempo!';
    END IF;
END $$

DELIMITER ;


--EVENTOS
DELIMITER $$

-- 1. Verifica automáticamente las necesidades de mantenimiento de dispositivos cada día
CREATE EVENT EVT_VerificarMantenimientoDispositivos
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE dispositivos
    SET estado_operativo = 'En reparación'
    WHERE ultimo_mantenimiento < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END $$

-- 2. Genera reportes periódicos de incidentes cada semana
CREATE EVENT EVT_GenerarReporteIncidentes
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    INSERT INTO informes_incidentes (informe_id, incidente_id)
    SELECT NULL, incidente_id FROM incidentes_seguridad
    WHERE fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK);
END $$

-- 3. Controla vencimiento de licencias del personal y genera alertas
CREATE EVENT EVT_ControlarVencimientoLicencias
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    UPDATE personal_seguridad
    SET licencia_seguridad = NULL
    WHERE empleado_id IN (
        SELECT empleado_id FROM personal_seguridad WHERE licencia_seguridad IS NOT NULL
        AND licencia_seguridad < CURDATE()
    );
END $$

-- 4. Optimiza rutas de vigilancia según históricos de incidentes
CREATE EVENT EVT_OptimizarRutasVigilancia
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    UPDATE rondas_vigilancia
    SET observaciones = 'Ruta optimizada según incidentes recientes'
    WHERE instalacion_id IN (
        SELECT instalacion_id FROM incidentes_seguridad WHERE fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    );
END $$

-- 5. Analiza puntos vulnerables en instalaciones según incidentes registrados
CREATE EVENT EVT_AnalizarPuntosVulnerables
ON SCHEDULE EVERY 3 MONTH
DO
BEGIN
    UPDATE instalaciones
    SET zonas_criticas = CONCAT(zonas_criticas, ' | Revisión por vulnerabilidad requerida')
    WHERE instalacion_id IN (
        SELECT instalacion_id FROM incidentes_seguridad GROUP BY instalacion_id HAVING COUNT(*) > 5
    );
END $$

DELIMITER ;


--FUNCIONES
DELIMITER $$

-- 1. Calcula el nivel de riesgo de una instalación según incidentes registrados
CREATE FUNCTION FN_CalcularNivelRiesgoInstalacion(instalacion_id INT) RETURNS ENUM('Bajo', 'Medio', 'Alto')
DETERMINISTIC
BEGIN
    DECLARE nivel_riesgo ENUM('Bajo', 'Medio', 'Alto');
    DECLARE total_incidentes INT;

    SELECT COUNT(*) INTO total_incidentes
    FROM incidentes_seguridad
    WHERE instalacion_id = instalacion_id;

    IF total_incidentes < 3 THEN
        SET nivel_riesgo = 'Bajo';
    ELSEIF total_incidentes BETWEEN 3 AND 6 THEN
        SET nivel_riesgo = 'Medio';
    ELSE
        SET nivel_riesgo = 'Alto';
    END IF;

    RETURN nivel_riesgo;
END $$

-- 2. Sugiere el personal óptimo según el tipo de instalación
CREATE FUNCTION FN_ObtenerPersonalOptimo(instalacion_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE personal_id INT;
    
    SELECT empleado_id INTO personal_id
    FROM personal_seguridad
    WHERE especializacion = (SELECT tipo FROM instalaciones WHERE instalacion_id = instalacion_id)
    ORDER BY experiencia DESC
    LIMIT 1;

    RETURN personal_id;
END $$

-- 3. Estima el tiempo de respuesta a un incidente según ubicación
CREATE FUNCTION FN_EstimarTiempoRespuesta(instalacion_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE tiempo_respuesta INT;

    SELECT AVG(tiempo_reaccion) INTO tiempo_respuesta
    FROM incidentes_seguridad
    WHERE instalacion_id = instalacion_id;

    RETURN COALESCE(tiempo_respuesta, 0);
END $$

-- 4. Calcula la cobertura de cámaras en una instalación
CREATE FUNCTION FN_CalcularCoberturaCamaras(instalacion_id INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE cobertura DECIMAL(5,2);

    SELECT (COUNT(*) / (SELECT superficie FROM instalaciones WHERE instalacion_id = instalacion_id)) * 100 INTO cobertura
    FROM dispositivos
    WHERE instalacion_id = instalacion_id AND tipo = 'Cámara';

    RETURN cobertura;
END $$

-- 5. Verifica el cumplimiento de protocolos de seguridad
CREATE FUNCTION FN_VerificarCumplimientoProtocolo(instalacion_id INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE cumplimiento BOOLEAN;

    IF (SELECT COUNT(*) FROM incidentes_seguridad WHERE instalacion_id = instalacion_id AND tipo = 'Intrusión') = 0 THEN
        SET cumplimiento = TRUE;
    ELSE
        SET cumplimiento = FALSE;
    END IF;

    RETURN cumplimiento;
END $$

DELIMITER ;
