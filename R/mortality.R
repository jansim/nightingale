#' Mortality in the Crimean War
#'
#' A dataset containing mortality data from the Crimean War, famously
#' visualized by Florence Nightingale. The data shows the number of deaths
#' from various causes.
#'
#' @format A data frame with 24 rows and 5 variables:
#' \describe{
#'   \item{date}{Date of the record, in YYYY-MM-DD format.}
#'   \item{disease}{Annual mortality rate per 1000 from preventable or mitigable zymotic diseases.}
#'   \item{wounds}{Annual mortality rate per 1000 from wounds.}
#'   \item{other}{Annual mortality rate per 1000 from all other causes.}
#'   \item{total}{Total annual mortality rate per 1000 from all causes.}
#' }
#' @source Florence Nightingale's data, as compiled and processed.
#' The raw data is from "Notes on Matters Affecting the Health, Efficiency, and Hospital Administration of the British Army" by Florence Nightingale, 1858. https://wellcomecollection.org/works/jxwtskzc/items?canvas=9
#' Extracted by Livnah from Datawrapper. https://www.datawrapper.de/blog/recreating-nightingale-rose-chart
"mortality"
