library(httr)
library(jsonlite)

apiWrapper <- setRefClass(
    "apiWrapper",
    fields = list(url = "character", apiKey = "character"),
    methods = list(

        #* Gets the JSON file from an API endpoint as a data frame
        getJsonFromUrl = function(path)
        {
            fromJSON(paste(url, path, sep = ""))
        }
    )
)