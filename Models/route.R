source("apiWrapper.R")

wrapper <- apiWrapper()

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

            # Get 3 stops closest to the startingCoor as well as destination
            #   (must be close enough to the location)
            # Do "Lev distance algorithm" to determine routes from those stops
            #   to one of the destination stops
            # Calculate the distance of the routes and return the best 3
        },
        
        getNearestStops <- function(lat, long)
        {
            
        },
        
        possibleRoute <- function(startingStop, destinationStops)
        {
            # start with a list of lists
            # go through each route of that stop and add it to the list
            # When one of the destinationStops is reached stop and return the list
            # of stops used and which routes
        },
    )
)