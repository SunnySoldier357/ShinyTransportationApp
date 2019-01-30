library(shiny)

# input$lat
# input$lon
# input$radius
# input$routes - required to be dynamically updated based on previous inputs
# output#map
# output#table

routes <- readcsv()
stops <- readcsv()

server <- function(input, output)
{
    output$
}

shinyApp(ui = htmlTemplate("www/index.html"), server)