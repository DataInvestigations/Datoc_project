# Does the relationship between cluster size and temperature differ by species?
library(ggplot2)

batdat <- read.csv("us_bat_temps.csv")
bat_new <- na.omit(batdat)
#View(batdat)

g1 <- glm(temp ~ cluster_size * species, data = bat_new, family = gaussian, na.action = na.exclude)
summary(g1)


bat_new$yhat = predict(g1,bat_order, type="response")
head(bat_new$yhat)
bat_order <- bat_new[order(bat_new$species, bat_new$cluster_size), ]


#geom_line(data=batdat, aes(x=cluster_size,y=temp,col = species))
plot1 <- ggplot(bat_order,aes(x= cluster_size,y= temp,color=species))+ geom_point(size=2,shape =1) + 
  geom_line(aes(x = cluster_size, y=yhat, group = species)) + labs(title = "Relationship between Cluster Size and Temp by Species")
plot1

# The generalized linear model appears to display that there is a prominent effect of cluster size on temperature according to species. 
# (beta = 0.0056, p = 0.031). This indicates that the temperature could increase as the cluster size does as well. It is also reaffirmed that 
# there is a difference between temperature varied by each species. Since some estimates are in the positive range while others are all the way 
# in the negative. The relationship between cluster size and temperature was significant for several species as seen in the summary of 
# the glm as many has a significance code value of 3 asterisks. However, due to the difference of estimates across different species, 
# the results suggest that the interaction between temperature and cluster size is heavily varied.