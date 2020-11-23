### Geometric Morphometrics ###
## To begin, data required:
# 1. dataOverlapDeleted.tps
# 2. slidersEdited.nts

## Packages required:
library(vegan)
library(shapes)
library(geomorph)

require(vegan)
require(shapes)
require(geomorph)

setwd('C:/Users/3099lab/Google Drive/RodentMandibleImages/TLC/Peromyscus_maniculatus') #you'll want to change this
list.files() #shows what's in the folder

 
# Load .tps file containing 2D landmark coordinates, returns an array
data <- readland.tps(file.choose(),specID = "ID", negNA = TRUE)		# load ___OverlapDeleted	

# View your Data
data

# Omit any landmarks with < 50% representation
data <- data[nth,,]

# Write new TPS file with ommitted landmarks
## Save all files as "gspecies_" ... genus first letter and species name"
writeland.tps(data, "gspecies_excluded.TPS", scale = TRUE,  specID = TRUE)


# Estimate Missing landmarks.
## Save as gspecies_est i.e. Dmicrops_est
gspecies_est <- estimate.missing(data,method="TPS")
estimate.missing(data,method="TPS")


#Save TPS file with estimated landmark coordinates. 
writeland.tps(gspecies_est, "gspecies_est.TPS", scale = NULL, specID = TRUE)


# Load .nts file containing sliders
sliders <- read.table(file.choose())	# load ___SlidersEdited file (first two lines should be deleted from the original sliders file)
# convert to matrix format
sliders <- as.matrix(sliders)


# Function to perform Procrustes analysis on fixed and sliding landmarks; ProcD = FALSE slides semilandmarks bases on minimizing bending energy; If no semilandmarks, curves = NULL is default
data.super <- gpagen(gspecies_est, ProcD = FALSE, curves = NULL)


# to quickly replot superimposition
plotAllSpecimens(data.super$coords)		#same plot as gpagen()
specimens <- names(data.super$Csize)
#plotAllSpecimens(data.super$coords[1,,])  ## plot first tooth


# gpagen returns a list with the following components:
names(data.super)
# data.super$coords is array
# data.super$Csize is vector of centroid sizes

# Extract specimen names
specimens <- names(data.super$Csize)


## Plots and analyses ##

# Plot allometric patterns in landmark data
quartz()	#this is different for windows users - dev.new() maybe???
test <- procD.allometry(data.super$coords~ data.super$Csize)
plot(test, method = "CAC")

# find mean shape coordinates for reference
ref <- mshape(data.super$coords)
plot(ref)
# compare individuals to mean reference
plotRefToTarget(ref, data.super$coords[,,3])

## Linear regression model procD.lm function quantifies the relative amount of shape variation attributable to one or more factors and assesses this variation via permutation; requires response variable to be in the form of a two-dimensional data matrix rather than a 3D array, two.d.array function converts 3D array of landmark coordinates to 2D data matrix; function returns an ANOVA table of statistical results for each factor
y <- two.d.array(data.super$coords)
# Linear regression takes formula for linear model, e.g., y~x1+x2
procD.lm(y~data.super$Csize, iter = 99)
# Adonis function is also a linear regression model and provides R2 values
adonis(y~data.super$Csize, method = "euclidean")
###  Of procD.lm() and adonis(), I prefer, and most often use the adonis function, because it returns an R2 value



## PCA analysis
# prcomp function conducts a pca on a 2D array
pca <- prcomp(y)
# specimen list
rownames(pca$x)
# summary of PCA
summary(pca)
# plot PCA
plot(pca$x[1:4,1:2], asp=1, pch=21, col = "black")  ### plots PC1 and PC2 of 4 toothrows of one ind
plot(pca$x[,1:2], asp=1, pch=21, col = "coral")  ### plots all inds in dataset

# to identify what point belongs to which specimen, you can use the identify function: It produces a cross-hair, position the crosshair on a point in your plot and click to provide a label.  When you are done, hit escape to get out of identify function.
identify(x = pca$x[,1], y = pca$x[,2], labels = specimens)


# Multivariate Manova Linear Regression: conduct a PCA reduction first, then input PC's as dependent variables. Choose how many PC's you would like to use (~97% of variance, or N/4 where N is the sample size)
PCinput <- pca$x[,1:6]
summary(manova(lm(PCinput~data.super$Csize)))


# plot all inds with own color in dataset
randCol <- rainbow(14)
indCol <- NULL
for(i in randCol){
	indCol <- c(indCol, rep(i, times = 3))
}
plot(pca$x[,1:2], asp=1, pch=19, col = indCol, cex = 2)  

randCol <- rainbow(14)
indCol <- NULL
for(i in randCol){
  if(i == randCol[5]){
    indCol <- c(indCol, rep(i, times = 4))
  }else{
    indCol <- c(indCol, rep(i, times = 3))
  }
}

