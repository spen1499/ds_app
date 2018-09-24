##### config #####
rm(list = ls())
setwd("c:/Users/bryden.spencer/Desktop/Shiny Test/ds_app/")
options(shiny.port = 5112)

##### dependencies #####
library(shiny)
library(ggplot2)
library(tools)
returnDiceGrid <- function(nblack, nblue, norange) {
  black = c(0,1,1,1,2,2)
  blue = c(1,1,2,2,2,3)
  orange = c(1,2,2,3,3,4)
  dice_grid <- c(
    rep(list(black), nblack),
    rep(list(blue), nblue),
    rep(list(orange), norange)
  )
  rolls <- apply(expand.grid(dice_grid[sapply(dice_grid, length) >= 1]), 1, sum)
  return(rolls)
}

##### modules #####
source("./ds_app_diceModule.R")

##### components #####
ui <- source("./ds_appUI.R")$value
server <- source("./ds_appSV.R")$value

##### run #####
runApp(app = list(
  ui = ui,
  server = server)
)

