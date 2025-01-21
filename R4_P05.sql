--Quels sont les 5 codes postaux, enregistrant plus de 30 commandes,
--avec le pire review score moyen sur les 12 derniers mois ?	
	

WITH review AS (	
		SELECT 
			s.seller_zip_code_prefix,
			COUNT(DISTINCT oi.order_id) AS order_count,
			ROUND(AVG(ro.review_score)) AS avg_score,
			ro.review_creation_date
		FROM 
			sellers s
		LEFT JOIN
			order_items oi   ON s.seller_id = oi.seller_id
		LEFT JOIN
			order_reviews ro ON ro.order_id = oi.order_id 

			
		GROUP BY 
			s.seller_zip_code_prefix
)
	
	
SELECT * 
FROM 
	review
WHERE
	order_count > 30
	AND review_creation_date BETWEEN 
		(SELECT DATE(MAX(review_creation_date), '-12 month') FROM order_reviews)
		AND 
		(SELECT MAX(review_creation_date) FROM order_reviews)
ORDER BY 
	avg_score LIMIT 5