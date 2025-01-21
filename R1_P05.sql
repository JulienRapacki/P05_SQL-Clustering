
--En excluant les commandes annulées, quelles sont les commandes
--récentes de moins de 3 mois que les clients ont reçues avec au moins 3
--jours de retard ?


WITH 
	cte_latest AS(
	SELECT  MAX(order_purchase_timestamp) AS latest_order 
	FROM orders
	),
	cte_age AS(
	SELECT * ,
		ROUND(JULIANDAY(latest_order) - JULIANDAY(order_purchase_timestamp)-1) AS order_age,
		ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date)-1) AS delay
	FROM orders,cte_latest
	)
	
	
SELECT * 
FROM   cte_age a
WHERE 
	a.order_status <> "cancelled"
	AND(a.order_age <90)
	AND(a.delay >3);
	
	

