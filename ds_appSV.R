ds_appSV <- function(input, output) {
  black_dice <- callModule(module = ds_app_diceSV, id = "Black")
  blue_dice <- callModule(module = ds_app_diceSV, id = "Blue")
  orange_dice <- callModule(module = ds_app_diceSV, id = "Orange")
  modifier <- callModule(module = ds_app_diceSV, id = "+X")
  enemy_defense <- callModule(module = ds_app_diceSV, id = "Defense")
  enemy_hp <- callModule(module = ds_app_diceSV, id = "HP")
  
  rolls <- reactive({
    returnDiceGrid(
      nblack = black_dice(),
      nblue = blue_dice(),
      norange = orange_dice()
    ) 
  })
  
  output$dice_barplot <- renderPlot({
    return0 <- function(x) {ifelse(x <= 0, 0, x)}
    adjusted <- return0(rolls() - enemy_defense() + modifier())
    frame <- data.frame(round(prop.table(table(adjusted)), 2))
    frame$target <- ifelse(
      as.character(frame$adjusted == 0), "miss",
      ifelse(as.character(frame$adjusted) >= enemy_hp(), "kill", "hit")
    )
    frame_caption <- paste0("Kill chance: ", sum(frame$Freq[frame$target == "kill"]) * 100, "%",
                    "Damage chance: ", sum(frame$Freq[frame$target == "hit"]) * 100, "%",
                    "Miss chance: ", sum(frame$Freq[frame$target == "miss"]) * 100, "%"
    )
    
    ggplot(frame, aes(x = frame$adjusted, y = frame$Freq)) + 
      geom_bar(
        stat = "identity", aes(fill = frame$target)
      ) +
      geom_label(
        aes(label = paste0(Freq*100, "%"))
      ) + 
      scale_y_continuous(
        labels = function(x) {paste0(x*100, "%")}
      ) + 
      scale_fill_manual(
        values = c(hit = "steelblue", miss = "grey", kill = "red")
      ) + 
      labs(
        y = "", 
        x = ""
      ) +
      theme(
        panel.background = element_blank(), 
        axis.text = element_text(size = 15),
        axis.ticks = element_blank()
      ) +
      guides(fill = F)
  })
  
}