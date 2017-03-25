
ptm<- proc.time()

#Make sure that the parameter na.strings is equal to c("") so that each missing value is coded as a NA

training_data<-read.csv("C:/Users/clari/Desktop/Cloud/Cloudings/titanic/train.csv",header=TRUE,na.strings=c(""))

#check for missing values and look how many unique values there are for each variable using the sapply() function which applies the function passed as argument to each column of the dataframe.

sapply(training_data,function(x) sum(is.na(x)))
sapply(training_data,function(x) length(unique(x)))

#The variable cabin has too many missing values, we will not use it. We will also drop PassengerId since it is only an index and Ticket.
#Using the subset() function we subset the original dataset selecting the relevant columns only.

data <- subset(training_data,select=c(2,3,5,6,7,8,10,12))

#Treating missing values

data$Age[is.na(data$Age)] <- mean(data$Age,na.rm=T)
data <- data[!is.na(data$Embarked),]


#Model fitting

set.seed(1024)
div<-sample(2,nrow(data),replace=TRUE,prob=c(0.7,0.3))
train <- data[div==1,]
test <- data[div==2,]

model <- glm(Survived ~.,family=binomial(link='logit'),data=train)
summary(model)

#Interpretation

fitted.results <- predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8)),type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)
misClasificError <- mean(fitted.results != test$Survived)
print(paste('Accuracy',1-misClasificError))

ptm<- proc.time()-ptm

print(ptm)




