library(shiny)
library(DT)
library(leaflet)

htmlTemplate("template.html",
    startingPoint = textInput(inputId = "startingPoint",
                              label = "Starting Location:"),
    destination = textInput(inputId = "destination",
                            label = "End Location:"),
    goButton = actionButton(inputId = "goButton",
                            label = "Go"),
    map = leafletOutput(outputId = "map"),
    summary = htmlOutput(outputId = "summary"),
    description = DT::dataTableOutput(outputId = "table")
)