adonis(y~spData$Individual, method = "euclidean")

# Plot pc1 against centroid size
plot(pca$x[,1]~log(data.super$Csize), pch = 21, bg = "black",ylab = "PC1", xlab = "log(Centroid Size)" )  #similar plot to plotAllometry


### So far, we've been playing around with all the data, but in reality each individual is represented by four digitized photos and therefore 4 sets of shape coordinates; in order to do proper analysis, we should average 4 sets of shape coordinates (and size) to get one value for each individual.  ###


# Read in data table
spData <- read.table("spData.csv", header = T, sep = ",", stringsAsFactors = F)
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
seqn <- seq(from =1, to = 8, by =2) #####  seqn <- c(1,4,7,10,13,17,21,24,27,31,34,37,40,43)
for(i in seqn){
  size <- mean(data.super$Csize[i:(i+1)])
  size.means <- c(size.means, size)
}

## Now, it is a good idea to re-superimpose your data; To do so, you have to get the average shape data into the correct format for gpagen:
shape.means <- arrayspecs(allInd.means,1,2)
# Now superimpose mean individuals:
mean.super <- gpagen(shape.means)
plotAllSpecimens(mean.super$coords)	
# convert to 2D array:
shape <- two.d.array(mean.super$coords)

# reduce individual data from original specimen data table
indData <- spData[c(seqn),]
# should be the same (20 individuals)
dim(shape)
dim(indData)

### Plots and analyses:
#Check geomorph package for more functions and analyses - for instance, you can look at bilateral asymmetry; another good thing to check is sexual dimorphism in size or shape (for modern specimens)

quartz.options(height = 7, width = 10, dpi =72)
allometryResults <- procD.allometry(mean.super$coords~size.means)
plot(allmetryResults, method = "CAC")

shapePCA <- prcomp(shape)
summary(shapePCA)
plot(shapePCA$x[,1:2], asp = 1, pch = 21, col = "black")
plot(shapePCA$x[,1]~size.means, pch = 19)
# to make life easier:
wear <- indData$Wear.Stage
plot(shapePCA$x[,1]~wear, pch = 19)


# This is what I tested with this dataset, but you could test any predictor variable you wanted in a similar way:
adonis(shape~indData$Sex, method = "euclidean") # non-significant; no sexual dimorphism

## Shape and wear:
adonis(shape~size.means, method = "euclidean")
adonis(shape~wear, method = "euclidean")
##Both are significant, test for an interaction term; adonis() - it does depend which variable you put first - fit your 'nuisance' terms first:
adonis(shape~size.means*wear, method = "euclidean")  # interaction term is significant
adonis(wear~size.means, method = "euclidean")  # very correlated

# To visualize, you can do a plot allometry by color; 
# This code creates your color vector:
wearCol <- vector(mode = "character", length = nrow(indData))
wearCol[which(indData$Wear.Stage == "0.5")] <- "#feedde"
wearCol[which(indData$Wear.Stage == "1")] <- "#fdd0a2"
wearCol[which(indData$Wear.Stage == "1.5")] <-"#fdae6b"
wearCol[which(indData$Wear.Stage == "2")] <-"#fd8d3c"
wearCol[which(indData$Wear.Stage == "3")] <-"#f16913"
wearCol[which(indData$Wear.Stage == "4")] <-"#d94801"
wearCol[which(indData$Wear.Stage == "5")] <-"#8c2d04"
# Now, run the plotAllometryColorFunction script! I've modified the plotAllometry Function to plot using the wearCol vector - you can easily change this color vector name in the script if you want.
plotAllometryColor(mean.super$coords, size.means, method = "CAC")
# Crudely, make a legend:
colSeq <- c("#feedde", "#fdd0a2", "#fdae6b", "#fd8d3c", "#f16913", "#d94801", "#8c2d04")
xpts <- c(1,1.2)
ypts <- 1:8
quartz.options(height=5, width=2, dpi = 72)
plot.new()
plot.window(xlim = c(1,2), ylim = c(0,8))
for(i in ypts){
	polygon(x = c(xpts[2:1], xpts), y = c(ypts[i], ypts[i], ypts[i+1], ypts[i+1]), col = colSeq[i])
}


#### Function to remove the effects of allometry (Size standardize your shape data)
Size.stand = function(data,X)
{
N=nrow(data)
X=as.vector(log(X))
meanX=mean(X)
meanXc=c(1,meanX)
model1=lm(data~X)
shapeMean=as.numeric(crossprod(coef(model1),meanXc))
model1.res<-as.matrix(model1$res)
meanShape=rep(1,N)%*%t(shapeMean)
#Add residuals to minimum and and max values
shapeMean.stand<-model1.res+meanShape
stand=as.matrix(shapeMean.stand)
}

