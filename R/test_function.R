#' @title Use the fitted random forest model on the test dataset
#'
#' This function predicts the cell types of the test dataset which must have same number of
#' covariates as the train dataset.
#' @param test_data the input test dataset
#' @param RFclassi the fitted random forest model
#' @param is.log logical value denoting the need of log transformation. Should only be TRUE
#' if the train_function also have it as TRUE.
#' @return A data.frame with all the cells of the test dataset along with their predicted classes
#' @export

test_function<-function(test_data, RFclassi, is.log=FALSE)
{
  k = 1
  Predicted_data_frame = NULL
  num_patients =  length(unique(test_data$SampleID))
  for(i in c(1:num_patients))
  {
    data_image = test_data[test_data$SampleID==unique(test_data$SampleID)[i],]
    data_indices = which(test_data$SampleID==unique(test_data$SampleID)[i])
    if(is.log == FALSE){
      uniq_dat = df[data_indices,]}
    else uniq_dat = log(df[data_indices,]+1,base = 2)
    test_dat = as.data.frame(uniq_dat)
    #colnames(test_dat) = paste0("x",1:(ncol(test_dat)))
    Predictions = predict(RFclassi, test_dat)
    if(i==1){Predicted_data_frame = data.frame(data_image[,1:2], Predicted = Predictions)}
    else{Predicted_data_frame = rbind(Predicted_data_frame,data.frame(data_image[,1:2],
    Predicted = Predictions))}
    k = k+1
  }

  return(Predicted_data_frame)
}
