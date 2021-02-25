#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param data Path to the input file
#' @return A matrix of the infile
#' @export
proportion_getter<-function(data)
{
  prop = NULL
  i = 1
  for(x in unique(data$Group))
  {
    res = data.frame(length(which(data$Group==x)))
    colnames(res) = paste0(x)
    if(i==1){prop = res}
    else prop = data.frame(prop,res)
    i = i+1
  }
  colnames(prop) = unique(data$Group)
  return(prop)
}
