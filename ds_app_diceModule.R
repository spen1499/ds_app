ds_app_diceUI <- function(id, start_value) {
  ns <- NS(id)
  numericInput(
    ns("ndice"),
    label = id,
    value = start_value
  )
}

ds_app_diceSV <- function(input, output, session) {
  dice <- reactive({
    input$ndice
  })
  return(dice)
}