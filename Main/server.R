library(dplyr)
library(DT)
library(googlePolylines)
library(leaflet)
library(shiny)
library(stringr)

source("../Models/geocodingApiWrapper.R")
source("../Models/route.R")
source("../Models/transportationApiWrapper.R")

tWrapper <- transportationApiWrapper()
gWrapper <- geocodingApiWrapper()

function(input, output, session)
{
    #* View Routes Page
    coor <- NULL
    routes <- data.frame()
    
    observeEvent(input$routeGoButton,
    {
        coor <<- gWrapper$forwardGeocoding(input$routeLocation)

        if (length(coor) != 0)
        {
            routes <<- tWrapper$getRoutesForLocation(coor$lat, coor$lon, 5000, NULL)
        
            updateSelectInput(session, inputId = "routeSelectInput",
                              choices = paste(routes$shortName, ": ", routes$description, sep = ""))
            
            output$routeLocationError <- renderText(
            {
                ""
            })
        }
        else
        {
            output$routeLocationError <- renderText(
            {
                "The location you entered resulted in an error. Ensure that the locating entered is right."
            })
        }
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

    #* Directions Page
    observeEvent(input$goButton,
    {
        directions <- route$new()

        output$map <- renderLeaflet(
        {
            stops <- directions$directionsBetweenRoutes("1_64530", "1_81850")
            
            leaflet(stops) %>%
                addTiles() %>%
                addCircles() %>%
                addPolylines(lat = ~lat, lng = ~lon, data = stops)
        })
        
        output$summary <- renderUI(
        {
            
        })
        
        output$table <- DT::renderDataTable(
        {
            
        })
    })
}