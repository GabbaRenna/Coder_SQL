SELECT * FROM v_perdida_costos_envío;
SELECT * FROM v_clientes_gold;
SELECT * FROM v_productos_mas_vendidos;
SELECT * FROM v_totales_metodo_pago;
SELECT * FROM v_ganancias_por_producto;

----------------------------------------------------------------------------------------------

SELECT f_porcentaje_reintegro_cliente('TP-21130') AS porcentaje_reintegro;

SELECT f_costo_total_productos_vendidos_por_fecha ("2024-06-30", "2024-12-31") AS costo_mercadería;

-----------------------------------------------------------------------------------------------

CALL sp_resumen_por_ciudad('Miami');

CALL sp_actualizar_costo_producto('TEC-PH-10004977', 115);

CALL sp_registros_mas_altos('productos', 'precio_de_costo', 'DESC');

------------------------------------------------------------------------------------------------
--- Caso de prueba para tr_alerta_pago: 

INSERT INTO ordenes VALUES ('US-2020-169552', 'KB-16585', 'TEC-PH-10004977', 8, '2024-12-31', 'Crédito', 'Estandar');
INSERT INTO facturas VALUES ('US-2020-169552', 232, 1856, 4, 1860);

SELECT * from auditoria_pagos;


--- Caso de prueba para el trigger tr_descuento_stock

SELECT stock_actual FROM inventario
WHERE producto_id = "TEC-PH-10004977";

INSERT INTO ordenes VALUES ('US-2020-169553', 'KB-16585', 'TEC-PH-10004977', 1, '2024-12-31', 'Crédito', 'Estandar');
-- Para realizar una nueva prueba se puede modificar el último número del nuemro de orden US-2020-169553 e insertar un nuevo registro a la tabla :) 
--------------------------------------------------------

SELECT * FROM v_perdida_costos_envío;

SELECT p.orden_id, o.metodo_envio
FROM post_venta p
LEFT JOIN ordenes o
ON o.orden_id = p.orden_id
WHERE p.reintegro_costo_envio = 1;
