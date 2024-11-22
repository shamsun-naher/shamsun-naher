
USE magist;
select  products.product_id,products.product_category_name, products.product_weight_g,order_items.order_item_id,order_items.seller_id,order_items.shipping_limit_date,order_items.price,order_items.freight_value,orders.order_status,orders.order_purchase_timestamp,orders.customer_id,
  CASE
         WHEN product_category_name like '%pcs%' or product_category_name like'%informatica_acessorios%' THEN 'tech_computer'
         -- WHEN product_category_name like '%seguros_e_servicos%' or product_category_name like '%sinalizacao_e_seguranca%' THEN 'tech_security'
         -- WHEN product_category_name like '%consoles_games%'  or product_category_name like '%pc_gamer%' THEN 'tech_games'
         -- WHEN product_category_name like '%tablets_impressao_imagem%' THEN 'tech_tablets_printing'
         WHEN product_category_name like '%telefonia_fixa%' or product_category_name like'%telefonia%' THEN 'tech_telephony'
         WHEN product_category_name like '%electronicos%' THEN 'tech_electronics'
        -- WHEN product_category_name like '%automotivo%'  THEN 'tech_auto'
        ELSE 'non_tech'
    END AS tech_products,
    
    CASE 
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 100 THEN "> 100 day Delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 7 AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 100 THEN "1 week to 100 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 3 AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 7 THEN "4-7 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 1  AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) <= 3 THEN "1-3 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 0  AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 1 THEN "less than 1 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) <= 0 THEN 'On time' 
    END AS "delay_range", 
    round((product_length_cm*product_height_cm*product_width_cm)/product_weight_g,2) as product_size
FROM
    products
    right join (select * from order_items) order_items on products.product_id = order_items.product_id
    right JOIN orders 
	USING (order_id);
    
    
    select *
    from order_items;
    select *
    from products;
    select *
    from orders;