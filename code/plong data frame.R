### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
plong_df <- data.frame(data.super$Csize)
plong9_df <- plong_df[-9,,]
plong8_df <- plong9_df[-8]
plong7_df <- plong8_df[-7]

plong7_df <- data.frame(plong7_df)

#Group By Stratums
stratum <- c(rep("02-03", times=18), rep("06-07", times =33), rep("10", times = 6))
#Grouped by 1,500 intervals
#Nlep# stratum <- c(rep("1500", times=36), rep("3000", times =9), rep("4500", times = 15), rep("6000", times =12))
#plong

stratum <- c(rep("02 & 03", times=12), rep("06", times =9), rep("10", times = 3), rep("02 & 03", times = 3))

#add stratum column to dataframe
plong7_df$stratum <- stratum

my_title <- expression(paste(italic("P. longimembris")))

ggplot(plong7_df, aes(group=stratum, x = stratum, y=plong7_df, fill=stratum)) + 
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



save(plong_df)
save(file=dmicrops_df)
save(plong_df, file="plong_df.RDa")
