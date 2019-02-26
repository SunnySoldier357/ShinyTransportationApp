source("Models/apiWrapper.R")

wrapper <- apiWrapper()

#* A class that is in charge of routes
route <- setRefClass(
    "route",
    fields = list(),
    methods = list(

        # TODO: Doc
        addressToCoordinates = function(address)
        {
            # https://opencagedata.com/api
        },

        # starting & destination are stop classes
        # 1_64530 -> 1_81850
        # 1_65150 -> 1_81849
        directionsBetweenRoutes = function(starting, destination)
        {
            # Get the route for that stop and see if the other stop is in that route
            
        },
        
        getNearestStops = function(lat, long)
        {
            
        },
        
        possibleRoute = function(startingStop, destinationStops)
        {
            # start with a list of lists
            # go through each route of that stop and add it to the list
            # When one of the destinationStops is reached stop and return the list
            # of stops used and which routes
        },
    )
)