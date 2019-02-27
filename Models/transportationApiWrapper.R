library(httr)
library(jsonlite)

url <- "http://api.pugetsound.onebusaway.org/api/where/"
apiKey <- "3347298f-ecf4-45a4-98fe-5aff06696742"

#* Gets JSON file from the URL above appended with the path specified and returns
#* a JSON object
getJsonFromURL <- function(path)
{
    result <- GET(paste(url, path, sep = "", collapse = ""))

    # Converts from binary to unicode and then to an object based on json structure
    fromJSON(rawToChar(result$content))
}

#* A class that gets data from the API and return it in lists
transportationApiWrapper <- setRefClass(
    "transportationApiWrapper",
    fields = list(),
    methods = list(

        #* Returns a list of polylines for a specified route
        getPolylinesForRoute = function(routeID)
        {
            path <- paste("stops-for-route/", routeID, ".json",
                          "?key=", apiKey,
                          "&version=", 2,
                          sep = "")

            getJsonFromURL(path)$data$entry$polylines
        },

        #* Returns a list of routes
        # Search radius is optional
        getRoutesForLocation = function(lat, lon, radius)
        {
            path <- paste("routes-for-location.json?key=", apiKey,
                          "&lat=", lat,
                          "&lon=", lon,
                          sep = "")
            if (isTRUE(radius > 0))
            {
               path <- paste(path,
                             "&radius=", radius,
                             sep = "")
            }

            # TODO: If nothing returns, increase search radius
            
            getJsonFromURL(path)$data$list
        },

        getStop = function(id)
        {
            path <- paste("stop/",
                          id, ".json",
                          "?key=", apiKey,
                          sep = "")

            getJsonFromURL(path)$data$entry
        },

        #* Returns a list of stops
        # Search radius is optional
        getStopsForLocation = function(lat, lon, radius)
        {
            path <- paste("stops-for-location.json?key=", apiKey,
                          "&lat=", lat,
                          "&lon=", lon,
                          sep = "")
            if (isTRUE(radius > 0))
            {
               path <- paste(path,
                             "&radius=", radius,
                             sep = "")
            }

            # TODO: If nothing returns, increase search radius
            
            getJsonFromURL(path)$data$list
        },

        #* Returns a list of stops for a specified route
        getStopsForRoute = function(routeID)
        {
            path <- paste("stops-for-route/", routeID, ".json",
                          "?key=", apiKey,
                          "&version=", 2,
                          sep = "")

            getJsonFromURL(path)$data$references$stops
        }
    )
)