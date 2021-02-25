VectraMIBI\_example
================

## VectraMIBI

This is an R package for visualization and supervised cell annotation of
Vectra Polaris and MIBI data. The package provides basic marker
visualization tools like: heat-map and ridge plot. Given a set of
annotated training images, it can also perform a random forest based
cell phenotyping for non-annotated images.

# 

First we load the required packages and import the training dataset
(named as “train\_data”) which has marker data for different cells from
different images and all the cells are annotated. The first two columns
of the training dataset respectively correspond to the image number and
the cell number inside that image number.

``` r
require(VectraMIBI)
# Loading required package: VectraMIBI
require(dplyr)
# Loading required package: dplyr
# 
# Attaching package: 'dplyr'
# The following objects are masked from 'package:stats':
# 
#     filter, lag
# The following objects are masked from 'package:base':
# 
#     intersect, setdiff, setequal, union
require(data.table)
# Loading required package: data.table
# 
# Attaching package: 'data.table'
# The following objects are masked from 'package:dplyr':
# 
#     between, first, last
require(pheatmap)
# Loading required package: pheatmap
require(ggplot2)
# Loading required package: ggplot2
require(ggridges)
# Loading required package: ggridges

n_cores = parallel::detectCores()-1
full_data = read.csv("Data/Full_cellData_pruned.csv")
train_data = read.csv("Data/Training_Data.csv")
```

``` r
#-----Summary of cell proportions-------------------
summ_cell(full_data)
# 
# 
# |Group                  | total_cells|
# |:----------------------|-----------:|
# |Endothelial            |        2089|
# |Immune                 |       83336|
# |Keratin-positive tumor |      102736|
# |Mesenchymal-like       |        8479|
# |Tumor                  |        3177|
# |Unidentified           |        1839|
```

``` r
#-----Generate Heatmaps of different kinds------------
df = train_data[,-c(1,2)]
#genheatmap(df,is.log=FALSE)
genheatmap(df,is.log=TRUE)
```

<img src="README_files/figure-gfm/heatmap-1.png" width="100%" />

``` r
#------Ridge-plot generator--------------

#interested_traits = c("Vimentin", "SMA", "CD45", "CD31", "Beta.catenin","Keratin6" )
interested_trait = c("Vimentin")
ridge_plottter(train_data,interested_trait,is.log="TRUE")
# Picking joint bandwidth of 0.371
```

<img src="README_files/figure-gfm/ridge plots-1.png" width="100%" />

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

``` r
summary(cars)
#      speed           dist       
#  Min.   : 4.0   Min.   :  2.00  
#  1st Qu.:12.0   1st Qu.: 26.00  
#  Median :15.0   Median : 36.00  
#  Mean   :15.4   Mean   : 42.98  
#  3rd Qu.:19.0   3rd Qu.: 56.00  
#  Max.   :25.0   Max.   :120.00
```

## Including Plots

You can also embed plots, for example:

<img src="README_files/figure-gfm/pressure-1.png" width="100%" />

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
