/* How does the table look like */

select *
from orders 
limit 100;

/*
 * How does the WHERE work?
 * It's condition & filter for raw data
 */

select *
from orders 
where city = 'Houston';

/* 
 * you can use where to fitler numbers, text, dates or boolean (true-false)
 */

select * 
from orders 
where
	city = 'Houston'
and segment = 'Consumer'
and 
	(
	order_date between date('2013-06-01') and date('2013-10-01')
	or
	order_date between date('2013-12-10') and date('2013-12-30')
	);
	
/* 
 * How does the WHERE work?
 * It's used to group / categories data
 * Each category / group will receive some calculations (sum, max, etc.)
 */

select 
	city
	,sum(sales)			as total_sales
	,max(profit)		as max_profit
	,min(order_date)	as first_order
from orders 
group by city;


/* Nothing prevents from
 * using more than 1 column in your GROUP BY
 */

select 
	city
	,segment
	,avg(profit)
from orders
group by 1, 2;


/* 
 * You can use GROUP BY with WHERE together
 * Remember that WHERE runs first, and only than goes GROUP BY
 */

select 
	city
	,segment
	,avg(profit)
from orders
where ship_mode = 'First Class'
group by 1, 2;
