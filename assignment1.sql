-- FINAL QUERY
CREATE OR REPLACE TABLE products AS
       WITH products_json AS (
       SELECT *
       FROM read_json_auto('/Users/masha/Downloads/flipkart_fashion_products_dataset.json')
       )
       SELECT
           json_extract_string(products_json, '$._id') AS id,
           cast(replace(json_extract_string(products_json, '$.actual_price'), ',', '.') AS FLOAT) AS actual_price,
           cast(json_extract_string(products_json, '$.average_rating') AS FLOAT) AS average_rating,
           json_extract_string(products_json, '$.brand') AS brand,
           json_extract_string(products_json, '$.category') AS category,
           json_extract_string(products_json, '$.crawled_at') AS crawled_at,
           json_extract_string(products_json, '$.out_of_stock') AS out_of_stock,
           json_extract_string(json_extract(products_json, '$.product_details[0]'), '$.Style Code') AS style_code,
           json_extract_string(json_extract(products_json, '$.product_details[1]'), '$.Closure') AS closure,
           json_extract_string(json_extract(products_json, '$.product_details[2]'), '$.Pockets') AS pockets,
           json_extract_string(json_extract(products_json, '$.product_details[3]'), '$.Fabric') AS fabric,
           json_extract_string(json_extract(products_json, '$.product_details[4]'), '$.Pattern') AS pattern,
           json_extract_string(json_extract(products_json, '$.product_details[5]'), '$.Color') AS color,
           json_extract_string(products_json, '$.seller') AS seller,
           cast(replace(json_extract_string(products_json, '$.selling_price'), ',', '.') AS FLOAT) AS selling_price,
           json_extract_string(products_json, '$.sub_category') AS sub_category,
           json_extract_string(products_json, '$.title') AS title
       FROM products_json
       WHERE actual_price != '' AND average_rating != '' AND selling_price != '';


SELECT * FROM products;

-- Ranking by average price difference by category
WITH w_price_diff AS (
    SELECT
        (selling_price - actual_price) AS price_diff,
        category,
        sub_category,
    FROM products
),
grouped AS (
    SELECT
        category,
        sub_category,
        ROUND(AVG(price_diff), 2) as avg_price_diff
    FROM w_price_diff
    GROUP BY category, sub_category
)
SELECT
    avg_price_diff,
    category,
    sub_category,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY avg_price_diff DESC) AS price_diff_by_cat
FROM grouped;

-- Top-3 brands by category by average rating
WITH w_avg_price AS (
    SELECT
        brand,
        sub_category,
        ROUND(AVG(average_rating), 1) AS avg_rating
    FROM products
    WHERE out_of_stock = 'false' AND brand != ''
    GROUP BY brand, sub_category
)
SELECT
    brand,
    sub_category,
    avg_rating,
    DENSE_RANK() OVER (PARTITION BY sub_category ORDER BY avg_rating DESC) AS top_brend_by_cat
FROM w_avg_price
QUALIFY top_brend_by_cat <= 3;