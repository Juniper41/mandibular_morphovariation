## Packages required:
require(vegan)
require(shapes)
require(geomorph)  
#_________________________________________________________________________________________________________________#
# Get Data and set your working directory
setwd("/Users/davidtaylor/Google Drive/RodentMandibleImages/TLC/Chaetodipus_formosus/C_formosus_Edited2") #you'll want to change this
list.files() #shows what's in the folder
  
# Load .tps file containing 2D landmark coordinates, returns an array
data1 <- readland.tps(file.choose("Cform_est.tps"),specID = "ID")

# Check your data
data1 
#_________________________________________________________________________________________________________________#
# Superimpose data to account for size and shape variation 

# Function to perform Procrustes analysis on fixed and sliding landmarks; 
# ProcD = FALSE slides semilandmarks bases on minimizing bending energy; 
# If no semilandmarks, curves = NULL is default
data.super <- gpagen(data1, ProcD = FALSE, curves = NULL, PrinAxes = TRUE, Proj = TRUE)
summary(data.super) 
#plots coordinates 
plot(data.super)
#_________________________________________________________________________________________________________________#
# Identify data components

# data.super$coords is array
# data.super$Csize is vector of centroid sizes

# gpagen returns a list with the following components:
names(data.super)

# Extract specimen names
specimens <- names(data.super$Csize)

#_________________________________________________________________________________________________________________#
# Plots and analyses of all pictures (not averaged)

quartz()	#this is different for windows users - dev.new() maybe???
test <- procD.allometry(data.super$coords~ data.super$Csize)
plot(test, method = "CAC", shapes = TRUE) #
plot(test,method="RegScore",shapes=TRUE) # Shape Regression Score vs log(size)
plot(test,method="PredLine",shapes=TRUE)


# find mean shape coordinates for reference
ref <- mshape(data.super$coords)
plot(ref)
# compare individuals to mean reference
plotRefToTarget(ref, data.super$coords[,,41], method ="TPS") #shows warp grid
plotRefToTarget(ref, data.super$coords[,,41], method ="vector") #shows arrows
#_________________________________________________________________________________________________________________#
# Linear Model of Raw data on Csize

## Linear regression model procD.lm function quantifies the relative amount of shape variation
## attributable to one or more factors and assesses this variation via permutation; 
## requires response variable to be in the form of a two-dimensional data matrix rather than a 3D array, 
## two.d.array function converts 3D array of landmark coordinates to 2D data matrix; 
## function returns an ANOVA table of statistical results for each factor

y <- two.d.array(data.super$coords)
# Linear regression takes formula for linear model, e.g., y~x1+x2
procD.lm(y~data.super$Csize, iter = 99)
# Adonis function is also a linear regression model and provides R2 values
adonis(y~data.super$Csize, method = "euclidean")
###  Of procD.lm() and adonis(), I prefer, and most often use the adonis function, because it returns an R2 value

#_________________________________________________________________________________________________________________#
## PCA analysis (Raw Data)

# prcomp function conducts a pca on a 2D array
pca <- prcomp(y)
# specimen list
rownames(pca$x)
# summary of PCA
summary(pca)
# plot PCA
plot(pca$x[0:44,1:2], asp=1, pch=21, col = "black", warpgrids = TRUE, label = NULL, gp.label = FALSE, pt.col = NULL, mesh = NULL, shapes = FALSE) 
### plots PC1 and PC2 of 4 toothrows of one ind
plot(pca$x[0:44,1:2], asp=1, pch=21, col = "coral")  ### plots all inds in dataset

# to identify what point belongs to which specimen, you can use the identify function: It produces a cross-hair, position the crosshair on a point in your plot and click to provide a label.  When you are done, hit escape to get out of identify function.
identify(x = pca$x[,1], y = pca$x[,2], labels = specimens)

# Plot pc1 against centroid size
plot(pca$x[,1]~log(data.super$Csize), pch = 21, bg = "black",ylab = "PC1", xlab = "log(Centroid Size)" )  #similar plot to plotAllometry
# Check for colinearity between PCAs
plot(pca$x[,1]~pca$x[,3], pch = 21, bg = "black",ylab = "PCx", xlab = "PCx" )

# Multivariate Manova Linear Regression: conduct a PCA reduction first, then input PC's as dependent variables. Choose how many PC's you would like to use (~97% of variance, or N/4 where N is the sample size)
PCinput <- pca$x[,1:12]
summary(manova(lm(PCinput~data.super$Csize)))

# plot all inds with own color in dataset
randCol <- rainbow(14)
indCol <- NULL
for(i in randCol){
  indCol <- c(indCol, rep(i, times = 3))
}
plot(pca$x[,1:2], asp=1, pch=19, col = indCol, cex = 1.25, ylim = c(-.05,.05), xlim = c(-.05,.05))  

## At this point for the C. formosus dataset I feel pretty good that the landmarking is consistent, there is some variation;
## but I think that we can safely average and not expect that variation in landmarks across pictures drives variation.

#_________________________________________________________________________________________________________________#
# Averaging the the three images together. And investigating the points

# Read in data table (this is a data table that can be expanded and includes the individual identifier
# and any other individual specific data)

spData <- read.table("SpDataCF.csv", header = T, sep = ",", stringsAsFactors = F)
head(spData)  # check file read-in
colnames(spData)  # column names

# Mean shape and size per individual

## Avg for each individual
# Avg shape
allInd.means <- NULL
for(i in 1:ncol(y)){
  mean.temp <- tapply(y[,i], spData$Individual, mean)
  allInd.means <- cbind(allInd.means, mean.temp)
}

# Avg size (either do this a different way, or modify for your dataset...)
size.means<- NULL
seqn <- seq(from =1, to = 45, by =3) #####  seqn <- c(1,4,7,10,13,17,21,24,27,31,34,37,40,43)
for(i in seqn){
  size <- mean(data.super$Csize[i:(i+2)])
  size.means <- c(size.means, size)
}


## Now, it is a good idea to re-superimpose your data; 
## To do so, you have to get the average shape data into the correct format for gpagen:
shape.means <- arrayspecs(allInd.means,14,2)
# Now superimpose mean individuals:
mean.super <- gpagen(shape.means)
plotAllSpecimens(mean.super$coords)	
# convert to 2D array:
shape <- two.d.array(mean.super$coords)

# find mean shape coordinates for reference
ref2 <- mshape(mean.super$coords)
plot(ref2)
# compare individuals to mean reference
plotRefToTarget(ref2, mean.super$coords[,,15],method ="vector")
plotRefToTarget(ref2, mean.super$coords[,,15],method ="TPS")
plotRefToTarget(ref2, mean.super$coords[,,2],method ="points")
define.links(ref2, ptsize = 1, links = NULL)
stop
# reduce individual data from original specimen data table
indData <- spData[c(seqn),]
# should be the same (15 individuals)
dim(shape)
dim(indData)

