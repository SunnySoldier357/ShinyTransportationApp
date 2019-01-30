library(shiny)
library(DT)

# input$lat
# input$lon
# input$radius
# input$routes - required to be dynamically updated based on previous inputs
# output#map
# output#table

routes <- read.csv("data/routes.csv")
stops <- read.csv("data/stops.csv")

server <- function(input, output)
{
    
    # Dynamically update the selectInput based on routes
    # Based on route chosen show table
}

shinyApp(ui = htmlTemplate("www/index.html"), server)