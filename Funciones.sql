DELIMITER //
CREATE FUNCTION f_porcentaje_reintegro_cliente(cliente_id VARCHAR(20)) 
RETURNS DECIMAL
DETERMINISTIC
BEGIN
    DECLARE total_pedidos INT;
    DECLARE pedidos_reintegrados INT;
    DECLARE porcentaje DECIMAL;
    
    SELECT COUNT(*) INTO total_pedidos
    FROM ordenes o
    WHERE o.cliente_id = cliente_id;
    
    SELECT COUNT(*) INTO pedidos_reintegrados
    FROM post_venta pv
    INNER JOIN ordenes o ON pv.orden_id = o.orden_id
    WHERE o.cliente_id = cliente_id AND pv.reintegro_costo_envio = TRUE;
    
    SET porcentaje = (pedidos_reintegrados / total_pedidos) * 100;
    RETURN porcentaje;
END//

----------------------------------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION f_costo_total_productos_vendidos_por_fecha (inicio DATE, fin DATE)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
    DECLARE costo_total DECIMAL;
    
    SELECT SUM(p.precio_de_costo * o.cantidad_producto) 
    INTO costo_total
    FROM ordenes o
    INNER JOIN productos p ON o.producto_id = p.producto_id
    WHERE o.fecha_orden BETWEEN inicio AND fin; 
    
    RETURN costo_total;
END//

