#Tree Builder

library(phylogram)
library(ape)
library(phytools)

###Set your species Vector###
rodentstring <- "((D. microps,(C. formosus,(P. longimembris,P. parvus))),(P. maniculatus,(N. lepida, N. cinerea)));"


#Set X to Read Species Vector
x <- read.dendrogram(text = "((D. microps,(C. formosus,(P. longimembris,P. parvus))),(P. maniculatus,(N. lepida, N. cinerea)));")
plot(x, yaxt = "n")


#Alternative Tree Builder using APE

rodentstring <- "((D. microps,(C. formosus,(P. longimembris,P. parvus))),(P. maniculatus,(N. lepida, N. cinerea)));"

x <- read.tree(text=rodentstring)
plot(x)

#Rounded Tree
roundPhylogram(x)

#Thicket Branching
plot(unroot(x),type="unrooted",no.margin=TRUE,lab4ut="axial",
     edge.width=2)

#Alternative Formatting
x <- read.dendrogram(text = "((a,(b,(c,d))),(e,(f,g)));")
plot(x, yaxt = "n")