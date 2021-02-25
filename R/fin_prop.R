#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param selected_data Path to the input file
#' @return A matrix of the infile
#' @export

fin_prop<-function(selected_data)
{
 fin_prop = NULL
 for(k in 1:num_patients)
 {
  data_image = selected_data[selected_data$SampleID==unique(selected_data$SampleID)[k],]
  uniq_dat = data_image[!duplicated(data_image),]
  if(k == 1){fin_prop = data.table(proportion_getter(uniq_dat))}
  else {z = data.table(proportion_getter(uniq_dat));
  fin_prop = plyr::rbind.fill(fin_prop, z)}
 }
 fin_prop = cbind(fin_prop,rowSums(fin_prop,na.rm = T))
 colnames(fin_prop)[ncol(fin_prop)] = "Total"
 return(fin_prop)
}
