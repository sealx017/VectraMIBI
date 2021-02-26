#'@title Generate Heatmap
#'
#' This function plots the heatmap of mean marker data for different cell types from the
#' training data.
#'
#' @param df Matrix of marker values (columns are different markers and rows are the cells)
#' @param is.log logical value denoting the need of log transformation.
#' @return A heatmap plot
#' @export
genheatmap<-function(df,is.log = FALSE)
{
 if(is.log==TRUE){
  df= cbind(df$Group,log((df[,-1]+1),base = 2))
  colnames(df)[1] = "Group"
 }
 summary_mean = df %>%
   group_by(Group) %>%
   summarise_all(mean, na.rm = TRUE)
 summary_mean = as.data.frame(summary_mean)
 rownames(summary_mean) = summary_mean[,1];
 summary_mean = summary_mean[,-1]
 return(pheatmap::pheatmap(t(summary_mean), cluster_cols = F, cluster_rows = F))
}
