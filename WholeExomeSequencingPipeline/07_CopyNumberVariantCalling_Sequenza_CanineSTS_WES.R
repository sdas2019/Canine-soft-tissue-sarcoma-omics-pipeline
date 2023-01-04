# R packages to load
library("BiocGenerics", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("S4Vectors", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("bitops", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("RCurl", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("IRanges", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("XVector", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("GenomeInfoDb", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("GenomeInfoDb", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("GenomeInfoDbData", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("GenomicRanges", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("zlibbioc", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("squash", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("copynumber", lib.loc="/projects/sdas@colostate.edu/app/R/")
library("sequenza", lib.loc="/projects/sdas@colostate.edu/app/R/")


#This is the R code for running sequenza
setwd("./")
data.filesample.name <- "../seqz/fname.code_small.seqz.gz"
seqzdatasample.name <- sequenza.extract(data.filesample.name)
fitsample.name <- sequenza.fit(seqzdatasample.name, chromosome.list = c(1:38, "X"))
sequenza.results(sequenza.extract = seqzdatasample.name, cp.table = fitsample.name, sample.id = "fname.code", out.dir="../seqz/fname.code",  chromosome.list = c(1:38, "X"))