library(shiny)
library(dplyr)
library(DT)
library(leaflet)

source("apiWrapper.R")

wrapper <- apiWrapper()

# input$lat
# input$lon
# input$radius
# input$routes - required to be dynamically updated based on previous inputs
# output#map
# output#table

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(),
        
        mainPanel(
            DT::dataTableOutput(outputId = "table"),
            leafletOutput("map")
        )
    )
)

server <- function(input, output, session)
{
    
    # Dynamically update the selectInput based on routes

    stops <- wrapper$getStopsForRoute("1_100091")
   
    # Based on route chosen show table
    output$table <- DT::renderDataTable(
    {
        DT::datatable(data = stops)
    })
    
    output$map <- renderLeaflet(
    {
        leaflet(stops) %>% addCircles() %>% addTiles()
    })
}

# shinyApp(ui = htmlTemplate("www/index.html"), server)
shinyApp(ui, server)