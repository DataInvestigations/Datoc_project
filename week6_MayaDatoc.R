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

# Add an extra layer to make the color of the graph be grouped by season

ggplot(data=filt, aes(x = species, y = temp, color = season)) +
  geom_boxplot() + labs(title = "Temperature versus Species", x = "Bat Species", y = "Temperature (°C)")

# Create a separate density plot in order to visualize temperatures of infected versus healthy bats
ggplot(data = filt, aes(x = temp, fill = factor(gd))) + geom_density(alpha=0.5) + 
  labs(title = "Density of Temperatures of Bats Based on gd") + scale_fill_manual(values = c("#B9CFF0", "#6DE8C3"),labels = c("0: Not infected", "1: Infected"))


