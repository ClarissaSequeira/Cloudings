# Install packages if R Studio doesn't come with them already
# These packages are needed to mine text
# Only need to execute following execution once
Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc")
install.packages(Needed, dependencies=TRUE)
install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source")

# Load the following R libraries for text mining
library("NLP")
library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")
library("cluster")
library("fpc")

# Save text file(s) to mine into 'texts' directory
# Tell R Studio where to find text file(s)

# For Ubuntu
cname <- file.path("texts")

# For Mac OS
#cname <- file.path("~", "Downloads", "texts")

# For Windows OS
# cname <- file.path("C:", "texts")

cname
dir(cname)



# Run analysis
# Load texts into R
docs <- Corpus(DirSource(cname))
summary(docs)

# Preprocessing
# Remove punctuation
docs <- tm_map(docs, removePunctuation)

# Convert all text to lowercase
docs <- tm_map(docs, tolower)

# Turn text into plain text document
docs <- tm_map(docs, PlainTextDocument)

# Stage the Data
ptm <- proc.time()

dtm <- DocumentTermMatrix(docs)
dtm
tdm <- TermDocumentMatrix(docs)
tdm

ptm <- proc.time() - ptm
print(ptm)

# Explore the data
freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq)
m <- as.matrix(dtm)
dim(m)
write.csv(m, file="DocumentTermMatrix.csv")

# Consider the 6 most frequent words
freq[tail(ord)]

