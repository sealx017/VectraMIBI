#' @title Generate Ridge plots
#'
#'This function generates ridge plot of a particular marker acroos different type of cells
#'for different images of the training datset
#' @param train_data the training dataset
#' @param interested_trait name of the marker of interest
#' @param is.log logical value, if TRUE, log transformed marker data will be considered
#' @return A matrix of the infile
#' @export

ridge_plotter<-function(train_data,interested_trait,is.log="TRUE")
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
  p = ggplot(fin_dat, aes(x = value, y = image_number, fill = Group)) +
  ggridges::geom_density_ridges(alpha = .5)+ggtitle(paste0("Ridge plot of ",
  interested_trait))+theme(axis.title.y = element_text(size = 0))
  print(p)
}


