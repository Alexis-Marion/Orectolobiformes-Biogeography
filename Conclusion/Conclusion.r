library("lwgeom")
library("h3jsr")
library("ggplot2")
library("ggpubr")
library("sf")
library("raster")
library("geojsonio")
library("sp")
library("dplyr") 

sf_use_s2(FALSE)

paleo_coordinate_cleaned <-read.table("../Data/Coordinate/paleo_coordinate.tsv", sep ="\t", header = TRUE)

table_extant_coordinates <- read.table("../Data/Coordinate/table_coordinate_extant_subsampled.tsv", header = TRUE)

data_epochs <- data.frame(Epoch = c("Holocene", "Miocene", "Maastrichian", "Albian"),
        Age_min = c(0, 5.332, 66, 100.5), 
        Age_max = c(0, 23.031, 72.1, 113.2), 
        Age = c(0, 15, 70, 105))

ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)

bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = sf::st_crs(4326))
bbox <- st_graticule(crs = st_crs("ESRI:54030"), lat = c(-89.9, 89.9), lon = c(-179.9, 179.9))

for(i in 1:nrow(data_epochs)){
    temp_CM <- paste("../Data/PaleoDEMS/CM/", data_epochs$Age[i], "Ma_CM_v7.shp", sep = "")
    temp_name <- paste("Paleocoordinates_", data_epochs$Epoch[i], ".pdf", sep ="")
    temp_CS <- paste("../Data/PaleoDEMS/CS/", data_epochs$Age[i], "Ma_CS_v7.shp", sep = "")
    
    gpm <- read_sf(temp_CM)

    gpm2 <- read_sf(temp_CS)
    
    if(data_epochs$Epoch[i] == "Holocene"){
        coordinates(table_extant_coordinates) <- ~Longitude + Latitude
        proj4string(table_extant_coordinates) <- CRS("+proj=longlat +datum=WGS84")
        SpatialPoints(table_extant_coordinates, proj4string = CRS("ESRI:54030"))
        coords_robinson <- spTransform(table_extant_coordinates, CRS("+proj=robin +datum=WGS84"))
        coords_sf <- st_as_sf(coords_robinson)
    }
    else{
        temp_paleo_data <- paleo_coordinate_cleaned[paleo_coordinate_cleaned$age > data_epochs$Age_min[i] & paleo_coordinate_cleaned$age < data_epochs$Age_max[i], ]
        pal_cor <- data.frame(longitude = temp_paleo_data$p_lng_PALEOMAP, latitude = temp_paleo_data$p_lat_PALEOMAP)
    
        coordinates(pal_cor) <- ~longitude + latitude
        proj4string(pal_cor) <- CRS("+proj=longlat +datum=WGS84")
        SpatialPoints(pal_cor, proj4string = CRS("ESRI:54030"))
        coords_robinson <- spTransform(pal_cor, CRS("+proj=robin +datum=WGS84"))
        coords_sf <- st_as_sf(coords_robinson)   
    }
    
    coords_sf$order <- "Orectolobiformes"
    
    palaeo_coordinate <- gpm  %>% ggplot() +         
        geom_sf(data = bb, fill = "#ADD8E6", colour = NA) +
        geom_sf(data = gpm, fill = "#81CDC6", colour = "black", alpha = 1) +
        geom_sf(data = gpm2, fill = "#BEB4B0", colour = "black", alpha = 1) +
        geom_sf(data = bbox) +
        geom_sf(data = coords_sf, fill = "#FF6347", aes(color = order, shape = order, size = order)) + 
        scale_color_manual(values = "#9F5C49") + 
        scale_shape_manual(values = 21) +
        scale_size_manual(values = 0.75) + 
        guides(alpha = "none", color = "none") + 
        coord_sf(crs = sf::st_crs("ESRI:54030")) +
        ggtitle(paste(data_epochs$Epoch[i], " (", data_epochs$Age_max[i], "-", (data_epochs$Age_min[i]), ")", sep ="")) + 
        theme_void() +
        theme(plot.title = element_text(hjust = 0.5, vjust = -90))
    
    ggsave(filename = temp_name, plot = palaeo_coordinate)
}
