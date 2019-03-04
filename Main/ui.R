library(DT)
library(leaflet)
library(shiny)
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
                
                textOutput(outputId = "routeLocationError"),
                
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
                          label = "Starting Address:"),
                
                textInput(inputId = "destination",
                          label = "Destination Address:"),
                
                textOutput(outputId = "locationError"),
                
                actionButton(inputId = "goButton",
                             label = "Go"),
                
                leafletOutput(outputId = "map"),
                
                htmlOutput(outputId = "summary"),
                
                DT::dataTableOutput(outputId = "table")
            )
        )
    )
)