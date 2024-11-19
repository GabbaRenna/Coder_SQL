CREATE TABLE auditoria_pagos (
orden_id VARCHAR(20),
total_factura DECIMAL);

DELIMITER // 

CREATE TRIGGER tr_alerta_pago
AFTER INSERT ON facturas FOR EACH ROW

BEGIN 
	IF NEW.total >= 1000 THEN
		INSERT INTO auditoria_pagos (orden_id, total_factura) VALUES (NEW.orden_id, NEW.total);
	END IF;
END // 

DELIMITER ;

-- Caso de prueba

INSERT INTO ordenes VALUES ('US-2020-169552', 'BF-10975', 'TEC-AC-10003832', 8, '2020-12-31', 'Crédito', 'Estandar');
INSERT INTO facturas VALUES ('US-2020-169552', 232, 1856, 4, 1860);

SELECT * from auditoria_pagos;

--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE inventario ( 
producto_id VARCHAR(20),
stock_actual INT);

INSERT INTO inventario VALUES 
('FUR-BO-10004709',	83),
('TEC-PH-10000455',	15),
('OFF-ST-10003692',	137);

DELIMITER //

CREATE TRIGGER tr_descuento_stock
AFTER INSERT ON ordenes FOR EACH ROW
BEGIN
    UPDATE inventario
    SET stock_actual = stock_actual - NEW.cantidad_producto
    WHERE producto_id = NEW.producto_id;
END;
//

DELIMITER ;

