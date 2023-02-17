# calculate rasch model
#!/bin/bash

install.packages("eRm", repos = "http://cran.us.r-project.org")
install.packages("ltm", repos = "http://cran.us.r-project.org")
install.packages("readxl", repos = "http://cran.us.r-project.org")

library("eRm")
library("ltm")
library("readxl")

# import and preprocess
data <- read.csv(file='learning_data.csv')

print('read')
print(summary(data))

namen <- data$UserID
data$UserID <- NULL
rownames(data) <- namen
#data <- data[0:50,0:800]
data <- as.data.frame(data)#apply(data, 2, as.numeric)
write.csv(data,"temp.csv")

#rasch model
result <- RM(data)
summary(result)

#save results
options(max.print = 30000)       
out <- capture.output(summary(result))
cat("result", out, file="summary_result.txt", sep="\n")
#plot result
#plotjointICC(result)

#calc person parameter
personparameters <- person.parameter(result)
plot(personparameters)
summary(personparameters)

#LRtest(result)
#qchisq(0.95,df=21)

#save results
options(max.print = 30000)       
out <- capture.output(summary(personparameters))
cat("personparameters", out, file="summary_pp.txt", sep="\n")




