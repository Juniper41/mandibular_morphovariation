### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
ncinerea_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep("04", times=03), rep("05", times = 03))
#add stratum column to dataframe
ncinerea_df$stratum <- stratum

my_title <- expression(paste(italic("N. cinerea")))

ggplot(ncinerea_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
  geom_boxplot()+
  ggtitle(my_title)+
  xlab("Stratum")+
  ylab("Mean Centroid Size")
facet_wrap(~group, scale="free")

###ggplot(nlep_df, aes(group=stratum, y = data.super$Csize, x = as.factor(stratum), fill = as.factor(stratum))+
#geom_boxplot()+
#xlab("Years Before Present")+
#ylab("Mean Centroid Size")+
#theme_classic()+
#scale_fill_discrete(name= "Legend")


