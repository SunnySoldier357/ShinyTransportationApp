library(shiny)
library(DT)
library(leaflet)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Seattle Transportation"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("View Nearby Routes", tabName = "viewroutes"),
            menuItem("Directions", tabName = "directions")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "viewroutes",
                textInput(inputId = "routeLocation",
                          label = "Enter your city:"),
                
                actionButton(inputId = "routeGoButton",
                             label = "Go"),
                
                selectInput(inputId = "routeSelectInput",
                            label = "Select Route:",
                            choices = c("")),
                
                leafletOutput(outputId = "routeMap"),
                
                DT::dataTableOutput(outputId = "routeTable")
            ),
            
            tabItem(tabName = "directions",
                textInput(inputId = "startingPoint",
                                          label = "Starting Location:"),
                
                textInput(inputId = "destination",
                                        label = "End Location:"),
                
                actionButton(inputId = "goButton",
                                        label = "Go"),
                
                leafletOutput(outputId = "map"),
                
                htmlOutput(outputId = "summary"),
                
                DT::dataTableOutput(outputId = "table")
            )
        )
    )
)