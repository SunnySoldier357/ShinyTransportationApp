library(shiny)
library(dplyr)
library(DT)
library(leaflet)
library(googlePolylines)

source("../Models/apiWrapper.R")

wrapper <- apiWrapper()

#* Inputs:
#  startingPoint (textInput)
#  destination (textInput)
#  goButton (actionButton)

#* Outputs:
#  map (leafletOutput)
#  summary (htmlOutput)
#  description (DT::dataTableOutput)

#! Route Class
#   - Route detection (Lev distance)
#   - public method that takes 2 addresses and determines the best route between them

function(input, output, session)
{
    observeEvent(input$goButton,
    {
        # Validation
        validated <- TRUE
        
        
        
        output$map <- renderLeaflet(
        {
            leaflet() %>% addTiles()
        })
        
        output$summary <- renderUI(
        {
            
        })
        
        output$table <- DT::renderDataTable(
        {
            
        })
    })
}