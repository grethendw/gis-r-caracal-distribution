
# GIS-R-Caracal-Distribution

<!-- badges: start -->
<!-- badges: end -->

<br/>

The goal of GIS-R-Caracal-Distribution is to map caracal sightings reported on iNaturalist and the Urban Caracal Project. 

To achieve this, iNaturalist data was mapped using the mapview package, 
Movebank data was mapped with leaflet, 
and a combined map was made using ggspatial.

The files in this GitHub repository are:

<br/>

#### Main Branch
1. **Caracal-Distribution-Writeup** (.Rmd and .html), which is the description of the process and code used to create the maps.
2. **Caracal-Map.R** is the R code used to create the maps.
3. **GIS-R-Caracal-Distribution.Rproj** contains project-specific settings.

<br/>

#### Data

*Note: There is no data frame for iNaturalist as the data were pulled directly to R via the rinat package.*

1. **jasper_movebank.csv** is the data frame used to map the movement of a single caracal using Movebank data.

<br/>

#### Jasper Data Columns Explained
1. **Event ID:** the unique identifier for each observation
2. **Visible:** whether the observation is visible on the Movebank map
3. **Timestamp:** date and time corresponding to a sensor measurement
4. **Location long:** geographic longitude of where the observation was made
5. **Location lat:** geographic latitude of where the observation was made
6. **GPS HDOP:** Horizontal Dilution of Precision provided by the GPS
7. **Sensor type:** type of sensor used to collect the data
8. **Individual taxon canonical name:** scientific name of the animal observed
9. **Tag local identifier:** ID tag provided by data owner (UCP, in this case)
10. **Individual local identifier:** individual ID for the animal observed, e.g. its name and tag code
11. **Study name:** name of the study in Movebank

For more information on the variables included in this dataset, go to the [Movebank Attribute Dictionary](https://www.movebank.org/cms/movebank-content/movebank-attribute-dictionary)


