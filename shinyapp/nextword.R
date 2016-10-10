
library(tm)

MAX_N_GRAMS = 3
TOP_FREQ = 5

# read data files to configure the app
df_bigrams <- readRDS("data/bigrams.rds")
df_trigrams <- readRDS("data/trigrams.rds")
df_fourgrams <- readRDS("data/fourgrams.rds")

msg <- ""

# these functions makes cleansing in input parameter

removeWhiteSpaces <- function(str) {
  return( gsub("\\s+"," ",str) )
}

# dataframe 'badwords' was previosly saved
# prof <- read.csv("badwords.txt", header=FALSE, stringsAsFactors=FALSE)
# saveRDS(prof,"badwords.rds")

removeBadwords <- function(str) {
  dfBadWords <- readRDS("data/badwords.rds")
  nWords <- nrow(dfBadWords)
  for(i in 1:nWords)
  	str <- gsub(dfBadWords[i,1],"*",str, perl=TRUE)
  return(str)
}

cleanPhrases <- function(x) {
  # convert to lowercase
  x <- tolower(x)
  # remove numbers
  x <- gsub("\\S*[0-9]+\\S*", " ", x)
  # change common hyphenated words to non
  x <- gsub("e-mail","email", x)
  # remove any brackets at the ends
  x <- gsub("^[(]|[)]$", " ", x)
  # remove any bracketed parts in the middle
  x <- gsub("[(].*?[)]", " ", x)
  # remove punctuation, except intra-word apostrophe and dash
  x <- gsub("[^[:alnum:][:space:]'-]", " ", x)
  x <- gsub("(\\w['-]\\w)|[[:punct:]]", "\\1", x)
  # compress and trim whitespace
  x <- gsub("\\s+"," ",x)
  x <- gsub("^\\s+|\\s+$", "", x)
  return(x)
}

# this function acts as this example:
# find_last_words( "If I want to only the last three words it returns this way", 3 ) ==> "returns this way"

find_last_words <- function(lst, n) {
  x <- as.data.frame(strsplit(lst, " "))
  colnames(x) <- c("words")
  len <- nrow(x)
  if(len<n) n<-len
  lst <- paste(x[ (len-(n-1)) : len ,], collapse=" ")
  return(lst)
}

# some heuristcs applyed before returning to the server interface

contractions <- function(token) {
  token <- gsub("^s\\s","\'s ",token)
  token <- gsub("^n\\s","\'n ",token)
  token <- gsub("^d\\s","\'d ",token)
  token <- gsub("^t\\s","\'t ",token)
  token <- gsub("^ve\\s","\'ve ",token)
  token <- gsub("^ll\\s","\'ll ",token)
  token <- gsub("^re\\s","\'re ",token)
  return(token)
}

# collect the top frequent words from unigram table and return in a vector

topFrequencyWords <- function(n=TOP_FREQ) {
  df_unigrams <- readRDS("data/unigrams.rds")
  nrows <- nrow(df_unigrams)
  vTop <- vector("list", length=25)
  for(i in seq_len(25))
    vTop[i] <- as.character(df_unigrams[i,1])
  return(head(vTop,n))
}

# the objective of this function is find the most probable word in a n-gram dataframe , given a group of n last words

find_in_words <- function(lastWord, n) {
  lastWord <- paste0('^',lastWord,' ')
  
  len <- length(lastWord)
  if (n < 1) {
    stop("find_in_words() error: number of last word  < 0")
  }

  # points the search to correspondent 'n-gram' dataframe
  dfSearch <- data.frame()

  # subset 'n-gram' dataframe to find the most probable occurrences
  if(n==3)
    #Check4Gram 
    dfsub <- subset(df_fourgrams, grepl(lastWord, df_fourgrams$Word)) 
  else
    if(n==2)
      #Check3Gram
      dfsub <- subset(df_trigrams, grepl(lastWord, df_trigrams$Word))  
    else
      if(n==1)
        #Check2Gram
	      dfsub <- subset(df_bigrams, grepl(lastWord, df_bigrams$Word))#Check3Gram 


  if(nrow(dfsub) > 0) {
    # if matches, return the 5 (or TOP_FREQ) top Words (without any spaces)
    top5words <- head(contractions(gsub(lastWord,"",dfsub$Word)),TOP_FREQ)
    #top5words <- heuristics(top5words)
    msg <<- sprintf("Next word was predicted with %1d-gram dataframe.",(n+1))
    return( gsub("[[:space:]]"," ",top5words) )
  }
  else{
    n <- n-1;
    if(n > 0) {
      lastWord <- substr(lastWord,2,nchar(lastWord))
      find_in_words( find_last_words(lastWord,2), n )
    }
    else {
      lastWord <- substr(lastWord,2,nchar(lastWord))
      msg <<- paste("Next word not found in 2, 3 or 4-grams dataframes.\nReturning the",TOP_FREQ,"most frequent words of uni-gram.")
      return(topFrequencyWords(TOP_FREQ))
    }
  }
}

predict_model <- function(user_input) {
  return( find_in_words( find_last_words(user_input, MAX_N_GRAMS), n=MAX_N_GRAMS) )
}


