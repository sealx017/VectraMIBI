#' @title Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param RFclassi the input file
#' @param is.log to the input file
#' @return A matrix of the infile
#' @export

testing_function<-function(RFclassi, is.log=FALSE)
{
  k = 1
  Predicted_data_frame = NULL
  num_patients =  length(unique(full_data$SampleID))
  for(i in c(1:num_patients))
  {
    data_image = full_data[full_data$SampleID==unique(full_data$SampleID)[i],]
    data_indices = which(full_data$SampleID==unique(full_data$SampleID)[i])
    if(is.log == FALSE){
      uniq_dat = df[data_indices,-1]}
    else uniq_dat = df_log[data_indices,-1]
    test_dat = as.data.frame(uniq_dat)
    colnames(test_dat) = paste0("x",1:(ncol(test_dat)))
    Predictions = predict(RFclassi, test_dat)
    if(i==1){Predicted_data_frame = data.frame(data_image[,1:2], Predicted = Predictions)}
    else{Predicted_data_frame = rbind(Predicted_data_frame,data.frame(data_image[,1:2],
    Predicted = Predictions))}
    k = k+1
  }

  return(Predicted_data_frame)
}
