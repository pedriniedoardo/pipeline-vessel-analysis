library(tidyverse)
#read in the tables
#df <- read_csv("test_split.csv")
#identify all the csv files
folder<-"test_mask_line_csv/csv/"
file_name <- dir(folder)%>%
  str_subset(pattern = ".csv")
list_df <- lapply(file_name, function(x){
  d <- read_csv(paste0(folder,x))
  d[-1,]
})
#give a name to the file in the list
names(list_df)<-file_name
#make the list as a single df
df<-bind_rows(list_df,.id = "image")
# summarise the pieces by the position of the xm
df%>%
  mutate(BX=factor(BX,labels = c("left","middle","right")))%>%
  group_by(BX,image)%>%
  summarize(n=n())%>%
  spread(key = BX,value = n)

# make a plot
df%>%
  mutate(BX=factor(BX,labels = c("left","middle","right")))%>%
  group_by(BX,image)%>%
  summarize(n=n())%>%
  spread(key = BX,value = n)%>%
  gather(key = position,value = val,-image)%>%
  ggplot(aes(x=position,y = val,group=image))+geom_line()
