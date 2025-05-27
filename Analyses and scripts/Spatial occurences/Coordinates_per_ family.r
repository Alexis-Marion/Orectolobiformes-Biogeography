library("divvy")
library("lwgeom")
library("h3jsr")
library("ggplot2")
library("ggpubr")
library("sf")
library("raster")
library("geojsonio")
library("sp")
library("cowplot")
library("dplyr") 

jitter_coor <- function(x){
    return(x + runif(n = 1, -1, 1))
}

jitter_overlapp <- function(tab){
    temp_lng <- lapply(tab[duplicated(tab[,c(8,9)]),8], FUN = jitter_coor)
    temp_lat <- lapply(tab[duplicated(tab[,c(8,9)]),9], FUN = jitter_coor)
    tab[duplicated(tab[,c(6,7)]),8] <- (temp_lng)
    tab[duplicated(tab[,c(6,7)]),9] <- (temp_lat)
    return(tab)
}

plot_maps <-function(data_epochs,i){
    temp_CM <- paste("../../Data/PaleoDEMS/CM/", data_epochs$Age[i], "Ma_CM_v7.shp", sep = "")
    temp_CS <- paste("../../Data/PaleoDEMS/CS/", data_epochs$Age[i], "Ma_CS_v7.shp", sep = "")
    
    temp_paleo_data <- paleo_coordinate_cleaned[paleo_coordinate_cleaned$age > data_epochs$Age_min[i] & paleo_coordinate_cleaned$age < data_epochs$Age_max[i], ]
    pal_cor <- data.frame(longitude = temp_paleo_data$p_lng_PALEOMAP, latitude = temp_paleo_data$p_lat_PALEOMAP)
    
    gpm <- read_sf(temp_CM)

    gpm2 <- read_sf(temp_CS)
    
    Family <- temp_paleo_data[,1]
    
    coordinates(pal_cor) <- ~longitude + latitude
    proj4string(pal_cor) <- CRS("+proj=longlat +datum=WGS84")
    SpatialPoints(pal_cor, proj4string = CRS("ESRI:54030"))
    coords_robinson <- spTransform(pal_cor, CRS("+proj=robin +datum=WGS84"))
    coords_sf <- st_as_sf(coords_robinson)
    
    palaeo_coordinate <- gpm  %>% ggplot() +         
        geom_sf(data = bb, fill = "#D7ECF4", colour = NA) +
        geom_sf(data = gpm, fill = "#C0E6E2", colour = "black", alpha = 1) +
        geom_sf(data = gpm2, fill = "#BEB4B0", colour = "black", alpha = 1) +
        geom_sf(data = bbox) +
        geom_sf(data = coords_sf, aes(color = Family)) +
        scale_color_manual(values=color_vec_orecto) + 
        coord_sf(crs = sf::st_crs("ESRI:54030")) +
        ggtitle(data_epochs$Epoch[i]) + 
        guides(color = FALSE) + 
        theme_void() +
        theme(plot.title = element_text(hjust = 0.5))
    return(palaeo_coordinate)
}

sf_use_s2(FALSE)

ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)
bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = sf::st_crs(4326))
bbox <- st_graticule(crs = st_crs("ESRI:54030"), lat = c(-89.9, 89.9), lon = c(-179.9, 179.9))

paleo_coordinate_cleaned <-read.table("../../Data/Coordinate/paleo_coordinate.tsv", sep ="\t", header = TRUE)

paleo_coordinate_cleaned <- jitter_overlapp(paleo_coordinate_cleaned)

data_epochs <- data.frame(Epoch = c("Miocene: 20 Myrs ago", "Oligocene: 30 Myrs ago", "Eocene: 50 Myrs ago", "Paleocene: 65 Myrs ago", "Campanian: 80 Myrs ago", "Cenomanian: 95 Myrs ago", "Barremian: 125 Myrs ago", "Berriasian: 140 Myrs ago", "Kimmeridgian: 155 Myrs ago", "Callovian: 165 Myrs ago", "Pliensbachian: 185 Myrs ago"),
        Age_min = c(0, 23.031, 33.901, 56.001, 66.001, 83.601, 100.501, 125.001, 145.001, 163.501, 174.101), 
        Age_max = c(23.03, 33.9, 56, 66, 83.6, 100.5, 125, 145, 163.5, 174.1, 201.3), 
        Age = c(20, 30, 50, 65, 80, 95, 125, 140, 155, 165, 185))

paleo_coordinate_cleaned$Family <- as.factor(paleo_coordinate_cleaned$Family)

color_vec_orecto <- c("Brachaeluridae" = "#8174A0", "Ginglymostomatidae"="#FFC067", "Hemiscylliidae"="#F2EEE5",
            "Mesiteiidae" = "#FCFAEE","Orectolobidae"= "#9FCDF3", "Orectolobiformes incert. fam." = "#CFCFC4", "Parascylliidae" = "#3E8999",
            "Rhincodontidae" = "#CB9DF0", "Stegostomatidae" = "#F2EEE5")

fig_1 <- plot_grid(plot_maps(data_epochs,11), plot_maps(data_epochs,10), plot_maps(data_epochs,9), labels = c("A", "B", "C"), ncol = 1)

fig_2 <- plot_grid(plot_maps(data_epochs,8), plot_maps(data_epochs,7), plot_maps(data_epochs,6), labels = c("D", "E", "F"), ncol = 1)

fig_3 <- plot_grid(plot_maps(data_epochs,5), plot_maps(data_epochs,4), plot_maps(data_epochs,3), labels = c("G", "H", "I"), ncol = 1)

fig_4 <- plot_grid(plot_maps(data_epochs,2), plot_maps(data_epochs,1), labels = c("J", "K"), ncol = 1)

pdf(file = "Family_plot_1.pdf", width = 10, height = 10)
fig_1
dev.off()

pdf(file = "Family_plot_2.pdf", width = 10, height = 10)
fig_2
dev.off()

pdf(file = "Family_plot_3.pdf", width = 10, height = 10)
fig_3
dev.off()

pdf(file = "Family_plot_4.pdf", width = 10, height = 10)
fig_4
dev.off()
