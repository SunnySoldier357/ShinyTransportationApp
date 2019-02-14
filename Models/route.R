#* A class that is in charge of routes
route <- setRefClass(
    "route",
    fields = list(),
    methods = list(

        # TODO: Doc
        addressToCoordinates <- function(address)
        {
            # https://opencagedata.com/api
        },

        directionsBetweenRoutes <- function(starting, destination)
        {
            startingCoor <- addressToCoordinates(starting)
            destinationCoor <- addressToCoordinates(destination)
        }
    )
)