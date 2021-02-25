
making_training_data<-function(chosen_images,selected_data = cell_data)
{
 i = 1
 for(x in chosen_images){
  data_image = selected_data[selected_data$SampleID==unique(selected_data$SampleID)[x],]
  #data_indices = which(selected_data$SampleID==unique(selected_data$SampleID)[x])
  # if(is.log == TRUE){
  #   df = cbind(df$Group,log((df[,-1]+1),base = 2))
  #   colnames(df)[1] = "Group"
  # }
  #uniq_dat = data_image[data_indices,]
  assign(paste0("image",i),data_image)
  i = i+1
 }
 i = 1
 for(x in chosen_images){
  if(i==1){Training.data = get(paste0("image",i));
  #labels_train = as.matrix(get(paste0("image",i))[,1])
  }
  else{Training.data = plyr::rbind.fill(Training.data,get(paste0("image",i)));
  #labels_train = rbind(labels_train,as.matrix(get(paste0("image",i))[,1]))
  }
  i = i+1
}
 #training_dat = data.frame(as.matrix(Training.data), Group = labels_train)
 #colnames(training_dat)[-ncol(training_dat)] = paste0("x",1:(ncol(training_dat)-1))
 #training_dat$Group = as.factor(training_dat$Group)
 #return(training_dat)
 return(Training.data)
}
