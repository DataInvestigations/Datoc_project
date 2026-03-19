rm(list=ls())

# Question 1

library(ggplot2)
library(performance)

batdat <- read.csv("us_bat_temps.csv")
head(batdat)
View(batdat)

ggplot(data=batdat,aes(x=species,y=temp))+
  geom_point(size=2)
bat_clean <- batdat[complete.cases(batdat), ]


fit <- lm(temp ~ species, data = bat_clean)
summary(fit)
plot(fit)
hist(resid(fit))

# Question 2

check_model(fit, check = "linearity")

check_model(fit, check = "homogeneity")

check_model(fit, check = "outliers")

check_model(fit, check = "qq")


# Question 3

# The graph checking linearity appears to display a relatively flat green line, 
# which indicates that the assumption of linearity is likely satisfied. Given that 
# the variance graph appears to display some curvature, the assumption of constant 
# variance is violated. Additionally, the plot of residuals versus the fitted values 
# shows that the points are not evenly distributed about the reference line. This is 
# likely occurring because the variance between the temperatures corresponding to each species 
# is significant. In terms of the normality of the residuals, the majority of the points fall 
# along the reference line and the qq plot looks relatively normal. However, there are some 
# heavy tails occurring therefore it is more plausible that the assumption of normality is violated. 
# Given the residuals versus leverage plot, there are three points that have potential to 
# have significant influence on the regression line. However, these points do not exceed the 
# cook's distance line. Also, on the influential observations plot, there are definitely 
# some points indicative of outliers. 


# Question 4
g1 <- ggplot(data = batdat, aes(x = species, y = temp)) + geom_point() +  stat_summary(fun.data = "mean_se", colour="red", size=1)

g1

