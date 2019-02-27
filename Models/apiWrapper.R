library(httr)
library(jsonlite)

apiWrapper <- setRefClass(
    "apiWrapper",
    fields = list(url = "character", apiKey = "character"),
    methods = list(
        getJsonFromUrl = function(path)
        {
            result <- GET(paste(url, path, sep = "", collapse = ""))

            # Converts from binary to unicode and then to a data frame based on
            # JSON structure
            fromJSON(rawToChar(result$content))
        }
    )
)