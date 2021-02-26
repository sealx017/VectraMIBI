
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
