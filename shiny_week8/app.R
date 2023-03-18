library(shiny)
library(tidyverse)

ui <- fluidPage(

      titlePanel("Week 8 Shiny")
  
      sidebarLayout(
        sidebarPanel(
            
          selectInput("gender", "Gender:", choices = c("Male", "Female", "All"), selected = "All")
        )
      )
)