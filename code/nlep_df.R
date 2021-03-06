### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
nlepida_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep("02", times=21), rep("03", times = 15), rep("04", times =3), rep("05", times = 6), rep("06", times = 9), rep("07", times = 6), rep("10", times =6), rep("11", times =6))

#Grouped by 1,500 intervals
stratum <- c(rep("02-03", times=12), rep("04-07", times =8), rep("10-11", times =4))
#plong

#add stratum column to dataframe
nlepida_vector_df$stratum <- stratum

my_title <- expression(paste(italic("N. lepida")))

ggplot(nlepida_vector_df, aes(group=stratum, x = stratum, y=nlepida_vector, fill=stratum)) + 
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

save(nlepida_df, file="nlepida_df.RDa")

write.csv(nlepida_df,file = "nlepCS.csv")

#Average each series of 3 mandibles to one Centroid Size Measure
nlepida_vector <- .colMeans(data.super$Csize, 3, length(data.super$Csize) / 3)
nlepida_vector_df <- data.frame(nlepida_vector)
