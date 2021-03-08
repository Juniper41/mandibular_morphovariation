library(gplots)
library(huxtable)


#Create Vectors for each Variable
Species <- c("Peromyscus maniculatus", "Neptoma lepida", "Neotoma cinerea", "Dipodomys microps", "C formosus", "Dipodomys", "P. longimembris")
"Average Body Mass (g)" <- c("10-24", "122-350", "335", "55", "10-17", "20", "8-10")
"Functional Group" <- c("Omnivore", "Herbivore", "Herbivore", "Herbivore", "Granivore", "Granivore", "Granivore")


Species <- c("Chaetodipus formosus", "Dipodomys merriami", "Dipodomys microps", "Neotoma cinerea", "Neotoma lepida", "Peromyscus maniculatus *", "Perognathus longimembris")
"Average Body Mass (g)" <- c("10-17", "55", "55", "335", "122-350", "10-24", "8-10")
"Functional Group" <- c("Granivore", "Granivore", "Herbivore", "Herbivore", "Herbivore", "Omnivore", "Granivore")


#Make a Data Frame
RodentTable <- data.frame(Species)

#Add Variables

RodentTable$"Average Body Mass (g)" <- `Average Body Mass (g)`
RodentTable$"Functional Group" <- `Functional Group`

#Convert to PDF
quick_pdf(RodentTable)
yplot(y[,8:9])
