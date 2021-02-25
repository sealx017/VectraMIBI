#' @title Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param train_data to the input file
#' @param is.log to the input file
#' @return A matrix of the infile
#' @export

training_part<-function(train_data, is.log = FALSE){
  if(is.log==TRUE){
    training_dat = cbind(train_data$Group,log((train_data[,-1]+1),base = 2))
    colnames(train_data)[1] = "Group"
  }
  cl<-parallel::makePSOCKcluster(n_cores)
  doParallel::registerDoParallel(cl)
  classifier_rf  <- caret::train(Group~.,train_data,method="rf")
  parallel::stopCluster(cl)
  return(list(RFclassifier = classifier_rf, Proportion = proportion_getter(train_data)))
}
