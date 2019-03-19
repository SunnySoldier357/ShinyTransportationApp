# Transportation Application using Shiny Web Framework (R)

An application that allows the user to plan
their route through public transportation
in the Puget Sound region. The application is
broken up into 2 main pages: one to view nearby
routes and one to get directions.

## Viewing Nearby Routes

![View Nearby Routes Page](https://github.com/SunnySoldier357/ShinyTransportationApp/blob/master/Images/nearby-routes.png)

The page allows the user to select the nearest
town and city which allows the application
to provide more customised results. The routes
are also shown on the `leaflet` map. As shown in the following image, hovering over a
particular stop shows that stop's code and
clicking on the stop shows the stop's name.

![Leaflet Map Effects](https://github.com/SunnySoldier357/ShinyTransportationApp/blob/master/Images/leaflet-map-effects.png)

There is also a table shown below the map that
shows the user all the stops in an orderly
manner. The table allows the user to search as
well with pagination built in.

![Stops table](https://github.com/SunnySoldier357/ShinyTransportationApp/blob/master/Images/stops-table.png)

## Getting Directions

![Directions Page](https://github.com/SunnySoldier357/ShinyTransportationApp/blob/master/Images/directions.png)

The directions page has a similar layout to the
View Nearby Routes page. This page allows the
user to enter in the address of their starting
& destination location and the application will
show the reader the stops that need to be taken
to reach the destination.

Beneath the table, there is also a short summary
that tells the reader important details like the
number of stops as well as the actual stops that
correspond to the starting and destination
locations.

## Dependencies (R packages)

- `dplyr`
- `DT`
- `googlePolylines`
- `httr`
- `jsonlite`
- `leaflet`
- `shiny`
- `shinydashboard`
- `stringr`