# Run the function on our data:
shapeStand <- Size.stand(shape, size.means)
adonis(shapeStand~indData$Wear.Stage, method = "euclidean")
# effect of wear stage is no longer significant


shapeStandPCA <- prcomp(shapeStand)
summary(shapeStandPCA)
plot(shapeStandPCA$x[,1:2], asp = 1, pch = 19)
plot(shapeStandPCA$x[,1]~size.means, pch = 19)
plot(shapeStandPCA$x[,1]~wear,pch = 19)  # less obvious correlation between wear and PC1 than before size standardization

# Wear allometry not longer present:
shapeStandArray <- arrayspecs(shapeStand,126,2, byLand = FALSE)
quartz.options(height=10, width=10, dpi = 72)
plotAllometry(shapeStandArray, size.means, method = "CAC")

###################################################################################################################

###################################################################################################################

###################################################################################################################

###################################################################################################################

setwd('C:/Users/3099lab/Google Drive/RodentMandibleImages/TLC/Peromyscus_maniculatus') #you'll want to change this
list.files() #shows what's in the folder


# Load .tps file containing 2D landmark coordinates, returns an array
data <- readland.tps(file.choose(),specID = "image")		# load ___OverlapDeleted	


# Function to perform Procrustes analysis on fixed and sliding landmarks; ProcD = FALSE slides semilandmarks bases on minimizing bending energy; If no semilandmarks, curves = NULL is default
data.super <- gpagen(data, ProcD = FALSE)

# to quickly replot superimposition
plotAllSpecimens(data.super$coords)		#same plot as gpagen()
specimens <- names(data.super$Csize)
plotAllSpecimens(data.super$coords[1,,])  ## plot first tooth


# gpagen returns a list with the following components:
names(data.super)
# data.super$coords is array
# data.super$Csize is vector of centroid sizes

# Extract specimen names
specimens <- names(data.super$Csize)


## Plots and analyses ##

# Plot allometric patterns in landmark data
quartz()	#this is different for windows users - dev.new() maybe???
plot.procD.allometry(data.super$coords~ data.super$Csize, method = "CAC")

# find mean shape coordinates for reference
ref <- mshape(data.super$coords)
plot(ref)
# compare individuals to mean reference
plotRefToTarget(ref, data.super$coords[,,11])

## Linear regression model procD.lm function quantifies the relative amount of shape variation attributable to one or more factors and assesses this variation via permutation; requires response variable to be in the form of a two-dimensional data matrix rather than a 3D array, two.d.array function converts 3D array of landmark coordinates to 2D data matrix; function returns an ANOVA table of statistical results for each factor
y <- two.d.array(data.super$coords)
# Linear regression takes formula for linear model, e.g., y~x1+x2
procD.lm(y~data.super$Csize, iter = 99)
# Adonis function is also a linear regression model and provides R2 values
adonis(y~data.super$Csize, method = "euclidean")
###  Of procD.lm() and adonis(), I prefer, and most often use the adonis function, because it returns an R2 value



## PCA analysis
# prcomp function conducts a pca on a 2D array
pca <- prcomp(y)
# specimen list
rownames(pca$x)
# summary of PCA
summary(pca)
# plot PCA
plot(pca$x[1:4,1:2], asp=1, pch=21, col = "black")  ### plots PC1 and PC2 of 4 toothrows of one ind
plot(pca$x[,1:2], asp=1, pch=21, col = "coral")  ### plots all inds in dataset

# to identify what point belongs to which specimen, you can use the identify function: It produces a cross-hair, position the crosshair on a point in your plot and click to provide a label.  When you are done, hit escape to get out of identify function.
identify(x = pca$x[,1], y = pca$x[,2], labels = specimens)


# Multivariate Manova Linear Regression: conduct a PCA reduction first, then input PC's as dependent variables. Choose how many PC's you would like to use (~97% of variance, or N/4 where N is the sample size)
PCinput <- pca$x[,1:20]
summary(manova(lm(PCinput~data.super$Csize)))


# plot all inds with own color in dataset
randCol <- rainbow(20)
indCol <- NULL
for(i in randCol){
  indCol <- c(indCol, rep(i, times = 4))
}
plot(pca$x[,1:2], asp=1, pch=19, col = indCol)  

# Plot pc1 against centroid size
plot(pca$x[,1]~log(data.super$Csize), pch = 21, bg = "black",ylab = "PC1", xlab = "log(Centroid Size)" )  #similar plot to plotAllometry


### So far, we've been playing around with all the data, but in reality each individual is represented by four digitized photos and therefore 4 sets of shape coordinates; in order to do proper analysis, we should average 4 sets of shape coordinates (and size) to get one value for each individual.  ###


# Read in data table
spData <- read.table("OK_uppers_dataList.csv", header = T, sep = ",", stringsAsFactors = F)
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

