n_cores = parallel::detectCores()-1
full_data = read.csv("Data/Full_cellData_pruned.csv")
train_data = read.csv("Data/Training_Data.csv")

#-----Summary of cell proportions-------------------
summ_cell(full_data)

num_patients = length(unique(full_data$SampleID))
df = train_data[,-c(1,2)]

#-----Generate Heatmaps of different kinds------------
genheatmap(df,is.log=FALSE)
genheatmap(df,is.log=TRUE)

#------proportion finder-----------------
fin_prop(full_data)


#------Ridge-plot generator--------------

interested_traits = c("Vimentin", "SMA", "CD45", "CD31", "Beta.catenin","Keratin6" )
interested_trait = c("Vimentin")
ridge_plottter(train_data,interested_trait,is.log="TRUE")

#------Fitting Random Forest-------------

run_train = training_part(training_dat = train_data[,-c(1,2)])
RFclassi = run_train$RFclassifier
proportion = run_train$Proportion
res = testing_function(proportion)

#------------------------------------------------------------------------



