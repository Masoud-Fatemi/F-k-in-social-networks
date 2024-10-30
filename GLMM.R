#"F#ck in digital networks" by Laitinen, Mikko et al.
#This is the code for modelling GLMM tree presented in the article.
#Contact: paula.rautionaho@uef.fi

#Load data (txt file available in the GitHub repository)
glmm <- readxl::read_excel("fck_data.xlsx")

#factorize variables
col_names <- names(glmm)
glmm[,col_names] <- lapply(glmm[,col_names] , factor)

#order factors, relevels
glmm$freqmedian <- relevel(glmm$freqmedian, "Low")
glmm$NSI<-as.ordered(glmm$NSI)
glmm$network_size<-as.ordered(glmm$network_size)
str(glmm)

##activate package
library(glmertree)

#model the tree
gtmedian <- glmertree(freqmedian ~ 1|ID|variety + network_size + NSI, data = glmm, family=binomial)

#plot the tree
plot(gtmedian$tree, gp=gpar(fontsize=10))

#print specs
print(gtmedian)