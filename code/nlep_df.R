### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
nlepida_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep("02", times=21), rep("03", times = 15), rep("04", times =3), rep("05", times = 6), rep("06", times = 9), rep("07", times = 6), rep("10", times =6), rep("11", times =6))

#Grouped by 1,500 intervals
stratum <- c(rep("02-03", times=36), rep("04-07", times =24), rep("10-11", times =12))
#plong

#add stratum column to dataframe
nlepida_df$stratum <- stratum

my_title <- expression(paste(italic("N. lepida")))

ggplot(nlepida_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
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


  