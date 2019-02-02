library(shiny)
library(dplyr)
library(DT)
library(leaflet)

# input$lat
# input$lon
# input$radius
# input$routes - required to be dynamically updated based on previous inputs
# output#map
# output#table

routes <- read.csv("data/routes.csv")
stops <- read.csv("data/stops.csv")

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
    # observeEvent(input$radius,
    # {
    #     routeDescriptions <- c()
    #     i <- 1
    #
    #     for (description in select(routes, "description"))
    #     {
    #         routeDescriptions[i] <- description
    #         i <- i + 1
    #     }
    #
    #     input$routes <- selectInput(inputId = "routes",
    #                                 choices = routeDescriptions,
    #                                 label = "Test Label")
    #
    #     updateSelectInput(session, input$routes,
    #                       # options = select(routes, "description"),
    #                       label = "Changed")
    # })
   
    # Based on route chosen show table
    # output$table <- DT::renderDataTable(
    # {
    #     DT::datatable(data = stops)
    # })
  
    output$table
    
    # output$map <- renderLeaflet(
    # {
    #     leaflet(stops) %>% addCircles()
    #     # leaflet(data.frame(lat = 1:10, long = rnorm(10))) %>% addCircles()
    # })
}

shinyApp(ui = htmlTemplate("www/index.html"), server)
# shinyApp(ui, server)