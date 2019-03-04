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
                    addMarkers(label = ~code, popup = ~name) %>%
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
        
        # coor <<- gWrapper$forwardGeocoding(input$startingPoint)
        # coor2 <<- gWrapper$forwardGeocoding(input$destination)
        
        coor <- "sdawdaw"
        coor2 <- "awasdawd"
        
        if (length(coor) != 0 && length(coor2) != 0)
        {
            # startingStop <- tWrapper$getStopsForLocation(coor$lat, coor$lon, 100)$id
            # destinationStop <- tWrapper$getStopsForLocation(coor2$lat, coor2$lon, 100)$id
            
            startingStop <- "1_64530"
            destinationStop <- "1_81841"

            stops <- directions$directionsBetweenRoutes(startingStop, destinationStop)

            output$map <- renderLeaflet(
            {
                leaflet(stops) %>%
                    addTiles() %>%
                    addMarkers(label = ~code, popup = ~name) %>%
                    addPolylines(lat = ~lat, lng = ~lon, data = stops)
            })
            
            output$summary <- renderUI(
            {
                text <- paste("Number of stops:", nrow(stops), "\n")
                text1 <- paste("Starting Stop: ", stops[1:1,]$name, "\n", sep = "")
                text2 <- paste("Destination Stop: ", stops[nrow(stops):nrow(stops),]$name, "\n", sep = "")
                
                HTML(paste(text, text1, text2, sep = "<br/>"))
            })
            
            output$table <- DT::renderDataTable(
            {
                DT::datatable(data = select(stops, code, direction, name))
            })
            
            output$locationError <- renderText(
            {
                ""
            })
        }
        else
        {
            output$locationError <- renderText(
            {
                "The location you entered resulted in an error. Ensure that the locating entered is right."
            })
        }
    })
}