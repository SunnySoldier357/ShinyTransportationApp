stop <- setRefClass(
    "stop",
    fields = list(
        id = "character",
        lat = "numeric",
        lon = "numeric",
        name = "character",
        routeIds = "list"
    ),
    methods = list(
        new = function(dataFrame)
        {
            id <<- dataFrame$id
            lat <<- dataFrame$lat
            lon <<- dataFrame$lon
            routeIds <<- dataFrame$routeIds
        }
    )
)