### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
plong_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep(2, times=21), rep(3, times = 15), rep(4, times =3), rep(5, times = 6), rep(6, times = 9), rep(7, times = 6), rep(10, times =6), rep(11, times =6))

#Grouped by 1,500 intervals
#Nlep# stratum <- c(rep("1500", times=36), rep("3000", times =9), rep("4500", times = 15), rep("6000", times =12))
#plong

stratum <- c(rep("02 & 03", times=21), rep("06 & 07", times =33), rep("10", times = 6))

#add stratum column to dataframe
plong_df$stratum <- stratum

ggplot(plong_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
  geom_boxplot()+
  ggtitle(my_title)+
  xlab("YBP")+
  ylab("Mean Centroid Size")
  facet_wrap(~group, scale="free")

###ggplot(nlep_df, aes(group=stratum, y = data.super$Csize, x = as.factor(stratum), fill = as.factor(stratum))+
  #geom_boxplot()+
  #xlab("Years Before Present")+
  #ylab("Mean Centroid Size")+
  #theme_classic()+
  #scale_fill_discrete(name= "Legend")

my_title <- expression(paste(italic("P. longimembris")))
  