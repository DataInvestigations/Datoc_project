rm(list=ls()) # clears workspace

#load important packages##
library(ggplot2)
library(gridExtra)
library(viridis)
library(dplyr)


# Load in US Bat Temp data
batdat=read.csv("us_bat_temps.csv") 

# Check amount of entries that are "NA"
colSums(is.na(batdat))

# Remove any rows that have missing values
bat_clean <- batdat[complete.cases(batdat), ]

# Filter by the bat species that is equal to "BAT"
filt <- bat_clean %>% filter(type == "BAT")

# Plot 
ggplot(data=filt, aes(x = species, y = temp)) +
  geom_boxplot() + labs(title = "Temperature versus Species", x = "Bat Species", y = "Temperature (°C)")



#g1=ggplot(data=batdat,aes(x=species,y=lgdL,color=site))+
  #geom_point(size=2) #this adds points to graph
#g1
#a simple graph with species on x, and lgdL (loads) on Y, site is color

#this is a little too simple, but ggplot2 allows us to buid

#g1=ggplot(data=batdat,aes(x=species,y=lgdL,color=site))+
  #geom_boxplot() #this add a boxplot to the graph
#g1
