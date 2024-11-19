
DELIMITER $$
CREATE PROCEDURE sp_resumen_por_ciudad (IN p_ciudad VARCHAR(25))
BEGIN
    DECLARE total_pedidos INT;
    DECLARE total_facturado DECIMAL;
    DECLARE total_clientes INT;

    SELECT COUNT(DISTINCT o.orden_id) INTO total_pedidos
    FROM ordenes o
    INNER JOIN clientes c ON o.cliente_id = c.cliente_id
    WHERE c.ciudad = p_ciudad;

    SELECT SUM(f.total) INTO total_facturado
    FROM facturas f
    INNER JOIN ordenes o ON f.orden_id = o.orden_id
    INNER JOIN clientes c ON o.cliente_id = c.cliente_id
    WHERE c.ciudad = p_ciudad;

    SELECT COUNT(DISTINCT cliente_id) INTO total_clientes
    FROM clientes 
    WHERE ciudad = p_ciudad;

    SELECT 
        total_pedidos AS 'Total de Pedidos',
        total_facturado AS 'Total Facturado',
        total_clientes AS 'Total de Clientes';
END$$

CALL sp_resumen_por_ciudad('Los Angeles');

----------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE sp_actualizar_costo_producto (IN p_producto_id VARCHAR(20), IN p_nuevo_costo DECIMAL)
BEGIN
    UPDATE productos
    SET precio_de_costo = p_nuevo_costo
    WHERE producto_id = p_producto_id;

    SELECT CONCAT('El costo del producto ', p_producto_id, ' ha sido actualizado a ', p_nuevo_costo) AS mensaje;
END$$

DELIMITER ;

CALL sp_actualizar_costo_producto('OFF-LA-10000121', 261);

----------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
 
CREATE PROCEDURE sp_registros_mas_altos (IN tabla VARCHAR(15), IN campo VARCHAR(20), IN p_desc VARCHAR(4))
BEGIN
	SET @resultado = CONCAT('SELECT * FROM ', tabla, ' ORDER BY ', campo, ' ', p_desc, ' LIMIT 5');
	PREPARE consulta FROM @resultado;
	EXECUTE consulta;
	DEALLOCATE PREPARE consulta; 

END$$

DELIMITER ;

CALL sp_registros_mas_altos('productos', 'precio_de_costo', 'DESC');
