install.packages("cowplot")
library(cowplot)
library(gridExtra)
library(gower)
library(ggplot2)
library(graphics)
###install.packages("graphics")
library(gplots)
library(fields)
library(wesanderson)

plot(SpeciesLogged)
with(SpeciesLogged, plot(DMCS, DMPD))

SpeciesLogged <- SpeciesVarmatrix
df<-SpeciesLogged
df<-SpeciesVarmatrix

df5 <- df[,-13]
df4 <- df5[,-12]
plot(dfs[,2:3])

plot(SpeciesLogged)

arrows(1.363412, 1.483891, 1.375646,1.402365, col = "salmon", length = 0.1)


arrows(df[-nrow(df), 2], df[-nrow(df), 3], 
       df[-1, 2], df[-1, 3], col = "salmon", length=0.1)


plot(data=df, Name='CS',yName='PD',
                    groupName="Species")

??scatterplot
?plot

plot(df[,3:4], )
library(dplyr)
library(reshape2)
library(ggplot2)

dat.m = dat 
  add_rownames("group") %>%
  melt(id.var="group") %>%
  mutate(x = as.numeric(substr(variable, 4,5)))

  
ggplot(cforpman, aes(CS, PC, colour= Species, shape = Species)) +
  xlab("Centroid Size (log)") +
  ylab("Procrustes Distance (log + 1)") + 
  geom_point() +
  scale_colour_manual(values = wes_palette("Darjeeling1"))+
  theme_bw() +
  stat_ellipse()+
  geom_path()


wes_palettes
?stat_ellipse
arrows(df[-nrow(df), 2], df[-nrow(df), 3], 
       df[-1, 2], df[-1, 3])
              
              


ggplot(df, aes(Stratum, PMCS:NLPD)) +
  geom_point() +
  scale_colour_manual(values = wes_palette("Darjeeling1"))+
  theme_bw() +
  geom_smooth(method = 'lm')
 

?geom_smooth
ggplot(cforpman, aes(CS, PD, colour=Species)) +
  xlab("Centroid Size (log)") +
  ylab("Procrustes Distance (log + 1)") + 
  geom_point() +
  theme_bw() +
  
  stat_ellipse() + 
  scale_fill_manual(values = wes_palette("Cavalcanti1", n = 5))


plot(df[,2:3], col = "salmon", lwd = 2, pch = 21)
arrows(CS[-nrow(df)], PD[-nrow(df)], 
       CS[-1], PD[-1], col = "salmon", lwd = 2, length=0.1)

CS <- as.vector(SpeciesLogged$DMCS)
PD <- as.vector(SpeciesLogged$DMPC)
pmcs <- as.vector(SpeciesLogged$PMCS)
pmpd <- as.vector(SpeciesLogged$PMPC)
plcs <- as.vector(SpeciesLogged$PLCS)
plpd <- as.vector(SpeciesLogged$PLPC)
cfcs <- as.vector(SpeciesLogged$CFCS)
cfpd <- as.vector(SpeciesLogged$CFPC)
nlcs <- as.vector(SpeciesLogged$NLCS)
nlpd <- as.vector(SpeciesLogged$NLPC)
#PMAN
plot(df[,4:5], col = "gold", lwd = 2, pch = 21)
arrows(pmcs[-nrow(df)], pmpd[-nrow(df)], 
       pmcs[-1], pmpd[-1], col = "gold", lwd = 2, length=0.1)

#PLONG
plot(df[,6:7], col = "turquoise", lwd = 2, pch = 21)
arrows(plcs[-nrow(df)], plpd[-nrow(df)], 
       plcs[-1], plpd[-1], col = "turquoise", lwd = 2, length=0.1)

#CFOR
plot(df[,8:9], col = "black", lwd = 2, pch = 21)
arrows(cfcs[-nrow(df)], cfpd[-nrow(df)], 
       cfcs[-1], cfpd[-1], col = "salmon", lwd = 2, length=0.1)


#NLEP
plot(df[,10:11], col = "darkgreen", lwd = 2, pch = 21)
arrows(nlcs[-nrow(df)], nlpd[-nrow(df)], 
       nlcs[-1], nlpd[-1], col = "darkgreen", lwd = 2, length=0.1)


#########

 + scale_fill_manual(values = wes_palette("GrandBudapest1", n = 5))

ggplot(cforpman, aes(CS, PD, group = group, col = wes_palette("Cavalcanti1", type = "continuous"))) +
  xlab("Centroid Size (log)") +
  ylab("Procrustes Distance (log + 1)") + 
  geom_point() +
  theme_bw() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  stat_ellipse() + 
  scale_fill_manual(values = wes_palette("Cavalcanti1", n = 5))




ggplot(heatmap, aes(x = X2, y = X1, fill = value)) +
  geom_tile() + 
  scale_fill_gradientn(colours = pal) + 
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  coord_equal() 


plot(df[,8:9], col = "black", lwd = 2, pch = 21)
arrows(cfcs[-nrow(df)], cfpd[-nrow(df)], 
       cfcs[-1], cfpd[-1], col = wes_palette("Cavalcanti1", 10, type = "continuous"), lwd = 5, length = 0.1)

barplot(1:10, col = wes_palette("Rushmore1", 10, type = "continuous"))

x <- stats::runif(12); y <- stats::rnorm(12)
i <- order(CS, PD); CS <- CS[i]; PD <- PD[i]
plot(CS,PD, main = "arrows(.) and segments(.)")
## draw arrows from point to point :
s <- seq(length(CS)-1)  # one shorter than data
arrows(CS[s], PD[s], CS[s+1], PD[s+1], col = "salmon")
s <- s[-length(s)]
segments(CS[s], PD[s], CS[s+2], PD[s+2], col = "pink")

plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE); 
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)
file.copy(from=plots.png.paths, to="Output")
