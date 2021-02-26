#' @title Fits a random forest model on the train dataset
#'
#' This function fits a random forest model based on the training dataset.
#'
#' @param train_data is the training dataset
#' @param is.log  logical value denoting the need of log transformation. If its kept at TRUE, the same should be done
#' in test_function
#' @return A matrix of the infile
#' @export

training_part<-function(train_data, is.log = FALSE){
  if(is.log==TRUE){
    train_data = cbind(train_data$Group,log((train_data[,-1]+1),base = 2))
    colnames(train_data)[1] = "Group"
  }
  #colnames(train_data)[-1] = paste0("x",1:(ncol(train_data)-1))
  cl<-parallel::makePSOCKcluster(n_cores)
  doParallel::registerDoParallel(cl)
  classifier_rf  <- caret::train(Group~.,train_data,method="rf")
  parallel::stopCluster(cl)
  return(list(RFclassifier = classifier_rf, Proportion = proportion_getter(train_data)))
}
