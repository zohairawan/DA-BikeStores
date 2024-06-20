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

1. Revenue per store?
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
|state|store_name|revenue|
|---|---|---|
|NY|Baldwin Bikes|5826242.21|
|CA|Santa Cruz Bikes|1790145.91|
|TX|Rowlett Bikes|962600.76|

<br>
<br>

2. A list of top sales rep?
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
|sales_rep|revenue|total_units_sold|
|---|---|---|
|Marcelene Boyer|2938888.73|2419
|Venita Daniel|2887353.48|2360
|Genna Serrano|952722.26|831
|Mireya Copeland|837423.65|685
|Kali Vargas|516695.17|412
|Layla Terrell|445905.59|371

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
|category_name|revenue|
|---|---|
|Mountain Bikes|3030775.71|
|Road Bikes|1852555.60|
|Cruisers Bicycles|1109151.04|
|Electric Bikes|1020236.85|
|Cyclocross Bicycles|799874.60|
|Comfort Bicycles|438506.87|
|Children Bicycles|327888.21|

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
|brand_name|revenue|
|---|---|
|Trek|5129381.61|
|Electra|1344143.79|
|Surly|1063135.82|
|Sun Bicycles|381919.69|
|Haro|207096.69|
|Heller|193798.71|
|Pure Cycles|166164.00|
|Ritchey|88498.82|
|Strider|4849.75|

<br>
<br>

5. Revenue per region?
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

