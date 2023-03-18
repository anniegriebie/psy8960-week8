library(shiny)
library(tidyverse)

#Define ui
ui <- fluidPage(
      #Added generic title
      titlePanel("Week 8 Shiny"),
      sidebarLayout(
        sidebarPanel(
          #Added option to show subsets of participant by gender, with All as default  
          selectInput("gender", "Gender:", choices = c("Male", "Female", "All"), selected = "All"),
          #Added option to show or supress error band on plot, with dipaly of error band set as default
          selectInput("error_band", "Display or Supress Error Band:", choices =c("Display Error Band", "Suppress Error Band"), selected = "Display Error Band"),
          #Added option to include or exclude participants who completed assignement before given date, with exclude set to default
          selectInput("date_completed", "Include or Exclude paticipants who completed assessment before August 1, 2017", choices=c("Include", "Exclude"), selected="Exclude"),
        ),
        mainPanel(
          plotOutput("plot")
        )
      )
)