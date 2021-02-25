
n_cores = parallel::detectCores()-1
cell_data = read.csv("Data/Full_cellData_pruned.csv")

#-----Summary of cell proportions-------------------
summ_cell(cell_data)

num_patients = length(unique(cell_data$SampleID))
df = cell_data[,-c(1,2)]

#-----Generate Heatmaps of different kinds------------
genheatmap(df,is.log=FALSE)
genheatmap(df,is.log=TRUE)

#------proportion finder-----------------
fin_prop(selected_data)


#------Ridge-plot generator--------------

interested_traits = c("Vimentin", "SMA", "CD45", "CD31", "Beta.catenin","Keratin6" )

sampling_scheme="random"
number_of_images_chosen = floor(num_patients*0.03)+1

chosen = NULL

sampling_scheme = "random"
is.log = "TRUE"

chosen_images = NULL
if(sampling_scheme=="random"){chosen_images = sample(1:num_patients,
number_of_images_chosen)}
chosen_images = unique(chosen_images)
nonchosen_images = setdiff(1:num_patients,chosen_images)
result = NULL
#run_train = training_part(chosen_images)

train_data = making_training_data(chosen_images,cell_data)
write.csv(train_data,file = "Data/Training_Data.csv",row.names=F)

knnclassi = run_train$knnclassifier
proportion = run_train$training_proportion
res = testing_function(proportion)

#------------------------------------------------------------------------



