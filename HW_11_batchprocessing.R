# Homework #11: Batch processing
# Madelynn Edwards
# BIO 6100


# load packages ----
library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)
library(stringr)

# source function files (from barracudar) - not sure if we needed these?
source("barracudar/DataTableTemplate.R")
source("barracudar/AddFolder.R")
source("barracudar/BuildFunction.R")
source("barracudar/MetaDataTemplate.R")
source("barracudar/CreatePaddedLabel.R")
source("barracudar/InitiateSeed.R")
source("barracudar/SetUpLog.R")
source("barracudar/SourceBatch.R")
source("barracudar/QBox.R")
source("barracudar/QCon1.R")
source("barracudar/QCon2.R")
source("barracudar/QHist.R")
source("barracudar/QLogis.R")
#source("barracudar/QScat.R") generates unrelated graph
source("barracudar/QBub.R")
source("barracudar/QContour.R")

### 1. Data download :
# Sort by Site - BART 
# dataset for years 2013-2022
# 9 folders by year
# two 2020 files - covid = more field work?


### 2. Within each year’s folder, you will only be using a file from each year labeled “countdata” in its title. Using for loops, iterate through each year’s folders to gather the file names of these “countdata” .csv files.


#paste0() function
#paste0("Here is", "the", "filepath:", filelist[1])
setwd("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird")

getwd() # just checking - Was having a lot of issues with setting up working directory/couldn't change working directing sometimes


#list.files
filelist <- list.files()
filelist
filenames<-c()

for (i in 1:9){
setwd(paste0("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird","/", filelist[i]))
filenames[i] <- list.files(pattern = "count")
setwd("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird")
  }
filenames # 9 countdata files

### Questions 3-5: Using for loops to clean data (remove NAs), extract year, and calculate abundance and richness while generating a matrix.
 
# Cleaning the data for any empty/missing cases 
for(i in 1:9){
  setwd(paste0("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird", "/", filelist[i]))
  unclean_data <- read.csv(filenames[i])
  clean_data <- unclean_data %>% drop_na(observerDistance)# removing NAs from this column
  write.csv(clean_data, filenames[i]) # writing new csv with "cleaned" data
  setwd("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird")
}

# Extract the year from each file name 
year_vec <- NULL # creating empty vector for 4 loop

for(i in 1:9){ 
  year <- str_extract(filenames[i], pattern = "(?<=countdata.).*(?=-0)") 
  year_vec[i] <- year 
}

year_vec # vector of years 2015 - 2022


# Calculate Abundance for each year (Total number of individuals found)
matrix <- data.frame(matrix(ncol = 3, nrow = 9))#3 columns (year, abundance, richness), 9 rows
colnames(matrix) <- c("Year", "Abundance", "Richness")
matrix$Year <- year_vec

for(i in 1:9){
  setwd(paste0("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird", "/", filelist[i]))
  df <- read.csv(filenames[i])
  matrix[i,2] <- sum(df$clusterSize)
  setwd("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird")
}

matrix # year column and abundance column are now filled out


  #4) Calculate Species Richness for each year(Number of unique species found) 

for(i in 1:9) {
  setwd(paste0("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird", "/", filelist[i]))
  rich_df <- read.csv(filenames[i])
  matrix[i,3] <- length(unique(rich_df$taxonID)) 
  setwd("C:/Users/madel/Documents/CompBio/EdwardsBIO6100/NEON_count-landbird")
}

matrix # final matrix with columns Year, Abundance, and Richness filled out

## I think this homework was the most challenging... 


