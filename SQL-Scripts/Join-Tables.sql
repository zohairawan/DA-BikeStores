select
	  ord.order_id
	, concat(cus.first_name, ' ', cus.last_name) as full_name
	, cus.city
	, cus.state
	, ord.order_date
	, sum(ite.quantity) as total_units
	, sum(ite.quantity * ite.list_price) as revenue
	, sto.store_name
from sales.orders ord
join sales.customers cus
on ord.customer_id = cus.customer_id
join sales.order_items ite
on ord.order_id = ite.order_id
join sales.stores sto
on sto.store_id = ord.store_id
group by
	  ord.order_id
	, concat(cus.first_name, ' ', cus.last_name)
	, cus.city
	, cus.state
	, ord.order_date
	, sto.store_name