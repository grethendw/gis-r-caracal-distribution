
# GIS-R-Caracal-Distribution

<!-- badges: start -->
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/grethendw/gis-r-caracal-distribution/HEAD)
<!-- badges: end -->

<br/>

The goal of GIS-R-Caracal-Distribution is to map caracal sightings reported on iNaturalist and the Urban Caracal Project. 

To achieve this, iNaturalist data was mapped using the mapview package, 
Movebank data was mapped with leaflet, 
and a combined map was made using ggspatial.

The files in this GitHub repository are:

<br/>

#### Main Branch
1. **Caracal-Distribution-Writeup** (.Rmd and .html) describes of the workflow (process and code) used to create the maps.
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

<br/>

#### Workflow 

*See Caracal-Distribution-Writeup.Rmd for more detail.*

<br/>

##### Packages used

* rinat
* sf
* tidyverse
* rosm
* ggspatial
* leaflet
* mapview
* leafpop
* move2

<br/>

##### iNaturalist data

iNaturalist data (.csv) was read into R using the rinat package. 
The data was for reported sightings of caracals (*Caracal caracal*) in the Cape Peninsula.

Some observations had their locations obscured by the users who submitted the sightings, so some caracals appeared in the middle of the ocean.
These entries were removed using the filter function.

The data frame was converted to a simple feature object using st_as_sf() so that it could be used for mapping.

The spatial data was then mapped using the mutate(), rename() and mapview() functions.
The result was an interactive map where users can select individual observations and see the iNaturalist entry (who submitted it, the link to the observation, and the picture).

<br/>

##### Movebank data

A study by Serieys and Bishop (2024) stored a caracal distribution dataset on Movebank, which was accessed via the [Movebank website](https://www.movebank.org/cms/webapp?gwt_fragment=page=studies,path=study1832666571) by searching "caracal".
The raw Movebank dataset has over 57,000 observations, so a single caracal was selected for the purpose of this project. 
The data was altered on a new Excel spreadsheet (leaving the raw data intact) so that a smaller file could be loaded onto R. 
The selected caracal is called Jasper-TMC08 and had roughly 1,300 observations in the Cape Peninsula.

Jasper's distribution data were mapped using ggplot() and leaflet().

The result was an interactive map with a zoom function overlaid on the City of Cape Town's road map.

<br/>

##### Combined map

A map combining the iNaturalist and Movebank data was made using ggplot(). 
This is a static map of caracal distribution in the Cape Peninsula.


