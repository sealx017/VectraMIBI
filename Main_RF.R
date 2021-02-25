
n_cores = parallel::detectCores()-1
#cell_data = read.csv("Data/cellData.csv")
#groups = c("Unidentified", "Immune", "Endothelial", "Mesenchymal-like", "Tumor", "Keratin-positive tumor")
#cell_data$Group = as.factor(cell_data$Group)
#levels(cell_data$Group) <- groups
#write.csv(cell_data,"Data/Full_cellData.csv",row.names = F)
cell_data = read.csv("Data/Full_cellData.csv")
columns_of_interest = c(1,2,55,11,12,14:40,42,43,45,48,49)
#write.csv(cell_data[,columns_of_interest],"Data/Full_cellData_pruned.csv",row.names = F)
cell_data = read.csv("Data/Full_cellData_pruned.csv")

#-----Summary of cell proportions-------------------
summ_cell(cell_data)

#selected_cols = names(cell_data)[columns_of_interest]
#selected_data = cell_data[,selected_cols]
#only_markers = Matrix::Matrix(t(as.matrix(selected_data[,-c(1:4)])),sparse = TRUE)

num_patients = length(unique(selected_data$SampleID))
df = selected_data[,-c(1:3)]

#-----Generate Heatmaps of different kinds------------
genheatmap(df,is.log=FALSE)
genheatmap(df,is.log=TRUE)

#------proportion finder-----------------
fin_prop(selected_data)


#------Ridge-plot generator--------------

interested_traits = c("Vimentin", "SMA", "CD45", "CD31", "Beta.catenin","Keratin6" )

sampling_scheme="random"
number_of_images_chosen = floor(num_patients*0.1)+1

chosen = NULL

sampling_scheme = "random"
is.log = "TRUE"

chosen_images = NULL
if(sampling_scheme=="random"){chosen_images = sample(1:num_patients,
                                                       number_of_images_chosen)}
chosen_images = unique(chosen_images)
nonchosen_images = setdiff(1:num_patients,chosen_images)
result = NULL
run_train = training_part(chosen_images)
#save(run_train,file = "/Users/seals/Desktop/CSPH/New_vectra/Feb12/training_with_five_random_images.Rdata")

knnclassi = run_train$knnclassifier
proportion = run_train$training_proportion
res = testing_function(proportion)

#------------------------------------------------------------------------



