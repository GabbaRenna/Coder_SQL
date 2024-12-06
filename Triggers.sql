DELIMITER // 

CREATE TRIGGER tr_alerta_pago
AFTER INSERT ON facturas FOR EACH ROW

BEGIN 
	IF NEW.total >= 1000 THEN
		INSERT INTO auditoria_pagos (orden_id, total_factura) VALUES (NEW.orden_id, NEW.total);
	END IF;
END // 

DELIMITER ;

--------------------------------------------------------------------------------------------------------------------------------
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

