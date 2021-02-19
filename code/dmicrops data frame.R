### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
dmicrops_df <- data.frame(data.super$Csize)
dmicrops_df <- dmicrops_df[-0,]

Csize <- data.super$Csize

Csize <- Csize[-0,]

Csize <- c(20.64825, 21.13384, 22.14787, 25.10450, 25.62966, 22.98411, 24.74757, 24.52492, 22.02380, 25.08862, 25.08862, 22.38533, 25.33387, 25.53749, 18.62155, 21.59417, 21.34877, 26.36462, 26.36462, 26.36462, 24.55796, 22.18216, 21.43938, 22.27645, 25.36092, 25.58857)
Csize_df <- data.frame(Csize)
#Group By Stratums
stratum <- c(rep("02", times=11), rep("06", times =9), rep("12", times = 3))
#Grouped by 1,500 intervals
#Nlep# stratum <- c(rep("1500", times=36), rep("3000", times =9), rep("4500", times = 15), rep("6000", times =12))
#plong

stratum <- c(rep("02 & 03", times=11), rep("06", times =9), rep("10", times = 3), rep("02 & 03", times = 3))

#add stratum column to dataframe
Csize_df$stratum <- stratum

ggplot(Csize_df, aes(group=stratum, x = stratum, y=Csize, fill=stratum)) + 
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

write.csv(dmicrops_df,file = "dmicropsCS.csv")
