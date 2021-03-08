??pcoa
library(ape)
pcoa <- pcoa(dist, correction = "none")

plot(pcoa, type = 'n')

mod <- prcomp(dist)
biplot(mod)

y5 <- merge(y5, y, all = TRUE, sort = FALSE)
y41 <- y4
y5 <- yall
yall <- cbind(yall, new_col = vec) 
y <- cbind(y, spec = dmic)
cfory <- cbind(y, Diet = Diet)
cfdata <- cbind(cfdata, stratum = cf)

vec <- c(rep("dmicrops", 27), rep("pman", 45), rep("plong", 60), rep("nlep", 72), rep("cfor", 72))
vec <- c(rep("C. formosus", 33 ), rep("D. microps", 13), rep("P. maniculatus", 42), rep("P. longimembris", 26), rep("N. lepida", 27), rep("D. merriami", 27))
Diet <- c(rep("Granivore", 33 ), rep("Herbivore", 13), rep("Omnivore", 42), rep("Granivore", 26), rep("Herbivore", 27), rep("Herbivore", 27))


dm <- c(rep("modern", 4), rep("0880 ybp", 3), rep("1700-2250 ybp", 4), rep("3550 ybp", 2), rep("8000 ybp", 1))
cf <- c(rep("0-200 ybp", 5), rep("100-300 ybp", 4), rep("1700-2500 ybp", 15), rep("4900 ybp", 4), rep("6090-7550 ybp", 5))
cf <- c(rep("01-02", 5), rep("03-04", 4), rep("05-10", 15), rep("15-16", 4), rep("18-20", 5))
dmer <- c(rep("0-1000 ybp", 12), rep("1500-3500 ybp", 10), rep("4500-7500", 5))
dmic <- c(rep("0-1000 ybp", 7), rep("1500-3500 ybp", 5), rep("4500-7500", 1))
pman <- c(rep("0-1000 ybp", 17), rep("1500-3500 ybp", 17), rep("4500-7500", 8))
cfor <- c(rep("0-1000 ybp", 9), rep("1500-3500 ybp", 15), rep("4500-7500", 9))
plong <- c(rep("0-1000 ybp", 9), rep("1500-3500 ybp", 13), rep("4500-7500", 4))
nlep <- c(rep("0-1000 ybp", 14), rep("1500-3500 ybp", 7), rep("4500-7500", 4))
ncin <- c(rep("0-1000 ybp", 5), rep("1500-3500 ybp", 2), rep("4500-7500", 1))



#specifics

dmer <- c(rep("01-02", 6), rep("03-04", 6), rep("05-06", 2), rep("07-08", 3), rep("10", 2), rep("12", 3), rep("15-16", 3), rep("19-20", 2))
dmic <- c(rep("01-02", 4), rep("03-04", 3), rep("07-08", 1), rep("09", 3), rep("12", 1))
pman <- c(rep("01-02", 9), rep("03-04", 8), rep("07-08", 6), rep("10", 5), rep("11-12", 6), rep("17-18", 5), rep("19-20", 3))
cfor <- c(rep("0-1000 ybp", 9), rep("1500-3500 ybp", 15), rep("4500-7500", 9))
plong <- c(rep("01-02", 9), rep("07-08", 2), rep("09", 9), rep("10", 2), rep("15-16", 4))
nlep <- c(rep("01-02", 8), rep("03-04", 4), rep("05-06", 1), rep("07-08", 2), rep("09", 3), rep("10", 2), rep("15-16", 2), rep("17-18", 2))
ncin <- c(rep("0-1000 ybp", 5), rep("1500-3500 ybp", 2), rep("4500-7500", 1))
9, 8, 6, 5, 6, 5, 3
y2 <- y
y <- y[,-25]
45+72+27+75
yvar <- y

yall2 <- yall

y <- y[-13,]
yall2 <- yall2[-13,]17, 17 8
10, 14 ,11
vecs <- 
y <- cbind(y, spec = vec)

plot(pca$x[,1:2], asp=1, pch = 19, col = c(rep("darkgoldenrod1", 10 ), rep("darkgoldenrod3 ", 14), rep("darkgoldenrod4", 10), rep("cyan1", 7), rep("cyan3", 5), rep("darkcyan", 1), rep("firebrick1", 17), rep("firebrick3", 17), rep("firebrick4", 8), rep("darkseagreen1", 9), rep("darkseagreen3", 14), rep("darkseagreen4", 4), rep("tan", 14), rep("tan3", 8), rep("tan4", 5), rep("sienna1", 12), rep("sienna3", 11), rep("sienna4", 5)))

