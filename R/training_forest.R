training_part<-function(training_dat, is.log = FALSE){
  if(is.log==TRUE){
    training_dat = cbind(training_dat$Group,log((training_dat[,-1]+1),base = 2))
    colnames(training_dat)[1] = "Group"
  }
  cl<-parallel::makePSOCKcluster(n_cores)
  doParallel::registerDoParallel(cl)
  classifier_rf  <- caret::train(Group~.,training_dat,method="rf")
  parallel::stopCluster(cl)
  return(list(RFclassifier = classifier_rf, Proportion = proportion_getter(training_dat)))
}
