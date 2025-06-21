
CREATE TABLE IF NOT EXISTS caja (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    fecha_apertura DATETIME NOT NULL,
    fecha_cierre DATETIME NULL,
    monto_inicial DECIMAL(10,2) NOT NULL,
    monto_final DECIMAL(10,2) NULL,
    estado TINYINT(1) DEFAULT 1,
    FOREIGN KEY (usuario_id) REFERENCES usuario(idusuario)
);