source("../Models/apiWrapper.R")

#* A class that gets data from the transportation API and return it in lists
transportationApiWrapper <- setRefClass(
    "transportationApiWrapper",
    contains = "apiWrapper",
    fields = list(),
    methods = list(

        #* Overrides the default constructor to provide default values
        initialize = function(..., url = "http://api.pugetsound.onebusaway.org/api/where/",
            apiKey = "3347298f-ecf4-45a4-98fe-5aff06696742")
        {
            callSuper(..., url = url, apiKey = apiKey)
        },

        #* Returns a list of polylines for a specified route
        getPolylinesForRoute = function(routeID)
        {
            # TODO: Exception handling
            
            path <- paste("stops-for-route/", routeID, ".json",
                          "?key=", apiKey,
                          "&version=", 2,
                          sep = "")

            getJsonFromUrl(path)$data$entry$polylines
        },

        #* Returns a list of routes
        # Search radius is optional
        getRoutesForLocation = function(lat, lon, radius, query)
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

            if (!is.null(query))
            {
                path <- paste(path,
                              "&query=", query,
                              sep = "")
            }

            # TODO: If nothing returns, increase search radius
            
            getJsonFromUrl(path)$data$list
        },

        #* Returns the stop corresponding to the given id
        getStop = function(id)
        {
            path <- paste("stop/",
                          id, ".json",
                          "?key=", apiKey,
                          sep = "")

            getJsonFromUrl(path)$data$entry
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
            
            getJsonFromUrl(path)$data$list
        },

        #* Returns a list of stops for a specified route
        getStopsForRoute = function(routeID)
        {
            path <- paste("stops-for-route/", routeID, ".json",
                          "?key=", apiKey,
                          "&version=", 2,
                          sep = "")

            getJsonFromUrl(path)$data$references$stops
        }
    )
)