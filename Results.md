# Data Analysis Results

### Tools
* Excel
* SQL Server / SQL Server Management Studio (SSMS)
* Tableau

---

### Skills Demonstrated
* Data Analysis Process:
    * Prepare
    * Process
    * Analyze
    * Share
* Data analysis using SQL and Excel
* Interactive and dynamic Dashboards in Tableau and Excel

---

### Prepare
* Collect and gather the relevant data
* Validate data integrity
    * Data Source: First-party open data
* Understand table relationships
    * <img src = "img/Database-Diagram.png" width = "650" height = "400">
* Consolidate relevant data into one table
    * Combined data from 8 different tables

---

### Consolidate all the necessary data using SQL
View SQL script [here](Solutions-SQL-Scripts/Consolidate-Data.sql)

---

### Exploratory Data Analysis Questions
* By asking questions that are Specific, Measurable, Action-Oriented, Relevant, and Time-bound we can answer the business task
    * Revenue per store?
    * A list of top sales rep?
    * Revenue per product category?
    * Revenue per brand?
    * Revenue per region?
    * A list of top customers?
* <img src = "img/KPI.png" width = "650" height = "400">
---

### Exploratory Data Analysis Answers
View SQL script [here](Solutions-SQL-Scripts/Business-Task.sql)

---

### Revenue per store?
|state|store_name|revenue|
|---|---|---|
|NY|Baldwin Bikes|5826242.21|
|CA|Santa Cruz Bikes|1790145.91|
|TX|Rowlett Bikes|962600.76|

---

### A list of top sales rep?
|sales_rep|revenue|total_units_sold|
|---|---|---|
|Marcelene Boyer|2938888.73|2419
|Venita Daniel|2887353.48|2360
|Genna Serrano|952722.26|831
|Mireya Copeland|837423.65|685
|Kali Vargas|516695.17|412
|Layla Terrell|445905.59|371

---

### Revenue per product category?
|category_name|revenue|
|---|---|
|Mountain Bikes|3030775.71|
|Road Bikes|1852555.60|
|Cruisers Bicycles|1109151.04|
|Electric Bikes|1020236.85|
|Cyclocross Bicycles|799874.60|
|Comfort Bicycles|438506.87|
|Children Bicycles|327888.21|

---

### Revenue per brand?
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

---

### Revenue per region?
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


---

### A list of top customers?
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
