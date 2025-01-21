
--Qui sont les nouveaux vendeurs (moins de 3 mois d'ancienneté) qui
--sont déjà très engagés avec la plateforme (ayant déjà vendu plus de 30
--produits) ?


SELECT * 
FROM (
	SELECT 
		seller_id,
		COUNT(product_id) AS item_count,
		MIN(order_purchase_timestamp) AS min_date_order
		
	FROM
		order_items oi

	JOIN orders o
		ON o.order_id = oi.order_id
		
	GROUP BY 
		seller_id
	ORDER BY 
		item_count desc
)

WHERE 
	min_date_order < (SELECT DATE(MAX(order_purchase_timestamp),'-3 month') FROM orders)
	AND (item_count >30);