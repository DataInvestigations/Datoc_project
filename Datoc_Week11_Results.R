# Does the relationship between cluster size and temperature differ by species?
library(ggplot2)

batdat <- read.csv("us_bat_temps.csv")
bat_new <- na.omit(batdat)
#View(batdat)

library(tidyverse)
bat_new = bat_new %>%
  drop_na(cluster_size)%>%
  drop_na(species)%>%
  drop_na(temp) %>%
  filter(species!="LANO")%>% #clean to remove these!!!
  filter(species!="MYAU" )%>%
  filter(species!="SUBSTRATE") %>%
  filter(species!="MYLE") 

g1 <- glm(temp ~ cluster_size * species, data = bat_new, family = gaussian, na.action = na.exclude)
summary(g1) 
#IRL, better to not call family gaussian for a glm but i didn't tell you that so okay


bat_order <- bat_new[order(bat_new$species, bat_new$cluster_size), ]
#better to give this a reduced dataset because SO big
newdat = with(bat_new, 
              expand.grid(
              cluster_size = unique(cluster_size),
              species = unique(species)
              )
)
#hmm doesn't like that because some species are NA - should just remove those
newdat$yhat = predict(g1,newdata = newdat, type="response")
#bat_new$yhat = predict(g1,bat_order, type="response")
head(bat_new$yhat)


#geom_line(data=batdat, aes(x=cluster_size,y=temp,col = species))
plot1 <- ggplot(bat_order,aes(x= cluster_size,y= temp,color=species))+
  geom_point(size=2,shape =1) + 
  geom_line(data = newdat, aes(x = cluster_size, y=yhat, group = species)) + 
  labs(title = "Relationship between Cluster Size and Temp by Species", x = "cluster size", y = "temp (Celsius)")
plot1
#it would be better to log cluster size so you can see this relationship

# The generalized linear model appears to display that there is a prominent effect of cluster size on temperature according to species. 
# (beta = 0.0056, p = 0.031). This indicates that the temperature could increase as the cluster size does as well. It is also reaffirmed that 
# there is a difference between temperature varied by each species. Since some estimates are in the positive range while others are all the way 
# in the negative. The relationship between cluster size and temperature was significant for several species as seen in the summary of 
# the glm as many has a significance code value of 3 asterisks. However, due to the difference of estimates across different species, 
# the results suggest that the interaction between temperature and cluster size is heavily varied.