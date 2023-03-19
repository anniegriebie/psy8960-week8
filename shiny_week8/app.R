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
        #selected plot to show scatter plot option
        mainPanel(
          plotOutput("plot")
        )
      )
)

#Server function
server <- function(input, output) {
  
  #using readRDS to rename skinny data
  shiny_data<-ReadRDS("shiny_data_week8.rds")
  
  #adding expression to generate scatter plot
  output$plot = renderPlot({
   
     shiny_data%>%
    #Adding option to filter gender when select something other than default "All"
    if(input$gender != "All") {
      filter(gender=input$gender)
    }
    #Adding option to filter participant finishing date
    if(input$error_band != "Include") {
      filter(timeEnd < "2017-08-01 00:00:00")}
    
    #Adding option to have or exclude error band
     })
      
    }
  
# Run the app
  shinyApp(ui =ui, server= server)
