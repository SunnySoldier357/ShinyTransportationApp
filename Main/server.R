library(shiny)
library(dplyr)
library(DT)
library(leaflet)
library(googlePolylines)

source("../Models/apiWrapper.R")

wrapper <- apiWrapper()

# input$lat
# input$lon
# input$radius
# input$routes - required to be dynamically updated based on previous inputs
# output#map
# output#table

getPolylinesFromDF <- function(dataFrame)
{
    polylines <- select(polylines, "points")

    polylinesList <- as.list(polylines)
    polylinesList <- polylinesList$points

    allPolylines <- decode(polylinesList)
    allPolylines <- bind_rows(allPolylines)
}

function(input, output, session)
{
    # Dynamically update the selectInput based on routes
    stops <- wrapper$getStopsForRoute("1_100091")

    # Geting Polylines for Route
    polylines <- wrapper$getPolylinesForRoute("1_100091")
    polylines <- select(polylines, "points")
    polylinesList <- as.list(polylines)
    polylinesList <- polylinesList$points
    
    allPolylines <- decode(polylinesList[[1]])
    polylinesDF <- allPolylines[[1]]

    # Based on route chosen show table
    output$table <- DT::renderDataTable(
    {
        DT::datatable(data = stops)
    })

    output$map <- renderLeaflet(
    {
        leaflet(stops) %>%
            addCircles() %>%
            addTiles() %>%
            addPolylines(lat = ~lat, lng = ~lon, data = getPolylinesFromDF(wrapper$getPolylinesForRoute("1_100091")))
    })
}