#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param cell_data Path to the input file
#' @return A matrix of the infile
#' @export

summ_cell <- function(cell_data)
{
 summary_total_cells = cell_data %>% dplyr::group_by(Group) %>% dplyr::summarise(total_cells = n())
 print(knitr::kable(summary_total_cells))
}
