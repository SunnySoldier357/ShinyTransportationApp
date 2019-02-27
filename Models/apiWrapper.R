library(httr)
library(jsonlite)

apiWrapper <- setRefClass(
    "apiWrapper",
    fields = list(url = "character", apiKey = "character"),
    methods = list(

        #* Gets the JSON file from an API endpoint as a data frame
        getJsonFromUrl = function(path)
        {
            result <- GET(paste(url, path, sep = ""))

            # Converts from binary to Unicode and then to a data frame based on
            # JSON structure
            fromJSON(rawToChar(result$content))
        }
    )
)