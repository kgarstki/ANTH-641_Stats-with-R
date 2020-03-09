# ANTH 641 Week 8 Exercise 2 – Using R with data from outside sources 

For your final project you’ll be gathering data from archives or published sources. You then may want to bring those data into R to perform some analyses on them. This exercise will give you some experience going through the whole process of gathering data from Open Context and doing something with it in R. We have a research question about the glass found at the site of Etruscan site of Poggio Civitate: were different types of glass objects deposited in different parts of the site? If so, what can this tell us about the use of those areas and the people who experienced and passed through those spaces? 

## Exporting Data

1. Go to the [Project Murlo: Poggio Civitate Excavation Project](https://opencontext.org/projects/DF043419-F23B-41DA-7E4D-EE52AF22F92F) on Open Context. Read through the project description of the site – it’s always good to know the context of the data you’re working with! 

2. Click on the __Data Records__ dropdown menu and choose __Glass__.

3. On the next page with the Glass search results, click on __Export or Map Records__. 

4. Export this data as a Table (csv) and save to file as “Murlo_glass.”

## Altering the Data

We now have a data table of all of the glass found in Poggio Civitate. For our purposes, we are interested in only part of the data found in this table. REMEMBER, when you’re manipulated data in any way, make sure you work off of a duplicated copy so that the original data remains in tack (just in case you mess up). We’re going to use Excel to simplify our dataset, and then bring the table into OpenRefine to clean some things up. 

1. Open your Murlo_glass.csv file in Excel. We are going to simplify the table by removing some columns (many of them). Delete all of the columns EXCEPT: Item Label, Context (3), Context (4), Has type, Object Type, Fabric Description, Object Type (notes). 

2. We need to also simplify our column headers for when we bring it into R. Change Context (3) to __Context__; Context (4) to __Context_sp__; Has type to __Type__; Object Type to __Type_2__; Fabric description to __Fabric__; Object Type (notes) to __Notes__. Save your .csv. 

2. Bring your Murlo_glass.csv into OpenRefine. We’re going to focus on two columns for right now, Context and Type. First, look go to the dropdown for Context and choose Facet > Text facet. Check to make sure there are no misspellings or extra spaces that need to be adjusted. Next do the same with Type. In here, we will edit a few cells to make things more standard for us. One cell has the words _vessel; aryballoi; Aryballos; aryballos_ – this is too specific for us at the moment – edit the cell so it just says “vessel.” Then edit the two cells that have the words “production/replication” to just “production.”
3. Export this from OpenRefine as “Murlo_glass1.csv”