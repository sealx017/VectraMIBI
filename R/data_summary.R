#' Summary of cell proportions
#'
#'This function provides a table of cell counts of different types in
#'the training dataset.
#'
#' @param cell_data The training dataset
#' @return A table of cell counts of different types
#' @export


summ_cell <- function(cell_data)
{
 summary_total_cells = cell_data %>% group_by(Group) %>% dplyr::summarise(total_cells = n())
 print(knitr::kable(summary_total_cells))
}
