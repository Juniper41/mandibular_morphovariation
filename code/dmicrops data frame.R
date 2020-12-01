### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
dmicrops_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep("02", times=12), rep("06", times =9), rep("12", times = 3))
#Grouped by 1,500 intervals
#Nlep# stratum <- c(rep("1500", times=36), rep("3000", times =9), rep("4500", times = 15), rep("6000", times =12))
#plong

stratum <- c(rep("02 & 03", times=12), rep("06", times =9), rep("10", times = 3), rep("02 & 03", times = 3))

#add stratum column to dataframe
dmicrops_df$stratum <- stratum

ggplot(dmicrops_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
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

my_title <- expression(paste(italic("D. microps")))

save(dmicrops_df)
save(file=dmicrops_df)
save(dmicrops_df, file="dmicrops_df.RDa")
