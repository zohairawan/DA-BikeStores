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
|Mount Vernon|NY|117010.21|
|Ballston Spa|NY|110065.34|
|San Angelo|TX|109729.26|
|Baldwinsville|NY|105893.45|
|Howard Beach|NY|104250.51|
|Orchard Park|NY|101189.27|
|Canyon Country|CA|96243.47|
|Monroe|NY|93938.34|
|Houston|TX|90449.47|
|Astoria|NY|89650.56|
|Central Islip|NY|86516.50|
|Smithtown|NY|85423.52|
|Harlingen|TX|85284.58|
|Amityville|NY|84748.55|
|Troy|NY|84367.62|
|Port Washington|NY|82867.34|
|Palos Verdes Peninsula|CA|82439.51|
|Webster|NY|80738.50|
|Merrick|NY|80471.38|
|Ossining|NY|79873.39|
|South El Monte|CA|77312.40|
|Uniondale|NY|74941.48|
|San Jose|CA|74585.60|
|Huntington Station|NY|74302.57|
|Canandaigua|NY|73946.33|
|Liverpool|NY|73780.48|
|Floral Park|NY|73527.53|
|Scarsdale|NY|71930.18|
|San Lorenzo|CA|71133.44|
|North Tonawanda|NY|70570.50|
|East Elmhurst|NY|69816.49|
|Duarte|CA|69143.49|
|Bay Shore|NY|69064.51|
|Campbell|CA|67848.40|
|Garland|TX|65123.55|
|Franklin Square|NY|63133.58|
|Longview|TX|62873.46|
|Santa Clara|CA|62289.70|
|Forney|TX|62067.56|
|New York|NY|61890.58|
|New Rochelle|NY|60026.57|
|Spring Valley|NY|59073.46|
|Garden City|NY|58458.67|
|Ronkonkoma|NY|58162.57|
|Hempstead|NY|57995.70|
|East Northport|NY|57804.56|
|Upland|CA|57693.50|
|Maspeth|NY|57629.61|
|Sunnyside|NY|57513.49|
|Bellmore|NY|57340.55|
|Jamaica|NY|57231.54|
|Baldwin|NY|56987.56|
|Fairport|NY|56825.66|
|Newburgh|NY|56198.57|
|Encino|CA|55750.57|
|Euless|TX|55562.48|
|Plainview|NY|54819.61|
|Sacramento|CA|54760.58|
|Utica|NY|54702.73|
|Glendora|CA|54647.56|
|Long Beach|NY|54236.60|
|Corpus Christi|TX|53917.53|
|Coachella|CA|53605.69|
|San Carlos|CA|53410.54|
|Richmond Hill|NY|53348.37|
|Monsey|NY|53280.65|
|Port Jefferson Station|NY|53205.62|
|Redondo Beach|CA|52223.63|
|Patchogue|NY|51797.70|
|Ithaca|NY|51568.68|
|Desoto|TX|51543.50|
|Sugar Land|TX|51423.61|
|Oxnard|CA|51314.51|
|South Ozone Park|NY|50825.56|
|Lancaster|NY|50798.60|
|Anaheim|CA|50406.49|
|New Windsor|NY|50254.68|
|Elmhurst|NY|49959.55|
|Apple Valley|CA|49916.55|
|Whitestone|NY|49895.66|
|Torrance|CA|49844.64|
|Brentwood|NY|49376.57|
|Wappingers Falls|NY|49115.65|
|Kingston|NY|48255.59|
|El Paso|TX|48124.67|
|Banning|CA|47268.57|
|Buffalo|NY|46293.61|
|Woodhaven|NY|45095.68|
|Plattsburgh|NY|44952.71|
|Rome|NY|44952.65|
|Oswego|NY|44590.65|
|Woodside|NY|44233.57|
|Victoria|TX|43284.70|
|Jackson Heights|NY|43005.60|
|Massapequa|NY|42934.67|
|Brooklyn|NY|42597.64|
|San Pablo|CA|42234.66|
|Massapequa Park|NY|41418.70|
|Rowlett|TX|40941.69|
|Nanuet|NY|40620.84|
|West Islip|NY|40206.77|
|Vista|CA|39987.72|
|Saratoga Springs|NY|39446.67|
|Oakland|CA|39043.63|
|Mahopac|NY|38839.70|
|Pleasanton|CA|38815.67|
|Bethpage|NY|38490.70|
|Ridgecrest|CA|38442.67|
|Depew|NY|38137.73|
|Staten Island|NY|38035.74|
|Lawndale|CA|38025.61|
|Pittsford|NY|37960.66|
|Schenectady|NY|37828.73|
|Fullerton|CA|37669.76|
|Hollis|NY|36560.71|
|Richardson|TX|36478.77|
|Niagara Falls|NY|36358.71|
|Lockport|NY|36209.81|
|Santa Monica|CA|33921.73|
|Rockville Centre|NY|33730.67|
|Oceanside|NY|32341.85|
|Bayside|NY|32286.73|
|New Hyde Park|NY|32030.72|
|Oakland Gardens|NY|31865.84|
|Port Chester|NY|31770.79|
|San Diego|CA|31256.76|
|Bronx|NY|31140.74|
|Lindenhurst|NY|31011.63|
|Santa Cruz|CA|30489.79|
|Lake Jackson|TX|30254.78|
|Carmel|NY|30075.69|
|Los Banos|CA|30059.73|
|Rocklin|CA|28606.68|
|Fort Worth|TX|28581.78|
|Atwater|CA|27959.69|
|Rochester|NY|27709.73|
|Valley Stream|NY|27342.75|
|Shirley|NY|27184.82|
|Centereach|NY|27048.75|
|Jamestown|NY|26919.73|
|Wantagh|NY|26763.81|
|Hicksville|NY|26509.71|
|Levittown|NY|26105.83|
|West Babylon|NY|25676.79|
|Queensbury|NY|25561.75|
|Endicott|NY|25508.77|
|Rosedale|NY|25441.75|
|Farmingdale|NY|24961.73|
|Flushing|NY|24234.77|
|Hopewell Junction|NY|24198.81|
|West Hempstead|NY|23867.80|
|Fresno|CA|23000.71|
|Amsterdam|NY|22833.81|
|Syosset|NY|22775.80|
|Pomona|CA|22636.75|
|Poughkeepsie|NY|21910.81|
|Hamburg|NY|20927.77|
|Fresh Meadows|NY|20894.83|
|Glen Cove|NY|20825.73|
|Forest Hills|NY|20723.77|
|New City|NY|20265.79|
|Coram|NY|19138.83|
|Helotes|TX|18958.84|
|Yonkers|NY|18399.72|
|East Meadow|NY|18258.81|
|Ozone Park|NY|18209.87|
|South Richmond Hill|NY|18179.84|
|Huntington|NY|17977.81|
|Ontario|CA|17944.87|
|Albany|NY|17539.91|
|Holbrook|NY|17498.89|
|Saint Albans|NY|17277.74|
|Selden|NY|16849.83|
|Deer Park|NY|16564.84|
|Corona|NY|15576.85|
|Middle Village|NY|14999.94|
|Freeport|NY|13570.86|
|Bakersfield|CA|13403.87|
|Amarillo|TX|13165.78|
|Rego Park|NY|12318.83|
|Elmont|NY|12127.80|
|Los Angeles|CA|11711.89|
|Auburn|NY|11607.86|
|Yorktown Heights|NY|10844.86|
|Commack|NY|10487.90|
|Clifton Park|NY|9063.80|
|Yuba City|CA|6899.95|
|Mcallen|TX|6874.92|
|Mountain View|CA|6194.93|
|San Antonio|TX|4621.89|
|Copperas Cove|TX|3337.94|
|Far Rockaway|NY|3249.94|
|Springfield Gardens|NY|1889.95|
|Westbury|NY|1437.98|
|Tonawanda|NY|1347.99|

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