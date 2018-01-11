# Marketing 565
# Data Driven Marketing
# Churn Analysis - using logistic regression


#  Load the .sav (spss) data file into R
install.packages('reshape2')
install.packages('plotly')
install.packages('tabplot')
install.packages('dplyr')
install.packages('Amelia')
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
Worthless <- c("INCMISS","SETPRCM","CHURNDEP","CSA")
DropColIndex <- match(Worthless,colnames(Cell_Data))
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
x <- rep(0,ColSize)
for (i in 1:ColSize){
  x[i] <- sum(is.na(Cell_Data[,i]))
  print(x)
}
MissingReport <- data.frame(Columns,x)
colnames(MissingReport) <- c("Columns","NA_Count")
MissingReport

# Separate the Training Set and Validation Set
# double check validation vs. calibration sample
table(Cell_Data[,c(77,78)],exclude=NULL)
table(Cell_Data[,c(77,22)],exclude=NULL)

# Make Training Set
Training <- Cell_Data[Cell_Data$CALIBRAT == 0,-DropColIndex]

# Make Test Set
Test <- Cell_Data[Cell_Data$CALIBRAT == 1,-DropColIndex]
# Double Check the results
summary(Test)
summary(Training)
str(Test)
str(Training)


#  clean the data (remove any rows with NA column values)
#Cell_naOMIT <- na.omit(Cell_Data)
library(Amelia)
missmap(Training, main = "Missing values vs observed")

ColSizeTrain <- length(colnames(Training))
x <- rep(0,ColSizeTrain)
for (i in 1:ColSizeTrain){
  x[i] <- sum(is.na(Training[,i]))
  print(x)
}
MissingReportTrain <- data.frame(colnames(Training),x)
colnames(MissingReportTrain) <- c("Columns","NA_Count")
MissingReportTrain
Clean_Train <- na.omit(Training)
#count of lost rows after removing NA's
31047-30368



# Exploratory data analysis on the Training Set
pairs(Clean_Train[,1:3])
cor(Clean_Train[,1:ColSizeTrain])
cor(Clean_Train[,1:10])

# randomly sample 1000 rows for scatter plot matrix
# for quicker plotting
library(dplyr)
library(tabplot)
library(ggplot2)
Train_samp1000 <- sample_n(Training,1000)
pairs(Train_samp1000[,1:74])
tableplot(Train_samp1000)

par(mfrow=c(2,1))
boxplot(Train_samp1000$OVERAGE,Train_samp1000$CHURN)
plot(Train_samp1000$OVERAGE,Train_samp1000$CHURN)
hist(Train_samp1000$REVENUE)

hp <- ggplot(tips, aes(x=total_bill)) + geom_histogram(binwidth=2,colour="white")

hp <- ggplot(Training, aes(x=OVERAGE)) + geom_histogram(binwidth=10,colour="black")
hp + facet_grid(CHURN ~ .)
hist(Training$OVERAGE[Train_samp1000$CHURN==0])
hist(Training$OVERAGE[Train_samp1000$CHURN==1])

# try putting box plots or histograms on the SAME plot, so they sahre the SAME axis











