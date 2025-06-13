#' Launch Shiny Dashboard for Mortality Data
#'
#' This function launches a Shiny dashboard that displays the bar plot of
#' mortality data. Users can select the causes of death to display and toggle
#' the vertical line marking Nightingale's improvements.
#'
#' @details
#' The dashboard provides an interactive interface for visualizing mortality
#' data from the Crimean War. Users can:
#' - Select specific causes of death to display in the bar plot.
#' - Toggle the visibility of a vertical line that marks the implementation
#'   of Nightingale's sanitary improvements in February 1855.
#'
#' The bar plot is generated using the `show_barplot()` function, and the
#' data is dynamically filtered based on user input.
#'
#' @seealso
#' \code{\link{show_barplot}} for the function that generates the bar plot.
#'
#' @examples
#' if (interactive()) {
#'   run_shiny()
#' }
#'
#' @export
run_shiny <- function() {
  requireNamespace(shiny)

  ui <- shiny::fluidPage(
    titlePanel("Mortality Data Dashboard"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "selected_causes",
          "Select Causes of Death:",
          choices = colnames(mortality)[-1], # Exclude the 'date' column
          selected = colnames(mortality)[-1],
          size = 4,
          selectize = FALSE,
          multiple = TRUE
        ),
        checkboxInput(
          "show_vline",
          "Show date of Nightingale's Improvements",
          value = TRUE
        )
      ),
      mainPanel(
        plotOutput("barplot")
      )
    )
  )

  server <- function(input, output, session) {
    output$barplot <- renderPlot({
      show_barplot(
        mortality_data = mortality,
        selected_cols = input$selected_causes,
        show_vline = input$show_vline
      )
    })
  }

  shinyApp(ui, server)
}
