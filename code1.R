



setwd('~/data_analysis/repo/peer2/')

library('base')
library('methods')
library('utils')
library('graphics')
library('bitops')
library('rmarkdown')
library('httr')
library('RCurl')

datafile='./StormData.csv.bz2'
download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2', datafile,method = 'curl')
download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf','./NWS_StormDataDocuments.pdf', method = 'curl')
download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf','./NCDCStormEventFAQ.pdf',method='curl')

#Scan the data to get a handle on what is really in there.  This will help determine what columns to read in, and types for those columns
scan(datafile,nlines=2,sep=',',what='character')

#'F' column occurs as a string in the csv file and is a catagory.  So it is read in as a factor.
#'BGN_DATE' is the data of the event.  Read in a type character, then convert to type Date
#Specify the desired columns and each type
speclass<-c('NULL','character', rep('NULL',4), 'factor', 'factor',rep('NULL',12),'factor',rep('numeric',4),'factor','numeric','factor',rep('NULL',9))

#Readin the desired columns 
storms<-read.csv(datafile, header = TRUE, colClasses=speclass,strip.white = TRUE)

#Convert the event date column to Date type
storms$BGN_DATE<-as.Date(data$BGN_DATE,format="%m/%d/%Y %T")

#
propexp<-c(levels(storms$PROPDMGEXP))
sumset<-function(b,x){
        sum(b==x)
}

propexpcount<-lapply(storms$PROPDMGEXP,sumset,x=propexp)
