
--Qui sont les vendeurs ayant généré un chiffre d'affaires de plus de 100
--000 Real sur des commandes livrées via Olist ?

WITH	
	cte_revenue AS (
		SELECT
			seller_id,
			ROUND (SUM(price)) AS seller_revenue
		FROM 
			order_items
		GROUP BY 
			seller_id
)

SELECT 
	seller_id,
	seller_revenue
FROM cte_revenue
		
WHERE 
	seller_revenue > 100000
ORDER by 
	seller_Revenue DESC;
