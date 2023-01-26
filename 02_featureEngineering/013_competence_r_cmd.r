#!/bin/bash

install.packages("eRm", repos = "http://cran.us.r-project.org")
install.packages("ltm", repos = "http://cran.us.r-project.org")
#install.packages("difR", repos = "http://cran.us.r-project.org")
install.packages("readxl", repos = "http://cran.us.r-project.org")

library("eRm")
library("ltm")
#library("difR")
library("readxl")

# import and preprocess
data <- read.csv(file='learning_data.csv')

print('read')
#print(summary(data))

namen <- data$UserID
data$UserID <- NULL
rownames(data) <- namen
#data <- data[0:50,0:800]
data <- as.data.frame(data)#apply(data, 2, as.numeric)
#print(summary(data))
write.csv(data,"t.csv")

print('rasch')

#rasch model
result <- RM(data)
summary(result)

print('save')

#save results
options(max.print = 30000)       
out <- capture.output(summary(result))
cat("result", out, file="summary_result.txt", sep="\n")

#plot result
#plotjointICC(result)

print('pp')

#calc person parameter
pp <- person.parameter(result)
#plot(pp)
summary(pp)


#LRtest(result)
#qchisq(0.95,df=21)

print('save')
#save results
options(max.print = 30000)       
out <- capture.output(summary(pp))
cat("pp", out, file="summary_pp.txt", sep="\n")




