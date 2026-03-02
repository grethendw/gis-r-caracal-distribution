getwd()
# "/Users/User/Documents/GIT/gis-r-caracal-distribution/GIS-R-Caracal-Distribution"
# I know, I know. It didn't need a subfolder but we're here now.


#### Load packages ----
install.packages("remotes")
library("rinat")

install.packages("sf")
library(sf)

library(tidyverse)

install.packages("rosm")
library(rosm)

install.packages("ggspatial")
library(ggspatial)

install.packages("prettymapr")
library(prettymapr)

install.packages("leaflet")
library(leaflet)

install.packages("htmltools")
library(htmltools)

install.packages("mapview")
library(mapview)

install.packages("leafpop")
library(leafpop)

install.packages("move2")
library(move2)


#### Gather iNaturalist data ----

# Get latest 300 recorded caracal sightings 
# using rinat and sf packages
inat_cara <- get_inat_obs(taxon_name = "Caracal caracal", 
                   bounds = c(-35, 18, -33.5, 18.5), 
                   quality = "research",
                   maxresults = 300)

# There are a bunch of "swimming" caracals in the middle of the ocean, 
# so results with obscured locations are going to be removed
inat_cara <- inat_cara %>%
  filter(is.na(geoprivacy)) %>%
  filter(!is.na(latitude) & !is.na(longitude))

# Inspect
head(inat_cara)
tail(inat_cara)
class(inat_cara)

# Make the dataframe a spatial object of class = "sf"
inat_cara_sf <- st_as_sf(inat_cara, coords = c("longitude", "latitude"), crs = 4326)

# Check class of cara_move_sf 
class(inat_cara_sf)
# [1] "sf"         "data.frame"

names(inat_cara_sf)

#### Plot iNat data ----

# Plot data points 
# using tidyverse
ggplot() + 
  geom_sf(data = inat_cara_sf)

# Add basemap 
# using rosm, ggspatial, leaflet, htmltools, mapview and leafpop packages

ggplot() + annotation_map_tile(
  type = "hotstyle", progress = "none") + 
  geom_sf(data = inat_cara_sf)

# use rosm::osm.types() to find other map styles! I used "hotstyle"

leaflet() %>% 
  addTiles(group = "Default") %>% # 
  addCircleMarkers(data = inat_cara_sf, group = "Caracal caracal", radius = 2, color = "purple")

# make her interactive
l_inat <- inat_cara_sf %>% 
  mutate(click_url = paste("<b><a href='", url, "'>Link to iNat observation</a></b>"))

mapview(inat_cara_sf, 
        popup = popupTable(l_inat, 
                           zcol = c("user_login", "captive_cultivated", "click_url")))


#### Add Urban Caracal Project's Movebank data

# ucp_cara <- st_read("ucp_observations_20260226.shp")
# ucp_new <- move("Caracal movement ecology study in Cape Town, South Africa.csv")

ucp_new <- read.csv("Caracal movement ecology study in Cape Town, South Africa.csv")

ucp_sf <- ucp_new %>%
  filter(!is.na(location.long)) %>% # Remove missing GPS points
  st_as_sf(coords = c("location.long", "location.lat"), crs = 4326)

class(ucp_sf)


# Plot UCP

# ucp_map <- ggplot() + annotation_map_tile(
#  type = "hotstyle", progress = "none") + 
#  geom_sf(data = ucp_sf)

ucp_map <- leaflet() %>% 
  addTiles(group = "Default") %>% 
  addCircleMarkers(data = ucp_sf, radius = 0.5, color = "orange")

ucp_map


caracal_map <- leaflet() %>% 
  addTiles(group = "Default") %>% 
  addCircleMarkers(data = caracal_sf, radius = 0.5, color = "orange") %>% 
  addCircleMarkers(data = inat_cara_sf, group = "Caracal caracal", radius = 2, color = "purple")

caracal_map
  
