library(shiny)
library(dplyr)
library(DT)
library(leaflet)
library(googlePolylines)

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
        coor <- gWrapper$forwardGeocoding(input$routeLocation)
        routes <- tWrapper$getRoutesForLocation(coor$lat, coor$lon, 5000, NULL)
        print(class(routes))
        
        updateSelectInput(session, inputId = "routeSelectInput",
                          choices = routes$shortName)
    })
    
    observeEvent(input$routeSelectInput,
    {
        if (!is.na(as.numeric(input$routeSelectInput)))
        {
            routes %>% filter(shortName == input$routeSelectInput)
            
            routeId <- routes$id

            stops <- tWrapper$getStopsForRoute(routeId)

            polylines <- select(wrapper$getPolylinesForRoute(routeId), "points")

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
                DT::datatabke(data = stops)
            })
        }
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