-- product review analysis
SELECT 
    p.id AS product_id, 
    p.name AS product_name, 
    r.user_id, 
    r.rating, 
    r.comment, 
    r.created_at
FROM 
    products AS p
INNER JOIN 
    reviews AS r ON p.id = r.product_id
ORDER BY 
    p.id, r.created_at DESC;