create table zeptoo(
Sku_id serial primary key,
Category varchar(120),name varchar(150) not null,mrp numeric(8,2),
discountpercent numeric(5,2),availableQuantity integer,discountSellingPrice numeric(8,2), 
weightInGms integer,outOfStock boolean,quantity integer
);
select * from zeptoo ;

--Data exploration
-- count of rows
select count(*) from zeptoo;
--sample data
select * from zeptoo
LIMIT 10;
-- null values
select * from zeptoo
where name is null 
or
category is null 
or
mrp is null 
or
discountpercent is null 
or
availablequantity is null 
or
discountsellingprice is null 
or
weightingms is null 
or
outofstock is null 
or
quantity is null 

--different product categories
select distinct category from zeptoo
order by category;

-- check for out of stock
select outofstock,count(sku_id)
from zeptoo
group by outofstock;

--product names present more than 1
select name, count(sku_id)as total
from zeptoo
group by name
having count(sku_id)>1
order by count(sku_id) desc;

--data cleaning
--products with price =0
select * from zeptoo
where mrp=0 or discountSellingPrice = 0;
delete from zeptoo
where mrp=0;
--convert paise to rupees
update zeptoo
set mrp=mrp*100.0, discountSellingPrice=discountSellingPrice*100

 --Analysis
--top 10 best values
select distinct name,mrp,discountpercent from zeptoo
order by discountpercent desc limit 10 ;

--the products with high MRP but out of stock

select name,outofstock,mrp from zeptoo
where outofstock='true'
order by mrp desc
limit 20;

--estimated revenue for each catergory

SELECT * from zeptoo
SELECT category, 
SUM(discountsellingprice * availablequantity)AS revenue 
FROM zeptoo
GROUP BY category
ORDER BY revenue;

--products where mrp is greater than Rs.500 and 
--discount is less than 10%

SELECT name, mrp, discountpercent FROM zeptoo
WHERE mrp>500 AND discountpercent < 10 
ORDER by mrp desc, discountpercent desc;

--price per gram for 
--products above 100g and sort by best value.
SELECT name,
SUM(discountsellingprice * availablequantity)AS revenue 
FROM zeptoo
WHERE weightingms >100
ORDER BY revenue DESC
LIMIT 10;

--top 5 categories 
--offering the highest average discount percentage
SELECT * from zeptoo;
SELECT category,
ROUND(AVG(discountpercent),2) AS Avg_discount 
FROM zeptoo
GROUP BY category
ORDER BY Avg_discount DESC
LIMIT 5;
--price per gram for
--products above 100g and sort by best value
SELECT DISTINCT name,weightingms,discountsellingprice,
ROUND(discountsellingprice/weightingms,2) AS price_per_gms
FROM zeptoo
WHERE weightingms>=100 
order by price_per_gms;

--Group the products into categories like 
--low,medium,bulk.
SELECT DISTINCT name,weightingms,
CASE WHEN weightingms < 1000 THEN 'LOW'
     WHEN weightingms < 5000  THEN 'MEDIUM'
	 ELSE 'Bulk'
	 END AS weight_category
FROM zeptoo;
--the inventory weight per category
SELECT category,
SUM(weightingms * availablequantity)As total_weight
FROM zeptoo
GROUP BY category
ORDER BY total_weight;



























