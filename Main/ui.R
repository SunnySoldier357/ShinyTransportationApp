library(shiny)
library(DT)
library(leaflet)

htmlTemplate("template.html",
    table = DT::dataTableOutput(outputId = "table"),
    map = leafletOutput(outputId = "map")
)