# ANTH 641 Week 8 Exercise 2 – Using R with data from outside sources 

For your final project you’ll be gathering data from archives or published sources. You then may want to bring those data into R to perform some analyses on them. This exercise will give you some experience going through the whole process of gathering data from Open Context and doing something with it in R. We have a research question about the glass found at the site of Etruscan site of Poggio Civitate: were different types of glass objects deposited in different parts of the site? If so, what can this tell us about the use of those areas and the people who experienced and passed through those spaces? 

## Exporting Data

1. Go to the [Project Murlo: Poggio Civitate Excavation Project](https://opencontext.org/projects/DF043419-F23B-41DA-7E4D-EE52AF22F92F) on Open Context. Read through the project description of the site – it’s always good to know the context of the data you’re working with! 

2. Click on the __Data Records__ dropdown menu and choose __Glass__.
![alt text](https://github.com/kgarstki/ANTH-641_Stats-with-R/blob/master/Images/Image1.png)

3. On the next page with the Glass search results, click on __Export or Map Records__. 

![alt text](https://github.com/kgarstki/ANTH-641_Stats-with-R/blob/master/Images/Image2.png)
4. Export this data as a Table (csv) and save to file as “Murlo_glass.”

## Altering the Data

We now have a data table of all of the glass found in Poggio Civitate. For our purposes we are interested in only part of the data found in this table. REMEMBER, when you’re manipulating data in any way, make sure you work off of a duplicated copy so that the original data remains intact (just in case you mess up). We’re going to use Excel to simplify our dataset, and then bring the table into OpenRefine to clean some things up. 

1. Open your Murlo_glass.csv file in Excel. We are going to simplify the table by removing some columns (many of them). Delete all of the columns EXCEPT: Item Label, Context (3), Context (4), Has type, Object Type, Fabric Description, Object Type (notes). 

2. We need to also simplify our column headers for when we bring it into R. Change Context (3) to __Context__; Context (4) to __Context_sp__; Has type to __Type__; Object Type to __Type_2__; Fabric description to __Fabric__; Object Type (notes) to __Notes__. Save your .csv. 

2. Bring your Murlo_glass.csv into OpenRefine. We’re going to focus on two columns for right now, Context and Type. First, look go to the dropdown for Context and choose Facet > Text facet. Check to make sure there are no misspellings or extra spaces that need to be adjusted. Next do the same with Type. In here, we will edit a few cells to make things more standard for us. One cell has the words _vessel; aryballoi; Aryballos; aryballos_ – this is too specific for us at the moment – edit the cell so it just says “vessel.” Then edit the two cells that have the words “production/replication” to just “production.”

3. Export this from OpenRefine as “Murlo_glass1.csv”

## Using the Data in R

1. Time to bring this data table into R. Open your Rstudio application. Make sure your csv file is in the directory set in Rstudio. To bring in a .csv to R, use: 
`Murlo_glass <- read.csv("Murlo_glass1.csv", header=TRUE, sep=",")` 

The “header=TRUE” keeps the column headers you have in your table and the “sep=”,” identifies that the commas in the file separate values. 
Then view your dataframe to make sure it imported okay: `View(Murlo_glass)`

2. Now, we’re interested in the types of glass found in different locations at the Poggio Civitate site, so let’s make a cross-tabulation of the Type and Context. 

`(Glasstab <- xtabs(~Type+Context, Murlo_glass))`

This shows us how many of the five types of glass are found at each of the 9 locations (including Unrecorded). 

3. We can visualize this crosstab in a graph. 

`barplot(Glasstab, ylab="Number of fragments", main="Glass found in Poggio Civitate", legend.text = TRUE, args.legend = list(x="topleft"))`

4. What patterns do you notice? How would you go about interrogating these patterns further? Discuss this in your blog post. 

5. One final thing we could do with these two categorical variables are to see if they are related in some way (significantly co-occurring). Basically, are the two variables independent or can we “predict” one based on the other? In this case we might wonder if the higher numbers of glass found in one location is a meaningful pattern or if has occurred by more or less random deposition? We can compute a Chi-square to test if the data confirms our null hypothesis that they are independent variables or if we have reason to doubt the null hypothesis. 

`murlo.chi <- chisq.test(Glasstab)`

`murlo.chi`

We want to look at our “p-value” calculated here. The general rule is that if the p-value is over 0.05 than there is no reason to doubt these variables are independent, if it is below 0.05 than you have reason to reject the null hypothesis. What is the p-value? What does that lead you to believe? 

__A final note on this__: there are a number of problems with this sample that leads us to doubt the chi-squared. First, some values are very very small, which can skew the calculation. One step to take is to run a simulation with thousands of randomly generated tables with the same marginal values as ours – this may help a little.  

`set.seed(*random number here*)`

`chisq.test(Glasstab, simulate.p.value=TRUE)`

However, one of the main problems is that we are not including zero values for locations on the excavations where glass had never been found. The only areas of Poggio Civitate that are included in this data table are those where at least one piece (of any type) of glass was found. We’re immediately biasing our data. Perhaps with those extra “zeros” the relationship between the variables (Type and Context) would be significant. This is why we ALWAYS interrogate any statistical analysis on archaeological data – there are many places for misuse or bias. 

