# Questions and Answers

0. Consolidate all the necessary data
```sql
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
```
<br>
<br>

1. Revenue per region?
```sql
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
```
|city|state|revenue|
|----|-----|-------|
|Mount Vernon|test|
|Ballston Spa|
|San Angelo|
|Baldwinsville|
|Howard Beach|
|Orchard Park|
|Canyon Country|
|Monroe|
|Houston|
|Astoria|
|Central Islip|
|Smithtown|
|Harlingen|
|Amityville|
|Troy|
|Port Washington|
|Palos Verdes Peninsula|
|Webster|
|Merrick|
|Ossining|
|South El Monte|
|Uniondale|
|San Jose|
|Huntington Station|
|Canandaigua|
|Liverpool|
|Floral Park|
|Scarsdale|
|San Lorenzo|
|North Tonawanda|
|East Elmhurst|
|Duarte|
|Bay Shore|
|Campbell|
|Garland|
|Franklin Square|
|Longview|
|Santa Clara|
|Forney|
|New York|
|New Rochelle|
|Spring Valley|
|Garden City|
|Ronkonkoma|
|Hempstead|
|East Northport|
|Upland|
|Maspeth|
|Sunnyside|
|Bellmore|
|Jamaica|
|Baldwin|
|Fairport|
|Newburgh|
|Encino|
|Euless|
|Plainview|
|Sacramento|
|Utica|
|Glendora|
|Long Beach|
|Corpus Christi|
|Coachella|
|San Carlos|
|Richmond Hill|
|Monsey|
|Port Jefferson Station|
|Redondo Beach|
|Patchogue|
|Ithaca|
|Desoto|
|Sugar Land|
|Oxnard|
|South Ozone Park|
|Lancaster|
|Anaheim|
|New Windsor|
|Elmhurst|
|Apple Valley|
|Whitestone|
|Torrance|
|Brentwood|
|Wappingers Falls|
|Kingston|
|El Paso|
|Banning|
|Buffalo|
|Woodhaven|
|Plattsburgh|
|Rome|
|Oswego|
|Woodside|
|Victoria|
|Jackson Heights|
|Massapequa|
|Brooklyn|
|San Pablo|
|Massapequa Park|
|Rowlett|
|Nanuet|
|West Islip|
|Vista|
|Saratoga Springs|
|Oakland|
|Mahopac|
|Pleasanton|
|Bethpage|
|Ridgecrest|
|Depew|
|Staten Island|
|Lawndale|
|Pittsford|
|Schenectady|
|Fullerton|
|Hollis|
|Richardson|
|Niagara Falls|
|Lockport|
|Santa Monica|
|Rockville Centre|
|Oceanside|
|Bayside|
|New Hyde Park|
|Oakland Gardens|
|Port Chester|
|San Diego|
|Bronx|
|Lindenhurst|
|Santa Cruz|
|Lake Jackson|
|Carmel|
|Los Banos|
|Rocklin|
|Fort Worth|
|Atwater|
|Rochester|
|Valley Stream|
|Shirley|
|Centereach|
|Jamestown|
|Wantagh|
|Hicksville|
|Levittown|
|West Babylon|
|Queensbury|
|Endicott|
|Rosedale|
|Farmingdale|
|Flushing|
|Hopewell Junction|
|West Hempstead|
|Fresno|
|Amsterdam|
|Syosset|
|Pomona|
|Poughkeepsie|
|Hamburg|
|Fresh Meadows|
|Glen Cove|
|Forest Hills|
|New City|
|Coram|
|Helotes|
|Yonkers|
|East Meadow|
|Ozone Park|
|South Richmond Hill|
|Huntington|
|Ontario|
|Albany|
|Holbrook|
|Saint Albans|
|Selden|
|Deer Park|
|Corona|
|Middle Village|
|Freeport|
|Bakersfield|
|Amarillo|
|Rego Park|
|Elmont|
|Los Angeles|
|Auburn|
|Yorktown Heights|
|Commack|
|Clifton Park|
|Yuba City|
|Mcallen|
|Mountain View|
|San Antonio|
|Copperas Cove|
|Far Rockaway|
|Springfield Gardens|
|Westbury|
|Tonawanda|
<br>
<br>

2. Revenue per store?
```sql
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
```
<br>
<br>

3. Revenue per product category?
```sql
select
	  category_name
	, sum(revenue) as revenue
from vResultSet
group by
	    category_name
order by
	  revenue desc
```
<br>
<br>

4. Revenue per brand?
```sql
select
	  brand_name
	, sum(revenue) as revenue
from vResultSet
group by
	    brand_name
order by
	  revenue desc
```
<br>
<br>

5. A list of top customers?
```sql
select
	  customers
	, sum(revenue) as revenue
	, sum(total_units) total_units_bought
from vResultSet
group by
	  customers
order by
	  revenue desc
```
<br>
<br>

6. A list of top sales rep?
```sql
select
	  sales_rep
	, sum(revenue) as revenue
	, sum(total_units) total_units_sold
from vResultSet
group by
	  sales_rep
order by
	  revenue desc
```