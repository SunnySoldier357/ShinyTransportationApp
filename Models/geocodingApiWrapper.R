source("../Models/apiWrapper.R")
source("../Models/coordinate.R")

#* A class that gets data from the geocoding API
geocodingApiWrapper <- setRefClass(
    "geocodingApiWrapper",
    contains = "apiWrapper",
    methods = list(

        #* Overrides the default constructor to provide default values
        initialize = function(..., url = "https://api.opencagedata.com/",
            apiKey = "c8d5d8eab7934476a8a768f6e8046039")
        {
            callSuper(..., url = url, apiKey = apiKey)
        },

        #* Returns a Coordinate based on the place name entered
        forwardGeocoding = function(placename)
        {
            path <- paste("geocode/v1/json",
                          "?q=", placename,
                          "&key=", apiKey,
                          "&pretty=", 1,
                          "&countrycode=", "us",
                          "&no_annotations", 1,
                          sep = "")

            data <- getJsonFromUrl(path)$results$geometry

            if (length(data) == 0)
            {
                # Return NULL
                NULL
            }
            else
            {
               coordinate$new(lat = data$lat, lon = data$lng)
            }
        }
    )
)