fluidPage(
  tags$head(tags$style(HTML(
    "
  .container-fluid {margin-top:0px;padding-top:0px}  
  .well {margin-top:0px;padding-top:10px;padding-bottom:10px}
  h2 {margin-top:10px;padding-top:0px}
  h3 {margin-top:0px;padding-top:0px}
  "
  ))),    
  titlePanel("DS Title"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(width = 12, title = "Attack",
               h3("Dice"),
               splitLayout(
                 ds_app_diceUI("Black", 1),
                 ds_app_diceUI("Blue", 0),
                 ds_app_diceUI("Orange", 0),
                 ds_app_diceUI("+X", 0),
                 cellWidths = c("20%")
               )
      ),
      fluidRow(width = 12, title = "Enemy",
               h3("Enemy"),
               splitLayout(
                 ds_app_diceUI("Defense", 1),
                 ds_app_diceUI("HP", 1),
                 cellWidths = c("20%")
               )
      )
    ),
    
    mainPanel(
      plotOutput("dice_barplot")
    )
  )
)