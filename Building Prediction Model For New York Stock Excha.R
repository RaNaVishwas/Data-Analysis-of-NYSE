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

