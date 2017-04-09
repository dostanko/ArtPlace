# ArtPlace

## Usage assumptions
1. Application assumed to be used for Sydney, neverthless user can add POI at any place on the map
1. To add new POI long tap should be used
1. New POI has default name "New Place"
1. If user doesn't allow to use location for application, places will not be sorted
1. User can get to Place Details Screen both from list and map view (tap pin title)
1. Was not tested for big number of places, but asummed there will not be a lot, as no paging or partial and async loading is implemented

## Implementation
1. Xcode Version 8.2.1, Swift
1. Universal
1. CoreData
1. MapKit
1. Application architecture devides logic to layers, so that they will be easily replacesable with other solutions (for example CoreData with other storage on network requests, make them async)


-- 9 hrs