# Avg size
size.means<- NULL
seqn <- seq(from =1, to = 80, by =4)
for(i in seqn){
  size <- mean(data.super$Csize[i:(i+3)])
  size.means <- c(size.means, size)
}

## Now, it is a good idea to re-superimpose your data; To do so, you have to get the average shape data into the correct format for gpagen:
shape.means <- arrayspecs(allInd.means,126,2)
# Now superimpose mean individuals:
mean.super <- gpagen(shape.means)
# convert to 2D array:
shape <- two.d.array(mean.super$coords)

# reduce individual data from original specimen data table
indData <- spData[c(seqn),]
# should be the same (20 individuals)
dim(shape)
dim(indData)

### Plots and analyses:
#Check geomorph package for more functions and analyses - for instance, you can look at bilateral asymmetry; another good thing to check is sexual dimorphism in size or shape (for modern specimens)

quartz.options(height = 7, width = 10, dpi =72)
plotAllometry(mean.super$coords, size.means, method = "CAC")

shapePCA <- prcomp(shape)
summary(shapePCA)
plot(shapePCA$x[,1:2], asp = 1, pch = 21, col = "black")
plot(shapePCA$x[,1]~size.means, pch = 19)
# to make life easier:
wear <- indData$Wear.Stage
plot(shapePCA$x[,1]~wear, pch = 19)


# This is what I tested with this dataset, but you could test any predictor variable you wanted in a similar way:
adonis(shape~indData$Sex, method = "euclidean") # non-significant; no sexual dimorphism

## Shape and wear:
adonis(shape~size.means, method = "euclidean")
adonis(shape~wear, method = "euclidean")
##Both are significant, test for an interaction term; adonis() - it does depend which variable you put first - fit your 'nuisance' terms first:
adonis(shape~size.means*wear, method = "euclidean")  # interaction term is significant
adonis(wear~size.means, method = "euclidean")  # very correlated

# To visualize, you can do a plot allometry by color; 
# This code creates your color vector:
wearCol <- vector(mode = "character", length = nrow(indData))
wearCol[which(indData$Wear.Stage == "0.5")] <- "#feedde"
wearCol[which(indData$Wear.Stage == "1")] <- "#fdd0a2"
wearCol[which(indData$Wear.Stage == "1.5")] <-"#fdae6b"
wearCol[which(indData$Wear.Stage == "2")] <-"#fd8d3c"
wearCol[which(indData$Wear.Stage == "3")] <-"#f16913"
wearCol[which(indData$Wear.Stage == "4")] <-"#d94801"
wearCol[which(indData$Wear.Stage == "5")] <-"#8c2d04"
# Now, run the plotAllometryColorFunction script! I've modified the plotAllometry Function to plot using the wearCol vector - you can easily change this color vector name in the script if you want.
plotAllometryColor(mean.super$coords, size.means, method = "CAC")
# Crudely, make a legend:
colSeq <- c("#feedde", "#fdd0a2", "#fdae6b", "#fd8d3c", "#f16913", "#d94801", "#8c2d04")
xpts <- c(1,1.2)
ypts <- 1:8
quartz.options(height=5, width=2, dpi = 72)
plot.new()
plot.window(xlim = c(1,2), ylim = c(0,8))
for(i in ypts){
  polygon(x = c(xpts[2:1], xpts), y = c(ypts[i], ypts[i], ypts[i+1], ypts[i+1]), col = colSeq[i])
}


#### Function to remove the effects of allometry (Size standardize your shape data)
Size.stand = function(data,X)
{
  N=nrow(data)
  X=as.vector(log(X))
  meanX=mean(X)
  meanXc=c(1,meanX)
  model1=lm(data~X)
  shapeMean=as.numeric(crossprod(coef(model1),meanXc))
  model1.res<-as.matrix(model1$res)
  meanShape=rep(1,N)%*%t(shapeMean)
  #Add residuals to minimum and and max values
  shapeMean.stand<-model1.res+meanShape
  stand=as.matrix(shapeMean.stand)
}

# Run the function on our data:
shapeStand <- Size.stand(shape, size.means)
adonis(shapeStand~indData$Wear.Stage, method = "euclidean")
# effect of wear stage is no longer significant


shapeStandPCA <- prcomp(shapeStand)
summary(shapeStandPCA)
plot(shapeStandPCA$x[,1:2], asp = 1, pch = 19)
plot(shapeStandPCA$x[,1]~size.means, pch = 19)
plot(shapeStandPCA$x[,1]~wear,pch = 19)  # less obvious correlation between wear and PC1 than before size standardization

# Wear allometry not longer present:
shapeStandArray <- arrayspecs(shapeStand,126,2, byLand = FALSE)
quartz.options(height=10, width=10, dpi = 72)
plotAllometry(shapeStandArray, size.means, method = "CAC")











