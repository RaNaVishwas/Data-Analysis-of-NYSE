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

 qqnorm(stk_mkt2)
qqline(stk_mkt2, col=3)

normalTest(stk_mkt2,method=c("jb"))

Ljung box test command command(serial correlation)
Box.test(stk_mkt2,lag=12,type = 'Ljung')

ACF and PACF command to find P and Q value for AR and MA model
pacf(coredata(stk_mkt2), lag=15)
acf(coredata(stk_mkt2), lag=15)


AR model 
AR=arima(stk_mkt2,order=c(10,0,0), method = 'ML',include.mean = T)
AR

MA model 
MA=arima(stk_mkt2,order=c(0,0,11), method = 'ML',include.mean = T)
MA
AUTOARIMA model 
AutoArima=auto.arima(stk_mkt2)
AutoArima

Residual analysis commands for AR , MA and AUTOARIMA model
Plot(AR$residuals)
Box.test(AR$residuals, lag=6,type="Ljung")
Box.test(AR$residuals, lag=12,type="Ljung")
Box.test(AR$residuals, lag=18,type="Ljung")

Plot(MA$residuals)
Box.test(MA$residuals, lag=6,type="Ljung")
Box.test(MA$residuals, lag=12,type="Ljung")
Box.test(MA$residuals, lag=18,type="Ljung")

Plot(AutoArima$residuals)
Box.test(AutoArima$residuals, lag=6,type="Ljung") 
Box.test(AutoArima$residuals, lag=12,type="Ljung")
Box.test(AutoArima$residuals, lag=18,type="Ljung")

Applied reverse differencing and test the testing data for December 2016
ARMAFIT=auto.arima(stk_mkt2,d=2,approximation=FALSE, trace=FALSE)
ZOpen=predict(ARMAFIT,n.ahead=1,se.fit=T)

Accuracy of AR,MA and AutoArima models(RMSE value)
accuracy(AR)
accuracy(MA)
accuracy(AutoArima)


Using RMSE as a metrics  AutoArima is the best model and used for prediction.

Applied AutoArima model for future 21 months open price prediction
ARMAFIT=auto.arima(stk_mkt2,d=2,approximation=FALSE, trace=FALSE)
ZOpen=predict(ARMAFIT,n.ahead=21,se.fit=T)



AUTOARIMA model and its reverse differencing prediction commands for High price column in dataset
ARMAFIT1=auto.arima(stk_mkt,d=2,approximation=FALSE,trace=FALSE)
ZHigh=predict(ARMAFIT1,n.ahead = 21, se.fit = T)
ZHigh	



Forecast command for AutoArima model
a1=auto.arima(stk_mkt2)
fr=forecast(a1)
 plot(fr)

