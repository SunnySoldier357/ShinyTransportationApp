source("../Models/transportationApiWrapper.R")

wrapper <- transportationApiWrapper()

#* A class that is in charge of routes
route <- setRefClass(
    "route",
    fields = list(),
    methods = list(

        # starting & destination are stop ids
        # 1_64530 -> 1_81841
        # Swedish Issaquah, 751 Northeast Blakely Drive, Issaquah, WA 98029, United States of America
        # 23350 Southeast Black Nugget Road, Issaquah, WA 98029, United States of America
        directionsBetweenRoutes = function(starting, destination)
        {
            # Get the route for that stop and see if the other stop is in that route
            startingStop <- wrapper$getStop(starting)
            destinationStop <- wrapper$getStop(destination)

            # Loop over starting stops's route ids

            matchingRouteId <- startingStop$routeIds

            stopsInStartingRoute <- wrapper$getStopsForDirections(matchingRouteId)

            if (destinationStop$id %in% stopsInStartingRoute$id)
            {
                startingID <- match(startingStop$id, stopsInStartingRoute$id)
                destinationID <- match(destinationStop$id, stopsInStartingRoute$id)

                stopList <- as.data.frame(stopsInStartingRoute)[startingID:destinationID,]

                stopList
            }
            else
            {
                # Start with a collection
                # In a loop until the destination id is found, go through each
                #    stop and split off into the next stop in the route
                # Save all of these
            }
        }
    )
)