# List of packages to load
lib <-c(
#  "tidyverse",
  "lubridate",
  "readr",
  "ggplot2",
  "readxl"
  )

# Load packages
for (item in lib){
  if (!require(item,character.only=TRUE)){
    install.packages(item)
    library(item,character.only = TRUE)
  }else{
    library(item,character.only = TRUE)
  }
}

# Import data
acled <- read_csv("./02221-Lab7/acled-2015-2018.csv")

# Examine data
acled
summary(acled)
head(acled)
tail(acled)
# acled[1,1]
# acled[,1]
# acled[1,]
# acled[1:3,]
# acled[c(1,5,7,9),]
# acled[c(1,5,7,9,10:14),]
# acled$FATALITIES
# acled$FATALITIES > 400
# acled[acled$FATALITIES > 400,]
length(acled[acled$FATALITIES > 400,])
# table(acled$EVENT_TYPE)
# sort(table(acled$EVENT_TYPE))
sort(table(acled$COUNTRY))
# acled$WEEKDAY <- wday(dmy(acled$EVENT_DATE))
wday(dmy(acled$EVENT_DATE))
sort(table(acled$WEEKDAY))

# Visualise the data

ggplot(acled, aes(FATALITIES))+
  geom_histogram(binwidth = 5)
ggplot(acled, aes(EVENT_TYPE))+
  geom_bar()
ggplot(acled, aes(EVENT_TYPE,FATALITIES))+
  geom_bar(stat = "identity")
acled$MONTH <- substr(acled$EVENT_DATE,1,6)
ggplot(aggregate(FATALITIES~MONTH,acled,sum),aes(MONTH,FATALITIES,group=1))+
  geom_line()
ggplot(acled, aes(y = LATITUDE, x = LONGITUDE))+
  geom_point()
ggplot(acled, aes(y = LATITUDE, x = LONGITUDE))+
  geom_point(alpha=0.4, aes(colour=EVENT_TYPE,size=FATALITIES))+
  scale_size_area()

# Import data
dat <- read_excel("./02221-Lab7/ACLED-Africa_1997-2018_upd-mar19.xlsx")
sort(table(dat$EVENT_TYPE))
dat <- # remove invalid coordinates
  dat[dat$LATITUDE<=90&dat$LATITUDE>=-90&dat$LONGITUDE<=180&dat$LONGITUDE>=-180,] 

ggplot(aggregate(FATALITIES~YEAR,dat,sum),aes(YEAR,FATALITIES))+
  geom_line()+
  scale_x_continuous(labels=1997:2018,breaks=1997:2018)+
  ggtitle("Number of Fatalities by Year (1997-2018)")+
  geom_vline(aes(xintercept=1999),colour="red")
ggplot(dat[dat$YEAR==1999,], aes(y = LATITUDE, x = LONGITUDE))+
  geom_point(alpha=0.4, aes(size=FATALITIES))+
  scale_size_area()+g
gtitle("Distribution of Fatalities in Africa (1999)")
ggplot(dat[dat$YEAR==2004,], aes(y = LATITUDE, x = LONGITUDE))+
  geom_point(alpha=0.4, aes(size=FATALITIES))+
  scale_size_area()+
  ggtitle("Distribution of Fatalities in Africa (2004)")
ggplot(dat[dat$YEAR %in% c(1999,2004),], aes(y = LATITUDE, x = LONGITUDE))+
  geom_point(alpha=0.4, aes(colour=factor(YEAR),size=FATALITIES))+
  scale_size_area()+ggtitle("Distribution of Fatalities in Africa (1999 & 2004)")+
  scale_color_brewer(aes(YEAR),type = "qua")
