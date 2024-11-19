CREATE VIEW v_totales_metodo_pago AS 
SELECT o.metodo_pago, sum(f.total)
FROM ordenes o 
INNER JOIN facturas f ON o.orden_id = f.orden_id
GROUP BY o.metodo_pago;

CREATE VIEW v_productos_mas_vendidos AS
SELECT p.nombre as producto, sum(o.cantidad_producto) as cantidad
FROM productos p
INNER JOIN ordenes o ON p.producto_id = o.producto_id
GROUP BY p.nombre
LIMIT 10;
 
CREATE VIEW	 v_clientes_gold AS 
SELECT c.nombre as cliente, c.mail as contacto, sum(f.total) as total_abonado
FROM clientes c 
INNER JOIN ordenes o ON c.cliente_id = o.cliente_id
INNER JOIN facturas f ON o.orden_id = f.orden_id
GROUP BY c.nombre, c.mail
ORDER BY total_abonado DESC
LIMIT 5;  

CREATE VIEW	 v_perdida_costos_envío AS 
SELECT sum(f.costo_de_envio) as total, pv.reintegro_costo_envio as reintegrado
FROM facturas f 
INNER JOIN post_venta pv ON f.orden_id = pv.orden_id
GROUP BY pv.reintegro_costo_envio;

DROP VIEW IF EXISTS v_ganancias_por_producto;
CREATE VIEW v_ganancias_por_producto AS
SELECT p.nombre AS producto, 
	sum(f.subtotal) AS total_ventas, 
	sum(p.precio_de_costo * o.cantidad_producto) AS total_costos, 
	sum(f.subtotal) - sum(p.precio_de_costo * o.cantidad_producto) AS ganancia_total
FROM productos p
INNER JOIN ordenes o ON p.producto_id = o.producto_id
INNER JOIN facturas f ON o.orden_id = f.orden_id
GROUP BY p.nombre
ORDER BY ganancia_total DESC; 

SELECT * FROM v_perdida_costos_envío;
SELECT * FROM v_clientes_gold;
SELECT * FROM v_productos_mas_vendidos;
SELECT * FROM v_totales_metodo_pago;
SELECT * FROM v_ganancias_por_producto;

