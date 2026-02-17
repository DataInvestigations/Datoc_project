
#heatmap
install.packages("heatmaply")
library(heatmaply)
View(mtcars)

#xlab = "Variables", ylab = "Car Models"
heatmaply(mtcars)
# Change the linkage
heatmaply(mtcars, scale = c("column"), hclust_method="single")

heatmaply(mtcars, scale = c("column"), col = heat.colors(200))
heatmaply(mtcars, scale = c("column"), k_col=2)
heatmaply(mtcars, scale = c("column"), k_col=3)


# Heatmap of the corrlation matrix
heatmaply_cor(cor(mtcars), xlab = "Features", ylab = "Features", k_col = 2, k_row = 2)



# Side annotation Heatmaps

# Create a color mapping for the number of cylinders
cyl_colors <- c("4" = "red", "6" = "blue", "8" = "green")

# Add row side colors to the heatmap
heatmaply(mtcars,
          RowSideColors = cyl_colors[as.character(mtcars$cyl)])


# NC60 
library (ISLR)
nci.labs=NCI60$labs
nci.data=NCI60$data
table(nci.labs)

idx = which(diag(cov(nci.data))>5)
heatmaply(nci.data[,idx])
cols= colorspace::rainbow_hcl(length(unique(nci.labs)))
cols = factor(nci.labs, labels=cols)
heatmaply(nci.data[,idx],RowSideColors = cols)



