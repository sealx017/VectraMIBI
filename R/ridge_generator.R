require(ggplot2)
ridge_plottter<-function(train_data,interested_trait,is.log="TRUE")
{
  fin_dat = NULL
  j = 1
  chosen_images = unique(train_data$SampleID)
  for(x in chosen_images){
    image_data = train_data[train_data$SampleID==x,]
    if(is.log != TRUE){fin_dat = rbind(fin_dat,data.frame(value = image_data[,interested_trait],
    Group = image_data$Group, image_number = paste0("image number = ", x)))}
    else{
    fin_dat = rbind(fin_dat,data.frame(value = log((image_data[,interested_trait]+1),base = 2),
    Group = image_data$Group, image_number = paste0("image number = ", x)))}
    j = j+1
  }
  fin_dat$image_number = as.factor(fin_dat$image_number)
  fin_dat$Group = as.factor(fin_dat$Group)

  #fin_dat  = fin_dat[fin_dat$Group=="Mesenchymal-like",]
  p = ggplot(fin_dat, aes(x = value, y = image_number, fill = Group)) +
  ggridges::geom_density_ridges(alpha = .5)+ggtitle(paste0("Ridge plot of ",
  interested_trait))+theme(axis.title.y = element_text(size = 0))
  print(p)
}