6. A list of top customers?
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
|customers|revenue|total_units_bought|
|---|---|---|
|Pamelia Newman|37801.84|18|
|Abby Gamble|37500.89|11|
|Sharyn Hopkins|37138.86|15|
|Lyndsey Bean|35857.86|16|
|Emmitt Sanchez|34503.82|19|
|Melanie Hayes|34390.88|12|
|Debra Burks|30645.87|17|
|Elinore Aguilar|29661.83|17|
|Corrina Sawyer|29214.89|12|
|Shena Carter|27618.95|5|
|Robby Sykes|27157.88|12|
|Abram Copeland|26913.92|8|
|Genoveva Baldwin|26679.78|13|
|Tameka Fisher|26249.81|19|
|Lorrie Becker|25940.88|13|
|Teofila Fischer|25772.86|14|
|Mozelle Carter|25382.84|17|
|Guillermina Noble|24779.86|14|
|Damien Dorsey|24686.84|16|
|Daryl Spence|24198.88|13|
|Zelma Browning|23397.92|10|
|Adena Blake|22999.94|6|
|Brigid Sharp|22299.95|5|
|Jeanice Frost|22231.85|15|
|Danielle Bond|22000.92|8|
|Lizzie Joyner|21997.88|12|
|Tenisha Lyons|21941.86|14|
|Williemae Holloway|21928.86|15|
|Cindi Larson|21816.93|7|
|Augustina Joyner|21789.92|8|
|Kasha Todd|21653.85|15|
|Bess Mcbride|21097.95|7|
|Ashanti Hammond|20997.94|8|
|Deloris Burke|20949.89|11|
|Marvin Mullins|20830.92|8|
|Ruthanne Franco|20679.95|5|
|Penny Acevedo|20399.92|8|
|Tamela Harrell|20199.95|5|
|Carola Rodriquez|19879.89|13|
|Monica Sears|19739.89|11|
|Andreas Mayer|19699.92|8|
|Araceli Golden|19575.94|10|
|Bridgette Guerra|19539.84|16|
|Charmain Webster|19499.96|4|
|Charolette Rice|19442.88|13|
|Jimmy Russell|19419.94|6|
|Edris Barrett|19399.93|7|
|Jenniffer Bullock|19361.93|7|
|Shae Hickman|19263.95|5|
|Janetta Aguirre|19143.88|12|
|Paul Lester|19081.91|9|
|Laure Pena|19022.94|6|
|Ashlee Pena|18799.93|7|
|Ronna Butler|18768.85|16|
|Tomasa Carson|18709.93|7|
|Laraine Robbins|18706.88|12|
|Fran Yang|18567.94|8|
|Klara Stanley|18428.96|5|
|Tobie Little|18298.89|12|
|Sheryl Chase|18259.93|7|
|Lizzette Stein|18223.86|14|
|Alejandro Haney|18129.95|5|
|Adelle Larsen|18099.90|12|
|Ayanna Cherry|17996.92|8|
|Wynona Douglas|17988.91|9|
|Jeanie Kirkland|17911.93|7|
|Gilbert Calhoun|17857.96|6|
|Cleotilde Booth|17848.91|10|
|Thalia Dillard|17709.92|8|
|Ashanti Parks|17641.86|14|
|Addie Hahn|17369.92|8|
|Sarita Parks|17327.90|12|
|Parthenia Holman|17309.92|8|
|Garry Espinoza|17307.89|13|
|Georgetta Hardin|17306.87|15|
|Melia Brady|17156.91|10|
|Samual Warner|16859.92|8|
|Elnora Simpson|16767.91|9|
|Delmar Wise|16699.94|6|
|Consuela Collier|16509.92|8|
|Regenia Vaughan|16419.91|13|
|Dortha Jarvis|16358.94|7|
|Alissa Hood|16333.95|5|
|Gilberte Duke|16239.93|7|
|Saturnina Garner|16138.87|15|
|Kimberely Bowen|16123.94|6|
|Robena Hill|16075.89|11|
|Bong Hebert|16028.91|9|
|Regine Gonzales|15980.92|9|
|Candelaria Coffey|15937.93|7|
|Earlean Pena|15889.94|6|
|Jana Thomas|15839.93|7|
|Lashawn Ortiz|15830.88|13|
|Karla Kirk|15597.95|7|
|Desmond Rose|15549.93|7|
|Corene Wall|15455.84|16|
|Latasha Stanley|15419.89|11|
|Lorraine Marks|15355.93|7|
|Sophia Mcmillan|15249.92|8|
|Dorthea Walker|15059.94|6|
|Loreta Johnston|15053.91|9|
|Reatha Perez|15052.93|7|
|Gilberto Parsons|14999.94|6|
|Monty Frost|14946.94|6|
|Lissa Vargas|14938.88|13|
|Tammy Austin|14933.92|8|
|Petronila Norris|14837.93|9|
|Todd Waters|14801.92|8|
|Luke Kramer|14761.90|10|
|Bernardina Cooper|14759.95|5|
|Dorothea Chang|14548.98|3|
|Hedwig Paul|14461.92|8|
|Yan Mcgowan|14460.91|9|
|Frederica Rojas|14419.93|7|
|Lee Dunn|14379.93|7|
|Ardelia Cooley|14349.95|5|
|Alina Mcleod|14319.92|8|
|Cleopatra Tate|14239.91|9|
|Margret Barnett|14225.95|5|
|Somer Jordan|14109.95|5|
|Kiana Rivera|14101.93|7|
|Merlene Vinson|14090.87|13|
|Marlo Jefferson|13939.96|4|
|Nova Hess|13859.92|8|
|Olimpia Mays|13806.94|6|
|Dorine Roberson|13799.91|11|
|Marget Hodge|13782.93|7|
|Yan Trevino|13749.92|8|
|Cori Schwartz|13722.94|6|
|Jenee Rasmussen|13687.87|13|
|Ira Erickson|13679.95|5|
|Syreeta Hendricks|13599.94|6|
|Ivelisse Nixon|13553.93|7|
|Collene Knox|13501.96|4|
|Cesar Jackson|13459.90|12|
|Katharina Bates|13443.90|10|
|Yevette Elliott|13362.93|7|
|Dorthey Jackson|13323.91|10|
|Jone Bernard|13313.86|14|
|Mila Moody|13287.97|5|
|Letitia Franco|13169.95|5|
|Minerva Decker|13157.92|8|
|Sheba Knapp|13139.92|8|
|Efren Oliver|13079.95|5|
|Novella Ross|13029.96|4|
|Hae Ramirez|12999.98|2|
|Jeromy Burch|12989.89|11|
|Deloris Larson|12981.93|7|
|Danny Kim|12919.93|7|
|Coleen Navarro|12909.93|7|
|Janie Herrera|12860.94|6|
|Carita Salinas|12833.94|6|
|Moses Pope|12829.88|14|
|Brittney Woodward|12816.94|6|
|Lanita Burton|12769.92|8|
|Merideth Preston|12749.95|5|
|Erlinda Humphrey|12742.92|9|
|Lashawna Richardson|12669.92|8|
|Chantell Bridges|12659.97|3|
|Terra Pickett|12655.95|5|
|Phebe Turner|12605.94|6|
|Christoper Mccall|12571.93|7|
|Pinkie Kirkland|12543.91|9|
|Aleta Shepard|12474.92|10|
|Aron Wiggins|12470.97|3|
|Eliana Reese|12450.94|6|
|Ouida Gregory|12448.97|4|
|Lashandra Turner|12447.95|7|
|Gwendolyn Miller|12399.95|5|
|Yvone Guerrero|12377.96|6|
|Celestine Kent|12371.92|8|
|Kallie Best|12227.95|7|
|Delila Hamilton|12199.96|4|
|Alyse Jacobson|12155.91|9|
|Emmaline Huber|12110.94|7|
|Trinidad Mcclain|12080.95|5|
|Shanice Spears|11999.97|3|
|Arvilla Osborn|11985.95|5|
|Kanesha Vega|11978.93|9|
|Felicidad Golden|11899.95|5|
|Edythe Valencia|11899.94|6|
|Dollie Cervantes|11886.94|6|
|Deanne Parsons|11853.93|7|
|Jayne Kirkland|11842.92|8|
|Regina Burns|11799.93|7|
|Tena Huber|11789.94|6|
|Jamaal Albert|11677.88|14|
|Hubert Stone|11509.96|4|
|Santos Valencia|11509.89|11|
|Elouise Fry|11499.96|4|
|Felica Munoz|11463.92|8|
|Flossie Holder|11452.95|5|
|Jennie Middleton|11439.93|7|
|Mellisa Griffin|11439.92|8|
|Rosalva Hamilton|11399.96|4|
|Johnathan Velazquez|11397.94|8|
|Linnie Branch|11392.90|10|
|Leanna Manning|11387.94|8|
|Felice Guzman|11369.88|12|
|Muriel Juarez|11349.97|3|
|Mi Gray|11299.98|2|
|Shirely Stanley|11299.96|4|
|Nita Guy|11284.92|8|
|Katia Henry|11279.95|5|
|Le Deleon|11239.88|12|
|Lezlie Lamb|11237.95|7|
|Ernest Rollins|11218.95|7|
|Tereasa Bird|11209.97|3|
|Erna Sloan|11198.97|4|
|Harold O'connor|11169.93|9|
|Neil Mccall|11149.92|8|
|Bernetta Marquez|11099.97|3|
|Lidia Ashley|11099.94|6|
|Theo Reese|11035.92|10|
|Titus Bullock|11000.94|6|
|Tonisha Fowler|10999.96|4|
|Veronique Fulton|10990.93|7|
|Vashti Rosario|10949.97|3|
|Lavina Dejesus|10939.92|8|
|Catarina Mendez|10919.96|4|
|Marguerite Berger|10910.91|9|
|Ken Charles|10909.95|5|
|Basilia Thornton|10901.92|8|
|Jasmin Young|10899.96|4|
|Larae Carney|10880.92|8|
|Letisha May|10870.94|7|
|Jerlene Rios|10869.95|5|
|Justa Thompson|10807.95|7|
|Caridad Compton|10761.94|6|
|Florrie Little|10749.91|9|
|Sarai Mckee|10715.93|11|
|Donette Mccarthy|10699.96|4|
|Benito Hendrix|10693.96|4|
|Veronika Rollins|10679.96|4|
|Rico Salas|10638.95|6|
|Iola Rasmussen|10619.94|6|
|Letty Cobb|10593.94|8|
|Justina Long|10531.93|7|
|Jamaal Morrison|10497.98|4|
|Fannie Jenkins|10497.95|7|
|Bettie Glover|10489.96|4|
|Stan Saunders|10432.94|7|
|Octavia Case|10361.94|6|
|Deja Chaney|10360.92|8|
|Eleni Gordon|10330.94|6|
|Luz House|10307.90|10|
|Kami Rios|10278.95|6|
|Rudolph Velez|10270.96|4|
|Tomika Wilder|10260.91|9|
|Irving Pitts|10246.97|6|
|Salena Day|10189.93|7|
|Corinna Adams|10179.94|6|
|Yanira Bradshaw|10165.95|5|
|Macie Ayers|10155.92|8|
|Chelsey Hardin|10148.97|4|
|Buford Gilbert|10148.95|6|
|Rikki Morrow|10139.92|8|
|Tangela Quinn|10138.91|10|
|Ilona Spears|10126.94|6|
|Shu Mays|10070.96|4|
|Adelaida Hancock|10046.97|6|
|Ester Acevedo|9999.98|2|
|Marilyn Frank|9999.98|2|
|Gena Owens|9999.96|4|
|James Robles|9985.93|7|
|Randolph Chase|9959.92|8|
|Gertha Mejia|9949.94|6|
|Vince Schneider|9899.92|8|
|Barrett Sanders|9897.96|6|
|Trena Hudson|9849.94|6|
|Marjorie Logan|9840.94|9|
|Courtney Wyatt|9779.93|7|
|Brittni Green|9719.96|4|
|Lavona Austin|9718.95|6|
|Kasha Sullivan|9700.93|8|
|Tonja Bean|9653.92|8|
|Melodie Melton|9649.93|7|
|Clorinda Donovan|9639.94|6|
|Lenore Valdez|9609.92|8|
|Monika Berg|9589.90|10|
|Corrinne Garrison|9587.95|7|
|Euna Lopez|9529.96|4|
|Christel Barber|9529.95|5|
|Rey Lindsay|9519.94|6|
|Bobbie Foster|9491.89|11|
|Odette Moses|9469.95|5|
|Kasie Rodriquez|9369.95|5|
|Edgar Quinn|9361.96|4|
|Stephaine Riddle|9299.94|6|
|Ja Dillard|9296.97|6|
|Juliane Dillard|9263.90|10|
|Katelin Kennedy|9259.92|8|
|Carson Macias|9241.93|7|
|Santa Larson|9239.95|5|
|Dannette Guerrero|9199.95|5|
|Regine Odom|9197.97|5|
|Miquel Neal|9167.97|5|
|Leonore Dorsey|9167.97|5|
|Dwain Carlson|9159.94|6|
|Rodolfo Buck|9148.97|4|
|Keri Bridges|9139.95|6|
|Omega Huff|9120.94|7|
|Zora Ford|9119.94|6|
|Margorie Wynn|9114.96|5|
|Floretta Higgins|9097.98|4|
|Minnie Compton|9089.91|9|
|Merrie Fowler|9069.95|7|
|Barbera Riggs|9059.92|8|
|Viva Dawson|9047.94|8|
|Bettie Pierce|9039.94|6|
|Eli Contreras|9009.95|5|
|Olevia Pitts|8999.95|5|
|Tajuana Rollins|8981.97|3|
|Aimee Merritt|8969.94|6|
|Rozanne Reyes|8948.97|4|
|Meredith Bryan|8939.96|4|
|Christiane Bradford|8939.92|8|
|Brigida Larson|8937.95|7|
|Arline Lawson|8929.96|6|
|Marquerite Dawson|8892.92|8|
|Casimira Chapman|8891.92|8|
|Jenine Dawson|8819.93|7|
|Cris Dunn|8809.95|5|
|Kara Higgins|8789.94|6|
|Milagros Weber|8731.93|7|
|Vonda Berger|8718.93|8|
|Alishia Elliott|8703.94|6|
|Zoraida Patton|8661.93|7|
|Cecilia Camacho|8638.92|8|
|Latashia Travis|8610.94|7|
|Vallie Dixon|8599.96|4|
|Yuk Vega|8597.94|8|
|Chantay Maynard|8587.93|9|
|Brittney Rojas|8547.95|7|
|Janine Manning|8529.91|9|
|Mazie Fernandez|8499.96|4|
|Ocie Slater|8499.96|4|
|Nevada Hood|8497.97|5|
|Omega Johnston|8488.96|5|
|Tiesha Daniel|8487.90|12|
|Omer Estrada|8469.97|3|
|Gabriela Warren|8461.93|7|
|Tommie Cooley|8432.96|4|
|Magali Dixon|8428.96|5|
|Julianne Shannon|8418.92|8|
|Barbra Dickerson|8411.93|7|
|Farrah Orr|8389.93|7|
|Gertrud Rhodes|8368.95|6|
|Yu Mcdonald|8349.95|5|
|Casey Gill|8346.96|7|
|Ellena Clements|8327.95|7|
|Lashunda Cole|8239.97|3|
|Pamala Henry|8239.93|8|
|Myron Ruiz|8209.96|4|
|Parker Prince|8209.86|14|
|Blanca Hooper|8189.94|6|
|Justina Jenkins|8176.95|8|
|Caleb England|8149.91|9|
|Rochell Cantrell|8129.95|7|
|Arcelia Vinson|8099.93|7|
|Kermit Bowman|8083.91|9|
|Barton Crosby|8069.93|7|
|Malisa Mitchell|8059.94|6|
|Cinda Rocha|8039.93|7|
|Lucas Estes|8030.94|6|
|Lorrie Pollard|7999.98|2|
|Rona Rojas|7999.98|2|
|Diane Jones|7973.95|5|
|Sharie Whitaker|7959.93|7|
|Karole Alvarez|7949.95|5|
|Shery Randolph|7939.96|4|
|Terrance Lynn|7939.96|4|
|Ricki Bullock|7851.96|4|
|Elvia Cardenas|7850.94|6|
|Cassie Cline|7841.94|8|
|Tempie Jacobson|7832.97|3|
|Tonda Armstrong|7830.95|5|
|Trinity Riddle|7810.96|5|
|Carley Reynolds|7802.90|10|
|Rutha Howell|7782.96|4|
|Joeann Garrison|7767.95|7|
|Renna Williams|7763.94|6|
|Josephine Dale|7762.94|6|
|Virgen Clemons|7749.97|3|
|Armand Whitehead|7748.94|7|
|Jayson Rutledge|7739.94|6|
|Keturah Reid|7739.93|7|
|Coleman Boyd|7720.95|5|
|Latasha Hays|7707.96|6|
|Joaquin Hawkins|7693.96|4|
|Stacie Sims|7681.94|6|
|Lavonne Anderson|7680.97|3|
|Lavette Wright|7669.93|7|
|Jesus Burch|7629.96|4|
|Herlinda Stone|7599.96|4|
|Herminia Reyes|7599.95|5|
|Ji Burt|7599.94|6|
|Carmelina Sellers|7579.95|5|
|Dottie Roberts|7577.97|5|
|Elaina Key|7571.94|6|
|Elma Molina|7564.93|7|
|Chere Mcfadden|7559.95|5|
|Verda Gilbert|7551.96|4|
|Bethany Herring|7548.98|3|
|Norine Huffman|7548.98|3|
|Sherie Ayala|7546.96|7|
|Leigh Burke|7539.96|4|
|Vito Pickett|7539.93|7|
|Kellye Campbell|7511.92|8|
|Joesph Delacruz|7499.92|8|
|Ann Heath|7481.92|8|
|Mercy Brown|7471.94|6|
|Charlene Norris|7447.97|5|
|Hortencia Graham|7439.94|6|
|Elmira Levy|7429.95|5|
|Stefani Gamble|7409.96|5|
|Lynwood Jackson|7399.94|6|
|Cecil Hopper|7397.97|5|
|Marjory Leonard|7396.92|8|
|Celestine Jacobs|7379.95|5|
|Shantae Hammond|7379.94|8|
|Cicely Deleon|7369.95|5|
|Vikki Erickson|7361.96|4|
|Conrad Mueller|7349.97|3|
|Nichelle Rosario|7349.97|3|
|Lucio Sherman|7319.95|7|
|Hue May|7319.93|7|
|Javier Nichols|7309.94|6|
|Deirdre Ryan|7299.97|3|
|Tressa Weiss|7299.97|3|
|Erlinda Nielsen|7299.96|4|
|Mable Pratt|7275.97|3|
|Londa Gould|7263.91|9|
|Yvone Yates|7239.95|5|
|Siobhan Lang|7229.96|4|
|Wilda Petersen|7221.95|5|
|Collene Roman|7199.96|4|
|Kate Barber|7179.97|3|
|Damian Mills|7179.96|4|
|Lolita Mosley|7179.94|6|
|Kaley Blanchard|7179.92|8|
|Josef Greer|7173.93|7|
|Mellie Puckett|7150.95|5|
|Tuyet Rosa|7146.94|6|
|Katherin Clark|7127.96|6|
|Kristofer Craig|7099.96|4|
|Shiloh Bates|7051.97|3|
|Tora Dunlap|7048.97|4|
|Mina Carrillo|7033.98|2|
|Stefany Potter|7017.96|6|
|Emanuel Mckee|6999.97|3|
|Buford Bridges|6999.96|4|
|Nenita Mooney|6969.93|7|
|Ivette Warren|6968.96|5|
|Anisha Lang|6968.94|8|
|Latoya Johns|6957.97|5|
|Dionne Norris|6949.95|5|
|Tu Ramirez|6931.94|7|
|Louanne Martin|6899.95|5|
|Octavia Donaldson|6897.96|6|
|Van Peters|6895.99|5|
|Oliva Blackwell|6889.94|6|
|Jeni Booker|6889.93|7|
|Hermila Mckay|6872.96|4|
|Adriene Rivera|6849.96|4|
|Jewel Sparks|6839.95|5|
|Chelsey Boyd|6828.97|4|
|Bettye Espinoza|6809.95|5|
|Shona Mcmillan|6799.98|2|
|Raymonde Garcia|6799.96|4|
|Rosamaria Meyer|6781.94|6|
|Alisia Albert|6779.93|7|
|Annett Rush|6779.92|8|
|Matilda Larson|6749.97|3|
|Lanora Robbins|6748.95|6|
|Tiny French|6739.96|4|
|Tammie Cherry|6717.95|7|
|Shara Pope|6709.96|4|
|Allison Nolan|6708.92|9|
|Hilda Harvey|6697.98|4|
|Drucilla Gilliam|6669.95|5|
|Daisy Ward|6659.95|5|
|Shila White|6641.97|3|
|Vicki Wiggins|6639.94|6|
|Bella Perez|6629.95|5|
|Carissa Cross|6609.95|5|
|Lois Steele|6609.95|5|
|Moira Lester|6572.94|6|
|Laurel Schultz|6559.95|5|
|Trista Lambert|6549.97|3|
|Aubrey Durham|6547.96|6|
|Effie Jenkins|6537.95|5|
|Ruthanne Hoover|6499.93|7|
|Valeri Marshall|6468.94|6|
|Rayna Perry|6459.98|4|
|Nicolas Carlson|6456.94|6|
|Ciera Koch|6452.92|8|
|Reena Higgins|6428.96|5|
|Danille Mcfarland|6418.94|7|
|Jeromy Elliott|6399.96|4|
|Bernita Mcdaniel|6399.94|6|
|Conception Slater|6369.94|6|
|Bev Chang|6359.96|4|
|Yang Giles|6359.95|5|
|Shantel Gregory|6320.96|4|
|Shonta Preston|6318.96|5|
|Conchita Boone|6309.92|8|
|Oralia Farley|6301.95|5|
|Delma Bailey|6299.98|2|
|Phuong Wolf|6298.98|3|
|Carie Kidd|6290.94|7|
|Karl Stephens|6269.95|5|
|Deane Sears|6265.96|4|
|Trang Hardin|6249.96|4|
|Aaron Knapp|6248.98|3|
|Karren Stevenson|6239.96|4|
|Sherril Alvarado|6230.95|7|
|Denis Logan|6219.92|8|
|Heather Chaney|6209.95|5|
|Sharie Alvarez|6206.94|9|
|Leone Emerson|6201.91|9|
|Sung Chambers|6199.96|4|
|Hollis Rasmussen|6199.95|5|
|Zina Bonner|6159.93|7|
|Adam Thornton|6148.97|4|
|Hipolito Padilla|6130.93|7|
|Shanda Stevenson|6120.95|5|
|Cameron Carroll|6099.97|3|
|Alline Beasley|6099.95|5|
|Renita Henry|6098.97|4|
|Randee Pitts|6097.99|3|
|Maira Long|6093.91|9|
|Selene Austin|6091.94|6|
|Yevette Todd|6079.96|4|
|Cheree Hale|6076.94|7|
|Josh Shaw|6068.93|8|
|Melba Wilkinson|6061.94|6|
|Ashleigh Finch|6048.96|5|
|Dung Reid|6019.96|4|
|Arnita Thomas|5999.98|2|
|Ling Newman|5999.98|2|
|Kellie Franco|5999.98|2|
|Shenna Espinoza|5999.98|2|
|Georgina Gonzales|5999.97|3|
|Sheila Travis|5999.96|4|
|Dagny Owen|5997.99|3|
|Larissa Hays|5977.94|8|
|Quyen Houston|5969.98|2|
|Wai Soto|5963.95|5|
|Ginette Edwards|5939.94|6|
|Caren Stephens|5927.92|10|
|Iva Wilcox|5890.95|6|
|Renay Atkins|5889.94|6|
|Larraine Horn|5850.95|5|
|Jackeline Colon|5839.95|5|
|Loreen Byers|5829.94|7|
|Ollie Zimmerman|5802.93|7|
|Ashleigh Frank|5799.98|2|
|Vernia Madden|5799.98|2|
|Jamika Blanchard|5769.93|7|
|Yahaira Robertson|5767.95|7|
|Romelia Myers|5751.96|4|
|Margit Osborn|5739.92|8|
|Spring Hayes|5730.96|4|
|Eliseo Knight|5722.95|6|
|Earl Stanley|5710.95|5|
|Kimbery Nieves|5699.94|6|
|Melani Jarvis|5697.96|6|
|Genoveva Lloyd|5675.93|7|
|Thurman Ellis|5670.95|5|
|Virgina Berg|5653.94|6|
|Genevieve Juarez|5637.96|6|
|Beatris Joyner|5621.94|6|
|Carline Collier|5618.93|7|
|Theresia Barron|5611.92|8|
|Myesha Burgess|5609.96|4|
|Patrina Tanner|5599.97|3|
|Majorie Wyatt|5587.95|7|
|Dante Grimes|5548.99|2|
|Claris Santiago|5529.95|7|
|Andy O'neill|5520.93|7|
|Brenda Tate|5518.96|5|
|Romeo Steele|5509.94|6|
|Lise Hebert|5508.94|6|
|Lurlene Cotton|5499.99|1|
|Nicholas Vazquez|5499.99|1|
|Inocencia Key|5499.99|1|
|Ai Forbes|5499.96|4|
|Alysia Nicholson|5499.95|5|
|Major Merrill|5497.97|5|
|Ernestina Skinner|5489.96|4|
|Novella Patel|5471.94|6|
|Kandace Ayers|5471.93|7|
|Jerri Guthrie|5468.97|4|
|Evelina Manning|5441.95|5|
|Keturah Massey|5439.92|8|
|Chasidy Tran|5426.97|6|
|Amina Salazar|5407.97|6|
|Margert Stevens|5401.93|7|
|Latosha Dalton|5389.95|6|
|Dewayne Herring|5378.95|6|
|Elenore William|5351.95|5|
|Yolando Wade|5339.95|5|
|Risa Gallagher|5320.92|8|
|Sarah Kirkland|5319.96|4|
|Cinthia Poole|5319.95|5|
|Eleanor Mendez|5267.98|4|
|Chauncey Donaldson|5249.96|4|
|Laverna Hernandez|5199.95|5|
|Emmett Hahn|5189.96|4|
|Margaretta Clayton|5170.92|9|
|Charlyn Cantrell|5167.98|4|
|Bobbi Banks|5161.97|3|
|Krissy Ochoa|5159.92|8|
|Graig Cannon|5151.94|6|
|Deandrea Cox|5148.95|6|
|Kaylee English|5139.96|4|
|Raven Curtis|5129.96|6|
|Ayana Keith|5126.94|6|
|Alfredo Dodson|5109.93|7|
|Enoch Rosario|5101.94|6|
|Elenore Hensley|5099.93|7|
|Graig Roth|5096.98|5|
|Cindie Franklin|5086.96|7|
|Marry Benjamin|5076.97|7|
|Clelia Workman|5069.97|3|
|Marcel Lindsay|5060.94|6|
|Lazaro Moran|5060.93|8|
|Janna Hayden|5049.93|7|
|Judith Finley|5039.96|4|
|Ileana Holt|4999.99|1|
|Ruth Horton|4999.99|1|
|Erik Leblanc|4999.98|2|
|Christiana Gross|4999.95|5|
|Sharika Colon|4997.97|5|
|Rebbecca Espinoza|4991.94|6|
|Carmela Hays|4990.95|6|
|Carmina Emerson|4978.98|3|
|Gilberto Sanders|4941.94|6|
|Aileen Marquez|4920.96|4|
|Toshia Cardenas|4919.96|4|
|Ara Vazquez|4919.94|6|
|Herta Rollins|4914.95|7|
|Hilde Nieves|4913.91|9|
|Genoveva Tyler|4901.95|5|
|Nicola Knight|4901.92|8|
|Olevia Noel|4899.97|3|
|Kimberley Reynolds|4898.96|5|
|Scarlet Yates|4897.99|3|
|Nathaniel Richard|4877.97|5|
|Carolann Russell|4854.95|6|
|Jovita Bishop|4847.96|6|
|Genny Hensley|4841.95|5|
|Anderson Martin|4831.95|5|
|Kam Wilder|4830.94|6|
|Kendra Harrington|4829.94|7|
|Eliana Silva|4815.94|6|
|Annis Sanchez|4809.95|5|
|Reyes Merritt|4799.96|4|
|Marisa Chambers|4797.97|5|
|Alexandria Zamora|4789.96|6|
|Ladawn Downs|4786.97|6|
|Porter Bass|4783.93|7|
|Abbey Pugh|4778.99|3|
|Raeann Duncan|4719.95|5|
|Crystle Gilliam|4717.98|4|
|Ana Palmer|4709.93|7|
|Trudy Riddle|4699.94|6|
|Max Charles|4697.96|6|
|Loraine Sykes|4689.92|8|
|Ophelia Rodgers|4681.94|6|
|Rufina Chandler|4680.98|2|
|Diana Guerra|4673.91|9|
|Aida Koch|4659.96|4|
|Jule Davenport|4649.95|5|
|Penni Best|4642.95|5|
|Collen Dennis|4635.94|6|
|Maryalice Henry|4635.93|7|
|Lillia Gillespie|4631.94|6|
|Carter Bentley|4629.92|8|
|Sindy Anderson|4620.95|5|
|Andria Rivers|4611.92|8|
|Jane Henderson|4607.95|5|
|Olympia Figueroa|4599.98|2|
|Verona O'neill|4599.97|3|
|Tonda Webb|4599.95|5|
|Nathalie Knowles|4597.98|4|
|Fairy Robinson|4584.95|6|
|Lory Page|4569.97|3|
|Gabriel Wagner|4569.92|8|
|Alica Hunter|4568.94|7|
|Afton Juarez|4567.97|5|
|Tajuana Riddle|4539.98|2|
|Mallie Osborn|4539.95|5|
|Adam Henderson|4519.97|3|
|Nettie Mcdaniel|4517.94|8|
|Gustavo Gamble|4512.93|7|
|Rudolf Moran|4509.93|7|
|Sam Lester|4507.95|7|
|Delfina Gilliam|4499.98|2|
|Lory Berg|4499.98|2|
|Dung King|4499.97|3|
|Brianna Moss|4490.97|3|
|Louise Flowers|4489.95|5|
|Dale Rasmussen|4481.94|6|
|Brianne Hays|4469.98|2|
|Georgeann Waller|4459.97|3|
|Laureen Barry|4449.92|8|
|Sharyn Brewer|4445.95|5|
|Nelle Beck|4442.94|6|
|Le Wood|4421.96|4|
|Kathie Freeman|4413.92|8|
|Marni Bolton|4411.95|5|
|Valentin Mclaughlin|4409.91|9|
|Angella Bridges|4405.95|5|
|Shanna Bonner|4399.96|4|
|Annett Garrett|4397.95|5|
|Ellsworth Michael|4397.95|7|
|Winfred Harris|4389.91|9|
|Katherina Odom|4388.97|4|
|Arielle Levine|4369.96|4|
|Scarlet Reed|4365.96|4|
|Bronwyn Vargas|4361.96|4|
|Henrietta Wagner|4355.97|7|
|Georgeann Rojas|4333.90|10|
|Tayna Wade|4320.98|2|
|Derrick Marks|4318.97|4|
|Janae Doyle|4303.96|4|
|Whitley Cannon|4294.93|8|
|Joi Reeves|4288.95|6|
|Julia Joyner|4272.93|7|
|Travis Whitley|4269.93|7|
|Cher Alston|4259.94|6|
|Wendie Nash|4223.96|4|
|Weldon Michael|4219.98|4|
|Delbert Wilkins|4219.97|4|
|Mark Garrett|4201.95|5|
|Lara Guy|4199.98|2|
|Julius Holt|4199.97|3|
|Donnetta Henson|4199.94|6|
|Lavern Orr|4198.97|4|
|Verna Solis|4179.96|4|
|Shawnda Glover|4177.95|7|
|Reita Dickson|4155.95|5|
|Lina Meadows|4140.93|7|
|Lee Roman|4131.96|4|
|Arla Ellis|4126.99|4|
|Rosanne George|4117.97|3|
|Lore Sykes|4089.96|4|
|Miriam Baker|4088.92|8|
|Deshawn Mendoza|4079.93|7|
|Alden Atkinson|4076.97|6|
|Lewis Garner|4062.95|7|
|Jonell Rivas|4043.95|5|
|Charlesetta Soto|4039.97|3|
|Darcel Harmon|4029.96|4|
|Darren Witt|4028.98|3|
|Micki Rutledge|4020.93|7|
|Camille Harvey|4018.97|4|
|Shay Stephenson|4017.96|6|
|Barry Albert|4007.99|3|
|Agatha Daniels|4006.97|6|
|Divina Madden|3999.99|1|
|Priscilla Wilkins|3999.99|1|
|Son Warner|3999.99|1|
|Claudio Wise|3989.98|2|
|Noble Glover|3979.93|7|
|Sebrina Hart|3976.00|4|
|Han Wade|3961.97|3|
|America Swanson|3961.96|4|
|Rod Hatfield|3959.92|8|
|Rodrick Shelton|3950.94|6|
|Crysta Velez|3948.99|2|
|Sharell Ross|3941.96|4|
|Marcene Curtis|3937.92|8|
|Izola Hobbs|3919.95|5|
|Bennett Armstrong|3912.94|6|
|Harris Pittman|3908.96|6|
|Hee Greer|3899.97|3|
|Christia Carson|3897.98|4|
|Lucy Woods|3897.98|4|
|Shery Acosta|3888.93|8|
|Mirella Duffy|3868.96|6|
|Bonita Marshall|3860.94|6|
|Lanie Dunn|3843.96|6|
|Kandace Giles|3833.94|6|
|Tricia Daniels|3818.96|6|
|Steve Bender|3809.95|6|
|Shemeka Lyons|3806.97|6|
|Alejandrina Hodges|3803.92|8|
|Skye Pope|3799.91|9|
|Pamala Fowler|3789.96|4|
|Catrice Hicks|3780.94|6|
|Neville Mcclain|3779.94|7|
|Sheila Goodman|3769.96|4|
|Annabelle Hebert|3745.91|9|
|Demarcus Reese|3720.95|5|
|Chi Goff|3709.96|4|
|Daina Sampson|3701.96|4|
|Tina Bush|3701.96|4|
|Sanora Webster|3701.95|5|
|Brenton Whitaker|3699.94|6|
|Victor Pittman|3670.95|5|
|Leila Barr|3669.95|6|
|Eloisa Tucker|3659.97|3|
|Tam Fisher|3639.97|3|
|Efren Whitfield|3625.95|5|
|Doris Kaufman|3609.95|5|
|Hassan Nash|3599.98|2|
|Carisa Carpenter|3599.98|2|
|Hubert Reilly|3599.98|2|
|Pearlie Cochran|3599.98|2|
|Vinnie Chan|3599.97|3|
|Barton Cox|3567.96|6|
|Loise Walker|3555.99|5|
|Emmett Casey|3548.98|3|
|Tisa Whitney|3547.96|4|
|Garret Clay|3541.97|3|
|Boyd Irwin|3541.96|4|
|Tarra Guerrero|3539.95|5|
|Patience Clayton|3527.95|7|
|Season Harvey|3519.94|6|
|Deandrea Vega|3500.94|6|
|Miranda Kennedy|3499.99|1|
|Latonya Dixon|3499.99|1|
|Shayla Hart|3499.98|4|
|Ehtel Cobb|3499.96|4|
|Carlena Salinas|3497.96|6|
|Dorothea Miranda|3481.95|5|
|Camila Carroll|3481.92|8|
|Garland Weaver|3467.95|7|
|Morton Lee|3463.97|3|
|Edda Young|3459.96|4|
|Rolanda Larsen|3458.97|4|
|Saran Moses|3449.98|2|
|Vernon Knowles|3449.98|2|
|Ross Pugh|3439.93|7|
|Soledad Moses|3433.95|5|
|Aisha Woods|3429.98|2|
|Ingeborg Ellison|3418.97|5|
|Ophelia Decker|3409.97|4|
|Sandy Mills|3399.95|5|
|Sylvie Wilkerson|3397.99|3|
|Marisol Goodman|3397.99|3|
|India Barron|3389.93|7|
|Waldo Hart|3369.98|2|
|Terrell Mathis|3369.96|5|
|Ryan Carter|3361.98|2|
|Earline Gordon|3361.98|2|
|Donovan Cantrell|3361.98|2|
|Florencio Davenport|3359.95|5|
|Alesia Horne|3359.95|7|
|Douglass Little|3359.94|6|
|Louis Powell|3359.94|6|
|Adriene Rollins|3348.99|2|
|Etsuko Garrison|3339.94|6|
|Alpha King|3338.95|6|
|Danyell Dickerson|3310.95|5|
|Tuan Wolfe|3295.98|6|
|Orval Hunter|3279.96|4|
|Tena Cruz|3278.93|7|
|Kecia Olsen|3269.98|2|
|Fransisca Nicholson|3269.98|2|
|Genny Fields|3269.97|3|
|Queenie Vance|3259.96|4|
|Loyce Conway|3258.96|6|
|Yvette Rogers|3248.96|5|
|Marcelino Mcbride|3241.97|3|
|Corine Stuart|3239.92|8|
|Elvina Gates|3231.94|6|
|Tama Berg|3231.94|6|
|Jeannette Skinner|3223.95|5|
|Bao Wade|3219.94|6|
|Rudolf Gilliam|3213.93|7|
|Mellisa Kim|3199.99|1|
|Nanette Harris|3199.99|1|
|Homer Powers|3199.98|2|
|Arvilla Weiss|3199.97|3|
|Agnes Sims|3199.95|5|
|Ami Mcmahon|3199.94|6|
|Nakisha Clay|3182.94|6|
|Sheree Pena|3181.97|3|
|Ezra Fowler|3180.97|3|
|Petronila Gallegos|3173.95|5|
|Walton Dejesus|3169.98|2|
|Roy Chan|3159.96|4|
|Luis Tyler|3159.94|6|
|Marlen Dawson|3149.98|2|
|Willis Randolph|3137.94|6|
|Dexter Roberts|3119.98|2|
|Babara Ochoa|3119.98|2|
|Garth Huff|3098.00|2|
|Karey Steele|3098.00|2|
|Shawnna Frank|3082.95|5|
|Violet Valenzuela|3079.96|4|
|Melita Dominguez|3079.94|6|
|Renato Morton|3064.96|4|
|Kirstie Vazquez|3059.96|4|
|Penney Hall|3048.98|3|
|Myung Hooper|3039.95|5|
|Elmo Sweeney|3033.94|6|
|Dorine Thornton|3029.94|6|
|Raul Melendez|3019.96|4|
|Ping Quinn|3019.94|6|
|Shiela Calderon|3017.96|6|
|Armando Black|3012.94|6|
|Lamar Greer|3003.97|3|
|Carina Lynch|3003.92|8|
|Houston Vasquez|2999.99|1|
|Hildegarde Christensen|2999.99|1|
|Jeniffer Slater|2999.99|1|
|Sunshine Rosario|2999.99|1|
|Rita Bailey|2966.96|4|
|Kattie Stevenson|2950.93|7|
|Alexis Mack|2946.97|6|
|Candis Harding|2925.97|7|
|Bee Baker|2911.97|3|
|Erma Salinas|2909.94|6|
|Eliz Lynch|2899.99|1|
|Alissa Craft|2899.99|1|
|Andreas Herman|2899.99|1|
|Zona Cameron|2899.99|1|
|Wanita Davenport|2899.97|3|
|Shea Howell|2899.96|4|
|Devin Velazquez|2899.95|5|
|Ashton Lott|2897.98|4|
|Dann Huff|2897.97|5|
|Travis Goodman|2889.93|7|
|Mariam Miranda|2888.96|5|
|Lea Key|2879.95|5|
|Carman Hardy|2879.95|5|
|Timothy Byers|2870.96|4|
|Lenita Bonner|2869.99|2|
|Corina Lynch|2860.96|4|
|Bea Kane|2859.94|6|
|Kim Clark|2853.94|6|
|Natosha Rowland|2849.96|4|
|Graciela Barber|2849.92|8|
|Jame Riggs|2839.94|6|
|Lolita O'neill|2829.94|6|
|Rubin Decker|2809.94|6|
|Rochelle Ward|2799.95|5|
|Raphael O'neil|2799.94|6|
|Sherilyn Wilcox|2782.97|4|
|Michel Blankenship|2769.93|7|
|Aide Franco|2763.96|4|
|Silas Tate|2739.95|5|
|Nanette Roman|2727.93|7|
|Myrl Gay|2699.97|3|
|Kerrie Morton|2699.96|4|
|Ronald Parsons|2698.98|3|
|Agustina Lawrence|2696.95|5|
|Thad Castro|2679.94|6|
|Edra Fitzgerald|2675.95|5|
|Joel Wynn|2659.96|4|
|Mariana Strong|2658.98|3|
|Shasta Combs|2657.99|3|
|Alejandro Norman|2641.98|2|
|Collen Hayes|2641.98|2|
|Vanda Holmes|2639.94|6|
|Willow Gardner|2633.96|4|
|Mireille Puckett|2633.93|7|
|Ilda Roberson|2629.96|4|
|Clare Neal|2619.96|4|
|Dacia William|2619.95|5|
|Zelda Pratt|2607.97|5|
|Jacquline Duncan|2603.95|5|
|Gertrude Terry|2599.97|3|
|Mercedez Brooks|2599.96|4|
|Selene Vega|2596.95|5|
|Ebony Cotton|2592.95|5|
|Rory Cooper|2578.99|3|
|Malinda Baxter|2573.94|6|
|Onita Johns|2569.93|7|
|Manie Sanchez|2557.97|5|
|Dane Mcdaniel|2543.95|7|
|Khalilah Robertson|2539.96|4|
|Tanesha Hampton|2538.99|3|
|Maximina Hutchinson|2513.94|6|
|Ivonne Yang|2511.96|4|
|Angelika Perry|2503.95|5|
|Justin Newton|2499.96|4|
|Tad Gardner|2490.97|4|
|Faustino Delacruz|2489.96|4|
|Honey Camacho|2482.96|4|
|Lavonda Stephenson|2479.97|3|
|Loan Graham|2459.94|6|
|Laurette Hebert|2452.95|5|
|Carlie Terrell|2447.95|7|
|Laurence Christian|2420.97|3|
|Cira Downs|2389.95|5|
|Laureen Paul|2387.98|4|
|Shiloh Reeves|2381.97|3|
|Divina Reeves|2368.98|3|
|Shanita Wiley|2365.96|4|
|Willetta Murphy|2359.94|6|
|Luciano Marsh|2339.94|6|
|Chanel May|2329.95|5|
|Pasquale Hogan|2327.97|5|
|Vernetta Banks|2319.96|4|
|Trinidad Chapman|2315.98|6|
|Eric Hardin|2289.98|2|
|Dori Alvarez|2282.96|5|
|Lamar Bush|2280.96|5|
|Kenton Hughes|2277.96|6|
|Qiana Jackson|2273.92|8|
|Emory O'connor|2269.96|4|
|Alita Salinas|2269.96|4|
|Joshua Berg|2269.95|5|
|Lynne Anderson|2267.96|6|
|Damian Dawson|2265.97|3|
|Calandra Stanton|2260.97|3|
|Mathilda Pennington|2259.96|4|
|Elanor Patrick|2248.98|3|
|Lorrie Justice|2248.96|5|
|Neoma Daugherty|2247.99|3|
|Phebe Soto|2239.96|4|
|Douglass Blankenship|2239.94|6|
|Sheri Cole|2225.99|5|
|Nestor Haynes|2218.98|3|
|Toya Pratt|2212.94|6|
|Inge Olsen|2199.97|3|
|Lucile Manning|2199.94|6|
|Cathey Lamb|2198.97|4|
|Genevie Miles|2183.95|5|
|Kenyetta Mason|2179.96|4|
|Shanti Johnston|2179.96|4|
|Lean Stark|2159.96|4|
|Hugh Craft|2154.97|3|
|Kathyrn Bush|2149.96|4|
|Tonja Henderson|2148.98|3|
|Klara Kim|2142.95|5|
|Garry Juarez|2139.96|4|
|Angie Powers|2139.96|4|
|Elvera Peck|2119.98|2|
|Kandi Mcneil|2109.96|4|
|Marina Hinton|2103.96|4|
|Sharla Flynn|2100.97|3|
|Phylis Adkins|2099.96|4|
|Kristel Byrd|2099.96|4|
|Yvonne Bean|2088.98|3|
|Thad Gilliam|2069.98|2|
|Jamaal Baker|2069.96|4|
|Hortencia O'neil|2069.95|5|
|Aleta Mack|2068.94|7|
|Shenna Benton|2059.97|3|
|Jeffrey Hill|2050.98|2|
|Lynda Newman|2039.96|4|
|Jong Guthrie|2037.97|5|
|Vernell Goff|2037.96|4|
|Rosalie Coffey|2027.98|4|
|Josie Schultz|2018.99|2|
|Takako Casey|2012.98|2|
|Leticia Snyder|2008.96|5|
|Majorie Glover|1999.98|2|
|Earline Ballard|1999.98|2|
|Consuela Romero|1999.98|2|
|Luke Fuller|1999.96|4|
|Jama Rodriquez|1999.95|5|
|Liliana Kerr|1997.98|4|
|Shauna Edwards|1997.98|4|
|Lurlene Finch|1993.94|6|
|Jesica Fields|1989.98|2|
|Cyndi Bush|1979.97|3|
|Evelina Byrd|1970.94|6|
|Nikita Roy|1969.97|3|
|Tomeka Higgins|1969.96|4|
|Maple Griffin|1967.97|3|
|Caroll Hays|1963.97|3|
|Ferne Kline|1949.97|3|
|Ghislaine Compton|1949.94|6|
|Cesar Wilkins|1947.97|5|
|Cheryll Snyder|1939.96|4|
|Brain Skinner|1939.95|5|
|Manie Maxwell|1932.98|2|
|Rodger Rojas|1928.96|5|
|Pandora Estes|1920.98|2|
|Inez Snider|1920.98|2|
|Freddie Mathis|1915.97|3|
|Catherine Miles|1907.94|6|
|Marshall Johnson|1899.98|2|
|Gayla Sims|1899.00|1|
|Ezra Silva|1897.99|3|
|Lurline Rivers|1888.97|4|
|Krystin Marshall|1880.96|4|
|Rodney Odom|1877.98|4|
|Serina Hensley|1863.96|4|
|Gussie Harding|1861.96|4|
|Myrtle Gardner|1859.97|3|
|Gwenn Melton|1858.96|5|
|Mark Benton|1839.96|4|
|Carolyne Conley|1819.97|3|
|Charleen Hurst|1818.99|2|
|Cristobal Hutchinson|1817.95|5|
|Eliz Whitney|1803.95|5|
|Loni Duncan|1799.99|1|
|Myron Johns|1799.99|1|
|Kimberli Cline|1799.99|1|
|Sherise Mercer|1799.99|1|
|Maurice Norton|1799.98|2|
|Jaqueline Cummings|1799.97|3|
|Thanh Figueroa|1799.97|3|
|Rosa Kinney|1799.96|4|
|Danilo Holmes|1797.98|4|
|Charleen Joyner|1787.95|5|
|Neida King|1777.97|3|
|Vivian Deleon|1769.98|2|
|Cyndi Dyer|1769.97|3|
|Dalia Carson|1767.97|5|
|Boyce Burks|1767.97|5|
|Guillermo Hart|1756.00|4|
|Jerri Henry|1751.98|2|
|Anya Contreras|1749.98|2|
|Ivette Estes|1749.97|3|
|Basil Ballard|1749.96|4|
|Hilary Savage|1739.98|2|
|Heide Reed|1739.96|4|
|Angelina Lloyd|1739.96|4|
|Darcie Morgan|1733.97|3|
|Kaila Walters|1709.98|2|
|Nubia Anderson|1709.96|4|
|Holly Nieves|1703.97|3|
|Inger Jennings|1699.97|3|
|Terese Briggs|1699.97|3|
|Jeffry Church|1680.99|1|
|Mila Good|1680.99|1|
|Pearl Fox|1679.95|5|
|Marissa Summers|1673.96|4|
|Mariela Huffman|1669.97|3|
|Katharine Herrera|1669.97|3|
|Geraldine O'donnell|1667.96|4|
|Ulrike Chan|1665.98|2|
|Christia Wilkins|1659.96|4|
|Onita Macdonald|1659.95|5|
|Verdell Joyner|1649.97|3|
|Barry Buckner|1649.95|5|
|Han Schneider|1639.96|4|
|Elana Miles|1639.96|4|
|Myrtie James|1639.96|4|
|Delana Wagner|1621.95|5|
|Ira Moore|1619.97|3|
|Roseanne Maynard|1619.96|4|
|Emelda Dickerson|1618.98|4|
|Mary Singleton|1616.97|3|
|Tommie Melton|1609.97|3|
|Joshua Robertson|1599.98|2|
|Davis Long|1599.97|3|
|Susannah Fields|1599.97|3|
|Augustus Schmidt|1590.98|2|
|Desire Mcgowan|1583.97|3|
|Janelle Maldonado|1581.94|6|
|Jeannie Wilcox|1578.98|3|
|Carter Booth|1573.97|3|
|Everett Vega|1569.97|3|
|Grace Madden|1568.97|4|
|Taylor Cole|1568.97|4|
|Gilma Dejesus|1549.98|2|
|Kelsey Noble|1548.98|3|
|Ethelyn Ray|1529.97|3|
|Zella Fernandez|1519.96|4|
|Jonna Brown|1499.99|1|
|Joann Barber|1499.98|2|
|Laci Castro|1499.98|2|
|Phylicia Stout|1499.98|2|
|Delana Scott|1499.98|2|
|Christopher Richardson|1499.98|2|
|Devin Shaffer|1491.97|3|
|Edith Davenport|1486.97|3|
|Alane Kennedy|1479.96|4|
|Nichelle Howell|1479.96|4|
|Julienne Moody|1479.96|4|
|Kristy Watkins|1469.99|1|
|Chloe Patel|1469.99|1|
|Romaine Haley|1469.98|2|
|Birdie Kramer|1469.97|3|
|Bart Hess|1469.97|3|
|Leslie Higgins|1469.97|3|
|Arie Hunter|1466.97|3|
|Tessie Farmer|1458.97|4|
|Philip Bryan|1449.97|3|
|Tammera Fischer|1439.96|4|
|Romaine Salazar|1437.98|4|
|Destiny Goodman|1437.98|4|
|Hope Cotton|1431.96|4|
|Greta Page|1429.97|3|
|Domingo Casey|1409.99|1|
|Jutta Everett|1409.99|1|
|Evelin Vargas|1409.95|5|
|Latricia Lindsey|1399.96|4|
|Alma Peck|1389.97|3|
|Sally Kinney|1371.97|3|
|Charise Burt|1371.96|4|
|Clementina Sargent|1369.98|2|
|Beryl Bennett|1369.97|3|
|Julee Woodard|1369.97|3|
|Zulema Browning|1369.97|3|
|Rubye Mccall|1367.99|3|
|Venessa Frost|1359.96|4|
|Romana Barnes|1349.97|3|
|Parthenia Figueroa|1349.97|3|
|Agatha Melton|1349.97|3|
|Sommer Hopkins|1347.99|3|
|Elease Dejesus|1343.96|4|
|Cami Williamson|1333.97|3|
|Shirely Cantrell|1329.97|3|
|Tangela Hurley|1329.97|3|
|Jeniffer Ratliff|1320.99|1|
|Kiesha Bond|1320.99|1|
|Patria Harper|1319.98|2|
|Martha Burgess|1319.98|2|
|Cayla Johnson|1319.98|2|
|Marcell Barrett|1303.97|3|
|Debbra Jacobson|1301.98|2|
|Yun Nelson|1299.98|2|
|Adrien Hunter|1299.97|3|
|Jessika Bray|1291.96|4|
|Tiana Henderson|1288.97|4|
|Rayford Simon|1279.98|2|
|Mechelle Chan|1273.97|3|
|Cecelia Gill|1272.98|2|
|Jaimee Day|1269.97|3|
|Phyllis Hill|1248.98|3|
|Chere Hardin|1248.98|3|
|Venus Hewitt|1218.98|3|
|Gabriella Jones|1209.98|2|
|Lakenya Oliver|1209.98|2|
|Kerrie O'neill|1199.98|2|
|Leeanne Cross|1199.98|2|
|Nathaniel Davidson|1199.98|2|
|Mellisa Farley|1199.98|2|
|Doreatha Ford|1199.98|2|
|Chasidy Webster|1199.98|2|
|Alec Peck|1199.98|2|
|Allie Conley|1199.98|2|
|Tomika Larson|1199.98|2|
|Suellen Mercado|1199.98|2|
|Chere Alston|1199.96|4|
|Diana Reyes|1182.98|2|
|Daphine Willis|1159.98|2|
|Alanna Barry|1157.99|3|
|Tilda Melton|1143.97|3|
|Tisha Petty|1139.97|3|
|Sebrina Gross|1139.97|3|
|Angele Castro|1139.97|3|
|Patsy Russo|1139.97|3|
|Lanelle Guerra|1139.96|4|
|Arlena Buckner|1139.96|4|
|Cherelle Key|1139.96|4|
|Zenia Bruce|1119.98|2|
|Treasa Dickerson|1111.98|2|
|Ayanna Rhodes|1109.96|4|
|Virgil Frost|1103.98|2|
|Grisel Maynard|1099.99|1|
|Edmund Gaines|1099.98|2|
|Arminda Weber|1099.98|2|
|Amparo Burks|1099.98|2|
|Christel Cardenas|1099.98|2|
|Katheleen Marks|1099.98|2|
|Lezlie Thompson|1099.98|2|
|Lecia Hancock|1099.98|2|
|Joy Underwood|1099.98|2|
|Mandi Gibbs|1099.98|2|
|Trena Rogers|1099.98|2|
|Tania Swanson|1099.98|2|
|Jewell Reyes|1099.96|4|
|Rodrigo Durham|1091.97|3|
|Johana Jacobson|1089.97|3|
|Morton Barron|1079.98|2|
|Kermit Hyde|1078.97|4|
|Jeanett Herman|1069.97|3|
|Jenna Saunders|1067.98|2|
|Susann Bass|1067.97|3|
|Kandace Hughes|1059.98|2|
|Nicki Fry|1059.98|2|
|Christoper Gould|1059.98|2|
|Edgar Horn|1059.98|2|
|Lucilla Williams|1039.97|3|
|Katina Mcintosh|1028.99|2|
|Ben Stone|1009.97|3|
|Berna Moore|999.99|1|
|Almeta Benjamin|999.99|1|
|Hue Dalton|999.99|1|
|Sandee Alvarado|999.99|1|
|Delaine Estes|999.98|2|
|Kandis Mills|999.98|2|
|Mariette Trevino|999.98|2|
|Magdalena Sherman|998.99|2|
|Kiara Deleon|988.98|3|
|Stephen Vega|983.97|3|
|Wm Pope|979.98|2|
|Valery Saunders|968.98|3|
|Kristen Alvarez|968.98|3|
|Kylee Dickson|949.98|2|
|Lavinia Cotton|941.98|2|
|Collin Webster|940.98|2|
|Alysha Powers|939.98|2|
|Angele Schroeder|939.98|2|
|Berneice Pollard|939.98|2|
|Leif Short|939.98|2|
|Lena Mills|939.98|2|
|Jenise Preston|939.98|2|
|Marcy Rodriguez|939.98|2|
|Willian Hardin|939.98|2|
|Thalia Horne|909.98|2|
|Sherita Cherry|899.98|2|
|Lizette Ellison|899.98|2|
|Keitha Black|899.98|2|
|Cindi Ellis|899.98|2|
|Antonetta Rocha|898.00|2|
|Heather Perry|898.00|2|
|Molly Langley|875.99|1|
|Randee Lester|875.99|1|
|Anton Barton|858.00|2|
|Yang Roth|858.00|2|
|Bernetta Summers|849.98|2|
|Ashlie Parrish|819.98|2|
|Alane Mccarty|809.97|3|
|Lynn Mcmahon|809.97|3|
|Klara Mosley|809.97|3|
|Lea Irwin|809.97|3|
|Jerome Bolton|809.97|3|
|Sylvester Chan|809.97|3|
|Trisha Johnson|799.98|2|
|Shonta Mercer|761.99|1|
|Magda Eaton|761.99|1|
|Giselle Robles|761.98|2|
|Piedad Irwin|759.98|2|
|Lonna Franks|749.99|1|
|Johna Powers|749.99|1|
|Carola Johns|749.99|1|
|Vance Taylor|749.99|1|
|Whitney Estes|749.99|1|
|Tony Hicks|749.99|1|
|Jennette Baker|729.97|3|
|Cassidy Clark|726.97|3|
|Eun Harris|718.99|2|
|Jenine Crane|718.99|2|
|Marylyn Browning|718.99|2|
|Starr Schneider|718.99|2|
|Hayden Cross|709.97|3|
|Ciera Webb|699.98|2|
|Bettyann Acosta|679.98|2|
|Obdulia Barber|679.98|2|
|Leola Gould|659.99|1|
|Georgeanna Webster|659.99|1|
|Mia Delgado|659.98|2|
|Augustus Steele|649.98|2|
|Tara Maynard|639.98|2|
|Lise Alvarado|626.98|2|
|Kristel Bullock|599.99|1|
|Burma Summers|599.99|1|
|Erlinda Osborne|599.99|1|
|Elmo Arnold|599.99|1|
|Wallace Lane|599.99|1|
|Karren Lamb|599.98|2|
|Jasper Castro|599.98|2|
|Nicki Larson|599.98|2|
|Jina Cooper|569.98|2|
|Lekisha Pope|559.98|2|
|Sheree Blanchard|559.98|2|
|Janella Bright|551.99|1|
|Jenell Crosby|551.99|1|
|Jenny Bell|549.99|1|
|Dione Pratt|549.99|1|
|Serafina Clemons|549.99|1|
|Jacalyn Barnett|539.99|1|
|Jayme Zamora|539.98|2|
|Margene Eaton|539.98|2|
|Gabriel Pitts|539.98|2|
|Gayle Wilkinson|539.98|2|
|Brent Calderon|539.98|2|
|Carroll Kelly|539.98|2|
|Charlsie Carson|539.98|2|
|Benny Bender|539.98|2|
|Whitney Cash|539.98|2|
|Vanessa West|539.98|2|
|Taisha Vang|539.98|2|
|Zulema Clemons|539.98|2|
|Shanelle Anderson|533.99|1|
|Rozella Fitzgerald|533.99|1|
|Wes Stanton|529.99|1|
|Desiree Branch|501.98|2|
|Loni Mullen|501.98|2|
|Bryce Monroe|499.99|1|
|Twana Arnold|499.99|1|
|Terese Palmer|499.99|1|
|Rosalba O'neal|499.99|1|
|Ashely Holmes|489.99|1|
|Hye Mercer|489.99|1|
|Jennell Solis|489.99|1|
|Ramiro Byers|470.99|1|
|Merlin Foreman|469.99|1|
|Maribel William|469.99|1|
|Joni Lee|469.99|1|
|George Pickett|469.99|1|
|Aleta Stone|449.99|1|
|Inga Koch|449.99|1|
|Jennette Wooten|449.00|1|
|Erlene Cook|449.00|1|
|Corene Swanson|449.00|1|
|Douglas Richards|439.99|1|
|Mikel Wilkerson|439.99|1|
|Laverne Craft|429.00|1|
|Diana Cobb|429.00|1|
|Eldridge Greer|429.00|1|
|Ulysses Gaines|429.00|1|
|Giovanna Jefferson|419.98|2|
|Cassandra Nichols|419.98|2|
|Leland Mcdowell|419.98|2|
|Jeni Farley|419.98|2|
|Phillis Fowler|419.98|2|
|Nathanael Bradley|419.98|2|
|Carola Mcpherson|416.99|1|
|Angelique Merrill|416.99|1|
|Glady Wells|349.99|1|
|Deangelo Cooley|349.99|1|
|Narcisa Knapp|349.99|1|
|Mica Barry|349.99|1|
|Jamika Acevedo|299.99|1|
|Jerald Blackwell|299.99|1|
|Joe Melton|299.99|1|
|Cassondra Pruitt|299.99|1|
|Vernita Ball|299.99|1|
|Tanesha Sawyer|299.99|1|
|Tona Velasquez|269.99|1|
|Senaida Thompson|269.99|1|
|Shaunda Barnett|269.99|1|
|Clarita Curry|269.99|1|
|Alane Munoz|269.99|1|
|Hans Price|269.99|1|
|Kaci Gallegos|269.99|1|
|Junita Reese|269.99|1|
|Lilliam Nolan|269.99|1|
|Launa Hull|269.99|1|
|Kanesha Hudson|250.99|1|
|Clementine Mooney|249.99|1|
|Britteny Schroeder|249.99|1|
|Antony Atkinson|219.98|2|
|Luciana Mcgee|209.99|1|
|Lloyd Miranda|189.99|1|
|Caroline Jenkins|189.99|1|
|Carissa Foreman|189.99|1|
|Sonja Walls|189.99|1|
|Stephanie Browning|109.99|1|

<br>
<br>
