library(httr)
library(jsonlite)

url <- "http://api.pugetsound.onebusaway.org/api/where/"
apiKey <- "3347298f-ecf4-45a4-98fe-5aff06696742"

apiWrapper <- setRefClass(
    "apiWrapper",
    fields = list(),
    methods = list(

        # Search radius is optional
        #* Returns a list of routes
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

            result <- GET(paste(url, path, sep = ""))

            # Converts from binary to unicode and then to an object based on json structure
            json <- fromJSON(rawToChar(result$content))
            
            json$data$list
        }
    )
)