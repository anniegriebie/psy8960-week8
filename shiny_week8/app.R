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
          selectInput("error_band", "Display or Supress Error Band:", choices =c("Display Error Band" = "TRUE", "Suppress Error Band" = "FALSE"), selected = "Display Error Band"),
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
  shiny_data<-read_rds("shiny_data_week8.rds")
  
  #adding expression to generate scatter plot
  output$plot = renderPlot({
   
     shiny_data%>%
    #Adding option to filter gender when select something other than default "All"
    filter(if(input$gender != "All") gender==input$gender else TRUE) %>%
  
    #Adding option to filter participant finishing date
   filter(if(input$date_completed != "Include") timeEnd < "2017-08-01 00:00:00" else TRUE) %>%
    
    #Creating ggplot
    ggplot(aes(x=meanQ1Q6, y=meanQ8Q10))+
    geom_point() +
    geom_smooth(method ="lm", color="purple", se=as.logical(input$error_band))+
      labs(x="Mean score Q1-Q6", y= "Mean score Q8-Q10")
    
     })
      
    }
  
# Run the app
  shinyApp(ui =ui, server= server)
