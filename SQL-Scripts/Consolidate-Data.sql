-- Consolidate relevant data --
go
create view dbo.vResultSet as
	select
		  ord.order_id
		, concat(cus.first_name, ' ', cus.last_name) as customers
		, cus.city
		, cus.state
		, ord.order_date
		, sum(ite.quantity) as total_units
		, sum(ite.quantity * ite.list_price) as revenue
		, prod.product_name
		, cat.category_name
		, brand.brand_name
		, sto.store_name
		, concat(sta.first_name, ' ', sta.last_name) as sales_rep
	from sales.orders ord
	join sales.customers cus
	on ord.customer_id = cus.customer_id
	join sales.order_items ite
	on ord.order_id = ite.order_id
	join sales.stores sto
	on sto.store_id = ord.store_id
	join production.products prod
	on prod.product_id = ite.product_id
	join production.categories cat
	on cat.category_id = prod.category_id
	join production.brands brand
	on brand.brand_id = prod.brand_id
	join sales.staffs sta
	on sta.staff_id = ord.staff_id
	group by
		  ord.order_id
		, concat(cus.first_name, ' ', cus.last_name)
		, cus.city
		, cus.state
		, ord.order_date
		, prod.product_name
		, cat.category_name
		, brand.brand_name
		, sto.store_name
		, concat(sta.first_name, ' ', sta.last_name)
go