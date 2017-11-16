#	TASK 1.A : Understanding the data in hand
#=========================================================================================================
#
#	cust_dimen table : Each record in this table represents a single entity of a customer.
#					   Each record consist of customer's name, province he/she belongs to,
#					   region he/she belongs to, segment the customer belongs to, and a 
#                      unique id to identify.
#					   This table contains information about 1832 customers.
#
#	orders_dimen : Each record in this table represents a single instance of order that a
#				   customer placed. Each record consist of unique order_id, date on which
#				   the order was plced, priority of the order, ord_id column to hold 
#				   unique pattern Ord_<number> , which will be provided to customer for reference.
#				   This table contains information about 257 orders.
#
#   prod_dimen : Each record in this table represents a single product. Each record consist 
#				 of product category, the product belongs to, product sub category, the
#                product belongs to, and a unique product id of pattern Prod_<number>.
#				 This table contains information about 17 products.
#
#   shipping_dimen : Each record in this table represents shipping details corresponding to
#					 a order. Each record consist of order id corresponding to the shipment,
#					 mode of shipping, date of shipping, a unique shipping id.
#					 This table contains information about 7701 shpments.
#
#   market_fact : This table stores information about the sales, discount, order quantity,
#				  profit, shipping cost, product base margin coresponding to a perticular 
#				  order.
#				  This table contains information about 1252 facts.
#
#
#
#   TASK 1.B : Identify and list the Primary Keys and Foreign Keys for this dataset 
#=========================================================================================================
#   
#	cust_dimen table : 
#						Primary Key : Cust_id
#						Foreign Key : NA
#
#
#	orders_dimen :
#						Primary Key : Order_ID 
#						Foreign Key : NA
#
#
#	prod_dimen :
#						Primary Key : Product_id
#						Foreign Key : NA
#
#
#	shipping_dimen :
#						Primary Key : Ship_id
#						Foreign Key : Order_ID (on Order_ID of orders_dimen)
#
#
#	market_fact :
#						Primary Key : composite primary key (Ord_id,Prod_id,Ship_id,Cust_id)
#						Foreign Key : Ord_id (on Ord_id of orders_dimen)
#									  Prod_id (on Prod_id of prod_dimention)
#									  Ship_id (on Ship_id of shipping_dimen)
#									  Cust_id (on Cust_id of cust_dimention)
#
#
#
#
#=========================================================================================================





#=========================================================================================================
#	Task 2: Basic Analysis 
#=========================================================================================================

#	A. Find the total and the average sales (display total_sales and avg_sales)

SELECT 
    SUM(Sales) AS total_sales, AVG(Sales) AS avg_sales
FROM
    market_fact;



#	B. Display the number of customers in each region in decreasing order of no_of_customers.
#   The result should contain columns Region, no_of_customers 

SELECT 
    Region, COUNT(Cust_id) AS no_of_customers
FROM
    cust_dimen
GROUP BY Region
ORDER BY no_of_customers DESC;



#	C. Find the region having maximum customers (display the region name and max(no_of_customers)

SELECT 
    Region, COUNT(Cust_id) AS no_of_customers
FROM
    cust_dimen
GROUP BY Region
ORDER BY no_of_customers DESC
LIMIT 1;



#	D. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 

SELECT 
    Prod_id, COUNT(Prod_id) AS no_of_products
FROM
    market_fact
GROUP BY Prod_id
ORDER BY no_of_products;



#	E. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased
#   (display the customer name, no_of_tables purchased)  

SELECT 
    cust.Customer_Name,
    COUNT(prod.Product_Sub_Category) AS no_of_tables
FROM
    market_fact mkt
        JOIN
    cust_dimen cust ON mkt.Cust_id = cust.Cust_id
        JOIN
    prod_dimen prod ON mkt.Prod_id = prod.Prod_id
WHERE
    LOWER(prod.Product_Sub_Category) = 'tables'
        AND LOWER(cust.Region) = 'atlantic'
GROUP BY cust.Customer_Name;










#	Task 3: Advanced Analysis
#=========================================================================================================

#	A. Display the product categories in descending order of profits 
#	   (display the product category wise profits i.e. product_category, profits)?

SELECT 
    prod.Product_Category, SUM(mkt.Profit) AS profits
FROM
    market_fact mkt
        JOIN
    prod_dimen prod ON mkt.Prod_id = prod.Prod_id
GROUP BY prod.Product_Category
ORDER BY profits DESC;



#	B. Display the product category, product sub-category and the profit within each subcategory in three columns. 

SELECT 
    prod.Product_Category,
    prod.Product_Sub_Category,
    SUM(mkt.Profit) AS profits
FROM
    market_fact mkt
        JOIN
    prod_dimen prod ON mkt.Prod_id = prod.Prod_id
GROUP BY prod.Product_Sub_Category
ORDER BY prod.Product_Category , profits DESC;



#	C. Where is the least profitable product subcategory shipped the most? 
#	   For the least profitable product sub-category, display the  region-wise no_of_shipments
#      and the profit made in each region in decreasing order of profits 
#      (i.e. region, no_of_shipments, profit_in_each_region) .
#	   Note: You can hardcode the name of the least profitable product subcategory .

SELECT 
    cust.Region,
    COUNT(*) AS no_of_shipments,
    SUM(mkt.Profit) AS profit_in_each_region
FROM
    market_fact mkt
        JOIN
    cust_dimen cust ON mkt.Cust_id = cust.Cust_id
        JOIN
    prod_dimen prod ON mkt.Prod_id = prod.Prod_id
WHERE
    prod.Product_Sub_Category = (SELECT 
            prod.Product_Sub_Category
        FROM
            market_fact mkt
                JOIN
            prod_dimen prod ON mkt.Prod_id = prod.Prod_id
        GROUP BY prod.Product_Sub_Category
        ORDER BY SUM(mkt.Profit)
        LIMIT 1)
GROUP BY cust.Region
ORDER BY profit_in_each_region desc;     
