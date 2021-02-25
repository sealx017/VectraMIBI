#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param df Path to the input file
#' @return A matrix of the infile
#' @export
genheatmap<-function(df,is.log = FALSE)
{
 if(is.log==TRUE){
  df= cbind(df$Group,log((df[,-1]+1),base = 2))
  colnames(df)[1] = "Group"
 }
 summary_mean  = as.data.frame(data.table::setDT(df)[, lapply(.SD, mean), keyby = Group])
 rownames(summary_mean) = summary_mean[,1];
 summary_mean = summary_mean[,-1]
 return(pheatmap::pheatmap(t(summary_mean), cluster_cols = F, cluster_rows = F))
}
