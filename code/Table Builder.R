library(gplots)
library(huxtable)


#Create Vectors for each Variable
Species <- c("P. maniculatus", "N. lepida", "N. cinerea", "D. microps", "C. formosus", "P. parvus", "P. longimembris")
"Average Body Mass (g)" <- c("10-24", "122-350", "335", "55", "10-17", "20", "8-10")
"Functional Group" <- c("Omnivore", "Herbivore", "Herbivore", "Herbivore", "Granivore", "Granivore", "Granivore")

#Make a Data Frame
RodentTable <- data.frame(Species)

#Add Variables

RodentTable$"Average Body Mass (g)" <- `Average Body Mass (g)`
RodentTable$"Functional Group" <- `Functional Group`

#Convert to PDF
quick_pdf(RodentTable)
