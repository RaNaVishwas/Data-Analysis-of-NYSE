Building Prediction Model For New York Stock Exchange
Group 116
First name	Last Name 	Monday or Tuesday class
Mallikarjuna	Sirabadige Nagaraju	Monday
Vishwas	Reddy Naga	Monday


Libraries used in the Project
library(fBasics)
library(tseries)
library(forecast)
library(zoo)
library(dplyr)
library(BSDA)
library(psych)

Monthly Aggregated YAHOO stocks data
Command to read the data  from YAHOO csv file
data <-read.csv("YAHOO.csv",header=T,sep=',')

Monthly Aggregated YAHOO stocks data
Command to read the data  from YAHOO csv file
data <-read.csv("YAHOO.csv",header=T,sep=',')
 
Hypothesis testing commands by taking 10% as sample data
 x=data$open
 opendata=data%>%sample_frac(0.1)
open=opendata$open
z.test(open,NULL,alternative="less",mu=27,sigma.x=sd(open),conf.level=.95)



Time series object creation and its plot command 
We are taking data upto November 2016 and We kept December 2016 data as testing data.
stk_mkt=ts(data[,3],start=c(2010,1), end=c(2016,11),frequency = 12)
plot(stk_mkt)

1st Differencing of time series object commands
stk_mkt1=diff(stk_mkt)
plot(stk_mkt1)
Box.test(stk_mkt1,lag=6,type = 'Ljung')
Box.test(stk_mkt1,lag=12,type = 'Ljung')
2nd Differencing of time series object commands
stk_mkt2=diff(stk_mkt1)
plot(stk_mkt2)
Box.test(stk_mkt2,lag=6,type = 'Ljung')
Box.test(stk_mkt2,lag=12,type = 'Ljung')

Model creation of AR , MA and AutoArima model for close price column in data set

basicStats(stk_mkt2)
Histogram ,QQplot and Jarque-Bera Test commad
hist(stk_mkt2, xlab="Yahoo close value", prob=TRUE, main="Histogram")
xfit<-seq(min(stk_mkt2),max(stk_mkt2),length=40)
yfit<-dnorm(xfit,mean=mean(stk_mkt2),sd=sd(stk_mkt2))
 lines(xfit, yfit, col="blue", lwd=2)
