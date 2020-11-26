### MASTER

ggplot(dfcs, aes(group=group, y = dfcs$data.super.Csize, x = split, , fill = NULL))+
  geom_boxplot()+
  xlab("Split")+
  ylab("Centroid Size")+
  theme_classic()+
  scale_fill_discrete(name= "Legend")


boxplot(df)

ggplot(nlep_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
  geom_boxplot()
facet_wrap(~group, scale="free")


split <- c(4,4,4,5,5,5)
dfcs$split <- split

stratum <- c(rep(2, times=21), rep(3, times = 15), rep(4, times =3), rep(5, times = 6), rep(6, times = 9), rep(7, times = 6), rep(10, times =6), rep(11, times =6))

#Grouped by 1,500 intervals
stratum <- c(rep("1500", times=36), rep("3000", times =9), rep("4500", times = 15), rep("6000", times =12))

nlep_df$stratum <- stratum

ggplot(nlep_df, aes(group=stratum, x = stratum, y=data.super$Csize, fill=stratum)) + 
  geom_boxplot()+
  xlab("YBP")+
  ylab("Mean Centroid Size")
facet_wrap(~group, scale="free")

ggplot(nlep_df, aes(group=stratum, y = data.super$Csize, x = as.factor(stratum), fill = as.factor(stratum))+
  geom_boxplot()+
  xlab("Years Before Present")+
  ylab("Mean Centroid Size")+
  theme_classic()+
  scale_fill_discrete(name= "Legend")

  