library(shiny)
library(dplyr)
library(apexcharter)
library(readxl)

loadDefaultData <- function() {
  fichier <- "Chiens.xlsx"
  data <- read_xlsx(fichier)
  data <- data %>%
    select(-any_of(c("date_debut", "id_client")), everything())
  return(data)
}

server <- function(input, output) {
  data <- loadDefaultData()
  
  output$xColumnSelector <- renderUI({
    selectInput("xcol", "Sélectionnez une colonne :", 
                choices = names(data), selected = names(data)[1])
  })
  
  apexChart <- reactive({
    req(input$plotBtn, input$xcol)
    x <- input$xcol
    data_summary <- as.data.frame(table(data[[x]]))
    colnames(data_summary) <- c("Catégorie", "Fréquence")
    data_summary <- head(data_summary[order(data_summary$Fréquence, decreasing = TRUE), ], 10)
    
    apex(data_summary, type = "bar", aes(x = Catégorie, y = Fréquence)) %>%
      ax_title(text = input$chartTitle) %>%
      ax_theme("dark")
  })
  
  output$apexPlot <- renderApexchart({
    apexChart()
  })
}
