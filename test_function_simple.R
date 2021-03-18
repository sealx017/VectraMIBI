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

test_function_simple<-function(test_data, RFclassi, is.log=FALSE)
{
  k = 1
  Predicted_data_frame = predict(RFclassi, test_data)
  return(Predicted_data_frame)
}
