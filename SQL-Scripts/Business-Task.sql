select * from vResultSet

-- Revenues per region --
select
	  city
	, state
	, sum(revenue) as revenue
from vResultSet
group by
	  city
	, state
order by
	  revenue desc


-- Revenue per store --
select
	  state
	, store_name
	, sum(revenue) as revenue
from vResultSet
group by
	    state
	  , store_name
order by
	  revenue desc


-- Revenue per product category --
select
	  category_name
	, sum(revenue) as revenue
from vResultSet
group by
	    category_name
order by
	  revenue desc


-- Revenue per brand --
select
	  brand_name
	, sum(revenue) as revenue
from vResultSet
group by
	    brand_name
order by
	  revenue desc


-- List of top customers --
select
	  customers
	, sum(revenue) as revenue
	, sum(total_units) total_units_bought
from vResultSet
group by
	  customers
order by
	  revenue desc


-- List of top sales reps --
select
	  sales_rep
	, sum(revenue) as revenue
	, sum(total_units) total_units_sold
from vResultSet
group by
	  sales_rep
order by
	  revenue desc