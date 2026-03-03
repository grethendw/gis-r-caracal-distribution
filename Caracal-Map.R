getwd()
# "/Users/User/Documents/GIT/gis-r-caracal-distribution/GIS-R-Caracal-Distribution"
# I know, I know. It didn't need a subfolder, but when I tried to fix it the first time, I lost all my progress.

rm(list = ls())

#### Load packages ----

library(rinat)
library(sf)
library(tidyverse)
library(rosm)
library(ggspatial)
library(leaflet)
library(mapview)
library(leafpop)
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

jasper_movebank <- read.csv2("data/jasper_movebank.csv")

as.tibble(jasper_movebank)

jasper_sf <- jasper_movebank %>%
  filter(!is.na(location_long)) %>%          # Remove missing GPS points or it won't run
  st_as_sf(coords = c("location_long", "location_lat"), crs = 4326)



# PLOT Movebank data ----

# Figure 2
jasper_map <- ggplot() + 
  annotation_map_tile(type = "osm", progress = "none") + 
  geom_sf(data = jasper_sf)

jasper_map <- leaflet() %>% 
  addTiles(group = "Default") %>% 
  addCircleMarkers(data = jasper_sf, 
                   radius = 0.2, 
                   color = "orange")

jasper_map


#### Plot combined map ----

# Figure 3 - ggplot
caracal_map <- ggplot() + 
  annotation_map_tile(type = "osm", progress = "none") + 
  geom_sf(data = inat_sf, color = "purple") +
  geom_sf(data = jasper_sf, color = "orange") 

caracal_map
  