
summary_testing_function<-function(proportion)
{
 k = 1
 for(i in c(1:num_patients))
 {
  data_image = selected_data[selected_data$SampleID==unique(selected_data$SampleID)[i],]
  data_indices = which(selected_data$SampleID==unique(selected_data$SampleID)[i])
  if(is.log == FALSE){
    uniq_dat = df[data_indices,-1]}
  else uniq_dat = df_log[data_indices,-1]
  test_dat = as.data.frame(uniq_dat)
  colnames(test_dat) = paste0("x",1:(ncol(test_dat)))
  Predictions <- predict(knnclassi, test_dat)
  labels_test = df[data_indices,]$Group;
  fk_data <- data.frame(True = labels_test , Predicted = Predictions)
  table_fk = table(fk_data$True,fk_data$Predicted)
  total = sum(table_fk)
  table_fk_p = table_fk[,rownames(table_fk)]
  #print.table(table_fk_p)
  measure = sum(diag(table_fk_p))/total;names(measure) = "Total"
  pop = rowSums(table_fk_p)
  if(is.null(dim(table_fk_p))==T){indiv = table_fk_p/pop}
  else indiv = (diag(table_fk_p))/pop
  len = total
  image_number = i;names(image_number) = "image number"
  if(k==1){
    result_1 = as.data.frame(t(c(pop,image_number)))
    result_2 = as.data.frame(t(c(indiv,measure,image_number)))
  }else{
    result_1 = plyr::rbind.fill(as.data.frame(result_1),as.data.frame(t(c(pop,image_number))))
    result_2 = plyr::rbind.fill(as.data.frame(result_2), as.data.frame(t(data.frame(c(indiv,measure,image_number)))))
  }
  print(i)
  k = k+1
 }
 chosen = matrix(chosen_images,ncol = 1)
 fin_result = list(NULL)
 for(i in 1:length(proportion))
 {
  sel_1 = result_1[,c(i,ncol(result_1))];colnames(sel_1)[1] = "Frequency"
  sel_2 = result_2[,c(i,ncol(result_2))];colnames(sel_2)[1] = "Prediction Accuracy"
  assign(paste0("type",i),merge(sel_1,sel_2,by="image number"))
  fin_result[[i]] = get(paste0("type",i))
 }

 return(list(imagewise_result = fin_result,categories = colnames(result_1)))
 }
