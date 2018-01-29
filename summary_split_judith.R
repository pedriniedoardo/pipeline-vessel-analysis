library(tidyverse)
#read in the tables
#df <- read_csv("test_split.csv")
#identify all the csv files
folder<-"csv/split/"
file_name <- dir(folder)%>%
  str_subset(pattern = ".csv")
list_df <- lapply(file_name, function(x){
  read_csv(paste0(folder,x))
})
#give a name to the file in the list
names(list_df)<-file_name
#make the list as a single df
df<-bind_rows(list_df,.id = "image")
# summarise the pieces by the position of the xm
df%>%
  mutate(XM=factor(XM,labels = c("left","right")))%>%
  group_by(XM,image)%>%
  summarize(n=n())%>%
  spread(key = XM,value = n)
