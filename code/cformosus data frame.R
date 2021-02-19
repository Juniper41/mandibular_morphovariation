### MASTER
library(ggplot2)
library(pylr)
library(ggtext)

#make into dataframe
cformosus_df <- data.frame(data.super$Csize)

#Group By Stratums
stratum <- c(rep("02", times=15), rep("04", times = 12), rep("06", times = 15), rep("10", times =15), rep("11", times =15))

#add stratum column to dataframe
cformosus_df$stratum <- stratum

###pman_vector_df$stratum <- stratum


my_title <- expression(paste(italic("C. formosus")))

ggplot(cformosus_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
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


#Average each series of 3 mandibles to one Centroid Size Measure
nlepida_vector <- .colMeans(data.super$Csize, 3, length(data.super$Csize) / 3)
nlepida_vector_df <- data.frame(nlepida_vector)

write.csv(cformosus_df,file = "cforCS.csv")
