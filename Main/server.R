library(shiny)
library(dplyr)
library(DT)
library(leaflet)
library(googlePolylines)

source("../Models/transportationApiWrapper.R")

wrapper <- transportationApiWrapper()

function(input, output, session)
{
    # Update all the choices for selectInput
    # routeList <- wrapper$getRoutesForLocation()
    
    updateSelectInput(session, inputId = "routeSelectInput",
                      choices = c("updated"))
    
    observeEvent(input$routeSelectInput,
    {
        output$routeMap <- renderLeaflet(
        {
            
        })

        output$routeTable <- DT::renderDataTable(
        {

        })
    })
    
    observeEvent(input$goButton,
    {
        # Validation
        validated <- TRUE
        
        output$map <- renderLeaflet(
        {
            stops <- wrapper$getStopsForRoute("1_100091")
            
            leaflet(stops) %>% addTiles() %>% addCircles()
        })
        
        output$summary <- renderUI(
        {
            
        })
        
        output$table <- DT::renderDataTable(
        {
            
        })
    })
}