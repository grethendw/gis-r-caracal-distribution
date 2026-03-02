getwd()
# "/Users/User/Documents/GIT/gis-r-caracal-distribution/GIS-R-Caracal-Distribution"
# I know, I know. It didn't need a subfolder, but we're here now.

rm(list = ls())

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


#### READ iNaturalist data ----

inat_obs_raw <- get_inat_obs(taxon_name = "Caracal caracal",
                   bounds = c(-35, 18, -33.5, 18.5), 
                   quality = "research",
                   maxresults = 500)


# There are a bunch of "swimming" caracals in the middle of the ocean because their locations have been obscured. 
# Fix:
inat_obs <- inat_obs_raw %>% 
  filter(coordinates_obscured == "false")


# Inspect
head(inat_obs)
tail(inat_obs)
class(inat_obs)


# Make the dataframe a spatial object of class = "sf"
inat_sf <- st_as_sf(
  inat_obs, 
  coords = c("longitude", "latitude"), 
  crs = 4326)


# Check class of cara_move_sf 
class(inat_sf)
# [1] "sf"         "data.frame"



#### PLOT iNaturalist data ----

# Figure 1 - mapview (url plus pic)
sighting <- inat_sf %>% 
  mutate('🔗' = paste("<b><a href='", url, "'>Link to iNat observation</a></b>"),
         '📷' = paste("<img src ='", image_url , "' height='128'>")) %>% 
  rename('👤' = "user_login", captive = captive_cultivated)

mapview(sighting,
        popup = popupTable(sighting, 
                           zcol = c("👤", "🔗", "📷")))




#### READ Urban Caracal Project's Movebank data ----

ucp_csv <- read.csv("Caracal movement ecology study in Cape Town, South Africa.csv")

ucp_sf <- ucp_csv %>%
  filter(!is.na(location.long)) %>%                             # Remove missing GPS points or it won't run
  filter(individual.local.identifier == "Jasper - TMC08") %>%   # picked one cat otherwise there are almost 60k observations
  st_as_sf(coords = c("location.long", "location.lat"), 
           crs = 4326)

class(ucp_sf)
# [1] "sf"         "data.frame"


# PLOT Movebank data ----

# Figure 2
ucp_map <- leaflet() %>% 
  addTiles(group = "Default") %>% 
  addCircleMarkers(data = ucp_sf, 
                   radius = 0.5, 
                   color = "blue")

ucp_map


#### Plot combined map ----

# Figure 3 - ggplot
caracal_map <- ggplot() + 
  annotation_map_tile(type = "osm", progress = "none") + 
  geom_sf(data = ucp_sf, color = "orange") +
  geom_sf(data = inat_sf, color = "purple")

caracal_map
  
