library(shiny)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("darkly"),
  img(src = "zidane.jpg",width = "30%"),
  
  titlePanel("Programmation Statistique"),
  sidebarLayout(
    sidebarPanel(
      textInput("chartTitle", "Titre du graphique :", "Zidane meilleur joueur all time"),
      uiOutput("xColumnSelector"),
      actionButton("plotBtn", "Créer un graphique")
    ),
    mainPanel(
      apexchartOutput("apexPlot")
    )
  )
)