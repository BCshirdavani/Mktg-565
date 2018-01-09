# Marketing 565
# Data Driven Marketing
# Churn Analysis - using logistic regression


#  Load the .sav (spss) data file into R
install.packages('haven')
library(haven)
# code for iMac
#Cell_Data <- read_sav("Documents/MBA/Mktg 565/Project/Cell2Cell_SPSS_Data.sav")
# code for MacBook
Cell_Data <- read_sav("/Users/shymacbook/Documents/R/Mktg-565/Cell2Cell_SPSS_Data.sav")

#  summarize the data
summary(Cell_Data)

#  view the structure of the data
str(Cell_Data)
#  identify columns that are not useful
Worthless <- c("INCMISS","SETPRCM","CHURNDEP")
#  identify column that we want to predict
Y_dependent <- "CHURN"
#  identify profitability metrics that we want to maximize
Profit_metrics <- c("REVENUE","REFER")

#  preview the data
Columns <- colnames(Cell_Data)
ColSize <- length(Columns)
RowSize <- row(Cell_Data)
head(Cell_Data)[,1:10]
head(Cell_Data)[,11:20]
head(Cell_Data)[,21:30]
head(Cell_Data)[,31:40]
head(Cell_Data)[,41:50]
head(Cell_Data)[,51:60]
head(Cell_Data)[,61:70]
head(Cell_Data)[,71:ColSize]

# Find missing data "NA" by columns
MissingReport <- data.frame(Columns,x)
colnames(MissingReport) <- c("Columns","NA_Count")

#  clean the data (remove any rows with NA column values)
Cell_naOMIT <- na.omit(Cell_Data)

# we now have 38941 rows rather than 71047 rows...we lost 32106 rows
71047 - 38941
# double check to see if this is the correct amount of rows to delete
# .... this code takes too long to run.
#  But as I stopped it early on, i noticed that the column 78 CHURNDEP
#  had almost all of the NA's
#     This CHURNDEP was the variable that is to separate our test set
#     with the validation set
'''
BadRows <- rep(0,71047)
ColBadCount <- data.frame(colnames(Cell_Data),rep(0,78))
colnames(ColBadCount) <- c("colNames","countNA")
for (i in 1:71048){
   #print(i)
   for (j in 1:78){
      x <- Cell_Data[i,j]
      if (is.na(x)){
         BadRows[i] <- 1
         ColBadCount$countNA[j] = ColBadCount$countNA[j] +1
      }
   }
}
'''
# double check validation vs. calibration sample
Cell_Data$CALIBRAT[1:10]
Cell_Data$CHURNDEP[1:10]
table(Cell_Data[,c(77,78)],exclude=NULL)

# examine the CHURNDEP and CHURN columns
summary(Cell_Data$CHURNDEP)
hist(Cell_Data$CHURNDEP)
table(Cell_Data$CHURNDEP)
table(Cell_Data$CHURN)

sum(is.na(Cell_Data[,1]))
sum(is.na(Cell_Data$CHURNDEP))

x <- rep(0,ColSize)
for (i in 1:ColSize){
  x[i] <- sum(is.na(Cell_Data[,i]))
  print(x)
}








'''
hist(Cell2Cell_SPSS_Data$REVENUE)
hist(Cell2Cell_SPSS_Data$OVERAGE)
hist(Cell2Cell_SPSS_Data$CHURN)
plot(Cell2Cell_SPSS_Data$OVERAGE, Cell2Cell_SPSS_Data$REVENUE)






library(ggplot2)
?qplot()
qplot(Cell2Cell_SPSS_Data, Cell2Cell_SPSS_Data)
qplot(data=diamonds,carat,price,colour=clarity,facets=.~clarity)
qplot(data=Cell2Cell_SPSS_Data, DROPVCE, REVENUE, color = CHURN, alpha=.3)
'''