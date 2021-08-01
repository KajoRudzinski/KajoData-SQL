/*
 * What's the table structure
 */
describe orders;

/*
 * Preview the table
 */
select * from orders limit 100;

/*
 * Truncate date to month in MySQL
 */
select
	date_format(order_date, '%Y-%m-01')
	,count(*)
from orders
group by 1;

/*
 * Customer Count & and Sales - First Class
 */
select
	date_format(order_date, '%Y-%m-01')	as order_month
	,count(distinct customer_id)		as customers
	,sum(sales)							as sales
from orders
where ship_mode = 'First Class'
group by 1;

/*
 * Customer Count & and Sales - Second Class
 */
select
	date_format(order_date, '%Y-%m-01')	as order_month
	,count(distinct customer_id)		as customers
	,sum(sales)							as sales
from orders
where ship_mode = 'Second Class'
group by 1;

/*
 * Let's build CTE (Common Table Expression)
 */
with
first_class as
	(
	select
		date_format(order_date, '%Y-%m-01')	as order_month
		,count(distinct customer_id)		as customers
		,sum(sales)							as sales
	from orders
	where ship_mode = 'First Class'
	group by 1
	),
second_class as
	(
	select
		date_format(order_date, '%Y-%m-01')	as order_month
		,count(distinct customer_id)		as customers
		,sum(sales)							as sales
	from orders
	where ship_mode = 'Second Class'
	group by 1
	),
months as
	(
	select distinct date_format(order_date, '%Y-%m-01') as order_month
	from orders
	)
select
	m.order_month	as order_month
	,fc.customers	as first_class_customers
	,sc.customers	as second_class_customers
	,fc.sales		as first_class_sales
	,sc.sales		as second_class_sales
from months m
left join first_class	fc on fc.order_month = m.order_month
left join second_class	sc on sc.order_month = m.order_month
order by 1 asc;


/*
 * CTE - reading previous select statement
 */
with
first_class as
	(
	select
		date_format(order_date, '%Y-%m-01')	as order_month
		,count(distinct customer_id)		as customers
		,sum(sales)							as sales
	from orders
	where ship_mode = 'First Class'
	group by 1
	),
fc_best_month as
	(
	select max(sales)	as best_sales
	from first_class
	),
second_class as
	(
	select
		date_format(order_date, '%Y-%m-01')	as order_month
		,count(distinct customer_id)		as customers
		,sum(sales)							as sales
	from orders
	where ship_mode = 'Second Class'
	group by 1
	),
sc_best_month as
	(
	select max(sales)	as best_sales
	from second_class
	)
select
	fc.best_sales	as fc_best_sales
	,sc.best_sales	as sc_best_sales
from fc_best_month fc
left join sc_best_month sc on 1 = 1
;
	
	
