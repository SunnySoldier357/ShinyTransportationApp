library(shiny)
library(dplyr)
library(DT)
library(leaflet)
library(googlePolylines)
library(stringr)

source("../Models/transportationApiWrapper.R")
source("../Models/geocodingApiWrapper.R")

tWrapper <- transportationApiWrapper()
gWrapper <- geocodingApiWrapper()

function(input, output, session)
{
    coor <- NULL
    routes <- data.frame()
    
    observeEvent(input$routeGoButton,
    {
        coor <<- gWrapper$forwardGeocoding(input$routeLocation)
        routes <<- tWrapper$getRoutesForLocation(coor$lat, coor$lon, 5000, NULL)
        
        updateSelectInput(session, inputId = "routeSelectInput",
                          choices = paste(routes$shortName, ": ", routes$description, sep = ""))
    })
    
    observeEvent(input$routeSelectInput,
    {
        if (input$routeSelectInput != "")
        {
            tWrapper <- transportationApiWrapper()

            routes <- routes %>% filter(
                shortName == substr(input$routeSelectInput, 1,
                    str_locate(input$routeSelectInput, "[:]") - 1))
            
            routeId <- routes$id

            stops <- tWrapper$getStopsForRoute(routeId)
            
            polylines <- select(tWrapper$getPolylinesForRoute(routeId), "points")

            polylinesList <- as.list(polylines)
            polylinesList <- polylinesList$points

            allPolylines <- decode(polylinesList)
            allPolylines <- bind_rows(allPolylines)
            
            output$routeMap <- renderLeaflet(
            {
                leaflet(stops) %>%
                    addCircles() %>%
                    addTiles() %>%
                    addPolylines(lat = ~lat, lng = ~lon, data = allPolylines)
            })
            
            output$routeTable <- DT::renderDataTable(
            {
                DT::datatable(data = select(stops, code, direction, name))
                
            })
        }
    })
    
    observeEvent(input$goButton,
    {
        # Validation
        validated <- TRUE
        
        output$map <- renderLeaflet(
        {
            stops <- tWrapper$getStopsForRoute("1_100091")
            
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