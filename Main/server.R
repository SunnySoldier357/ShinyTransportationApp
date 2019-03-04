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
        
        coor <<- gWrapper$forwardGeocoding(input$startingPoint)
        coor2 <<- gWrapper$forwardGeocoding(input$destination)
        
        if (length(coor) != 0 && length(coor2) != 0)
        {
            startingStop <- tWrapper$getStopsForLocation(coor$lat, coor$lon, 5000)
            destinationStop <- tWrapper$getStopsForLocation(coor2$lat, coor2$lon, 5000)

            # Get the first stop for the location and the id associated with it

            stops <- directions$directionsBetweenRoutes("1_64530", "1_64549")
            print(class(stops))

            output$map <- renderLeaflet(
            {
                leaflet(stops) %>%
                    addTiles() %>%
                    addMarkers(label = ~code, popup = ~name) %>%
                    addPolylines(lat = ~lat, lng = ~lon, data = stops)
            })
            
            output$summary <- renderText(
            {
                paste("Number of stops:", nrow(stops))
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