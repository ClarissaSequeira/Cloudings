ptm<- proc.time()

#Import dataset

wine_data<-read.csv("C:/Users/clari/Desktop/Cloud/Cloudings/titanic/wine.csv",header=TRUE,na.strings=c(""))
wine_new<-wine_data
wine_new$Type<-NULL
names(wine_new)

#Scaling. All values are in different scale so its very hard to compare one column to another. So we'll normalize our data. so normalize it with mean 0 and standard deviation.

wine_new<-scale(wine_new[-1])

# k-means Clustering

results<-kmeans(wine_new,3)

#print(results)

#Interpretation and evaluation through Confusion Matrix

table(wine_data$Type,results$cluster)

ptm<- proc.time()-ptm

print(ptm)
