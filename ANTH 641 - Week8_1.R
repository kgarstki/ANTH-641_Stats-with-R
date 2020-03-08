# ANTH 641 Week 8 Exercise 1 - (Re)analysis with R

# We will conduct a very basic introduction to archaeological statistical analysis using R. 
# This is by no means an end point for either stats in archaeology OR R. You'll explore some of 
# the possibilities for analysis using R with archaeological data, but as you progress in research you'll 
# need to explore more. 

# Luckily for us there is a package in CRAN that contains several types of archaeological data that we can learn with.
# The "archdata" package was created by David L. Carlson and Georg Roth to accompany 
# "Quantitative Methods in Archaeology Using R" by David L. Carlson (2017). 

# If you have no background in stats, it may be helpful to look through the documentation in this week's GitHub repo.
# Even if you have a background, you may need a refresher. Before you get started, load some packages into R.

install.packages("archdata")
library(archdata)
install.packages("RcmdrMisc")
library(RcmdrMisc)

# Descriptive statistics try to describe a distribution in terms of some numeric values. These include things like
# central tendancy (think mean and median) or dispersion or spread (think standard deviation or variance).
# Before we start using a dataset, it is imporant to understand the distribution of values - let's work on how we do that.
# 1. Bring the dataframe "DartPoints" in. Take a look at the info on the archdata package, and read about "DartPoints."
data(DartPoints)
View(DartPoints)

# 2. There are different ways to compute a statistic describing a certain value from a dataframe.  
# We're going to look at Length. BUT NOTE that we can't just use "meand(Length)" as a command because that variable doesn't exist. 
mean(DartPoints$Length) 
mean(DartPoints[, 5])
mean(DartPoints[,"Length"])

# 3. But you don't want to compute statistics individually, 
# so we can use some commands to give us summaries of descriptive statistics.
summary(DartPoints$Length)
# By looking at the mean and median, we can see that the distribution is skewed right 
# since the median is lower than the mean. 

# 4. We can also try to look at summaries of all the numeric variables at once. We first set our significant digits to 3.
# Then we tell R to show the statistics of columns 5 through 11 in the dataframe.
options(digits=3)
numSummary(DartPoints[, 5:11])
# 5. Write out an patterns you notice in a new Markdown file in your GitHup repo for this week. 
# 6. Now try summarize the statistics for another dataset in archdata, your choice! Descibe what you chose in your .md file.  


# Looking at data with Tables - Tables are a two-dimensional presentation of data. R distinguishes between dataframes and tables.
# We can create simple tables to help us understand more complex data existing in a data frame. Specifically, since Tables
# are only numeric, we can use them to summarize categorical data.
# 1. Make sure the DartPoints dataset is brought into R and set significant digits to 3. 
data(DartPoints)
options(digits=3)
# 2. There are five types of points in this dataset. Let's look at how many of each are in the sample, creating a new table.
# Note: using paranthesis around the whole command "prints" the command - the table will come up immediately rather than
# having to call it up again.
(DP_Type <- table(DartPoints$Name))
# 3. We can also look at the Name by proportion of the whole. 
prop.table(DP_Type)*100

# 4. Let's try looking how categorical variables may relate to eachother by creating a cross-tabulation. 
# We'll look at point type and shape of the blade (Blade.Sh)
(DP_CT <- xtabs(~Name+Blade.Sh, DartPoints))
# Cool, but let's also see how each variables sums. The "addmargins" command creates a new row and column of the sums.
addmargins(DP_CT)
# But we're missing two values, since it only sums to 89 rather than the sample size of 91. We can look at missing values. 
addmargins(xtabs(~Name+addNA(Blade.Sh), DartPoints))


# Looking at data with Graphs - Often, graphs provide us with a good summary of data and can help illuminate patterns. 
# 1. We're going to look at two ways to visualize the number of coils present on La Tène fibulae 
# from the Iron Age cemetery of Münsingen near Berne, Switzerland. Bring the dataframe into your directory. 
data(Fibulae)
View(Fibulae)
# We're interested in the variable "Coils"
(Fib_coils <- table(Fibulae$Coils))
# 2. First we'll make a pie chart of the number of coils. We'll include a main title and title our variable. 
pie(Fib_coils, main="La Tene Bronze Fibulae", xlab="Number of Coils", clockwise=TRUE)
# Beautiful! Remember to export the graph as image and upload it to your GitHub. 

# 3. Let's compare it to a barplot of the same data. 
barplot(Fib_coils, main="La Tene Bronze Fibulae", xlab="Number of Coils", ylab="Number of Fibulae")
# Export that graph, as well. Which way to visualize the data is more helpful? 

# 4. We'll try one more graph, using more complex data. First bring the dataframe Pithouses into the directory. 
# This includes the desription of 45 Arctic Norway pithouses with 6 categorical variables. 
data(PitHouses)

# 5 Then we'll create a cross-tabulation of Hearths with Size
(PitHouses.tbl <- xtabs(~Hearths+Size, PitHouses))

# 6. Then create a barplot of the crosstab. We'll include a legend that describes are different Hearths.
# Remember to export the grab when you're done. 
barplot(PitHouses.tbl, ylab="Frequency", main="Arctic Norway Pithouses", beside=TRUE,legend.text=TRUE, args.legend=list(title="Hearths"))

# 7. Find a new dataset from the archdata package. Use one of these two create a graph of the data. 
# You can use a scatterplot (plot), a bargraph (barplot), pie chart (pie), or boxplot (boxplot). 

# Principle Components Analysis - If you're unfamilar, read the short background on PCA in your GitHub. 
# You'll often see PCA biplots in archaeology to identify clustering of artifact groups - this often occurs 
# with different types of compositional or residue analysis, where you have many different variables.

# 1. We'll use the data (RBGlass1) that shows the concentrations of 11 major and minor elements found in 
# Romano-British glass from two sites: Leicester and Mancetter). We want to see if there are distinct clustering 
# based on the samples from different sites, which may provide insight into the production processes at each. 
data("RBGlass1")
View("RBGlass1")

# 2. We'll create a new variabe called RBGlass1.pca that is our principle components analysis.
# Note: we use the command [,-1] to remove the first column of our dataframe from the analysis, since this is the site name.
# We see 11 components because there were 11 element variables in our dataset. 
(RBGlass1.pca <- prcomp(RBGlass1[, -1], scale.=TRUE))
# We can also see which components provide the greatest amount of variance or correlation. 
summary(RBGlass1.pca)

# 3. Now plot our pca of the elements and what do we see? Even if you don't understand everything on the plot, 
# do you notice any patterns? Remember to export and save the image. 
biplot(RBGlass1.pca, xlabs=abbreviate(RBGlass1$Site, 1), cex=.75)
