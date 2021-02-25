
testing_function<-function(proportion, is.log=FALSE)
{
  k = 1
  Predicted_data_frame = NULL
  for(i in c(1:num_patients))
  {
    data_image = selected_data[selected_data$SampleID==unique(selected_data$SampleID)[i],]
    data_indices = which(selected_data$SampleID==unique(selected_data$SampleID)[i])
    if(is.log == FALSE){
      uniq_dat = df[data_indices,-1]}
    else uniq_dat = df_log[data_indices,-1]
    test_dat = as.data.frame(uniq_dat)
    colnames(test_dat) = paste0("x",1:(ncol(test_dat)))
    Predictions = predict(knnclassi, test_dat)
    labels_test = df[data_indices,]$Group;
    if(i==1){Predicted_data_frame = data.frame(data_image[data_indices,1:2], Predicted = Predictions)}
    else{Predicted_data_frame = rbind(Predicted_data_frame,data.frame(data_image[data_indices,1:2],
    Predicted = Predictions))}
    k = k+1
  }

  return(Predicted_data_frame)
}
