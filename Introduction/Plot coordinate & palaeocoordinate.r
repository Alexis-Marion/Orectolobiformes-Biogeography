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

table_coordinate_extinct_raw <- read.table("../Data/Occurences_extinct_Orectolobiformes.tsv", header = TRUE, sep ="\t")
table_coordinate_extinct <- cbind(table_coordinate_extinct_raw[, c(2)], table_coordinate_extinct_raw[, c(4)], apply(table_coordinate_extinct_raw[,c(6,7)], 1, mean), table_coordinate_extinct_raw[, c(13, 14)])
colnames(table_coordinate_extinct) <- c("Family", "scientificName", "age", colnames(table_coordinate_extinct)[c(4,5)])

table_coordinate_extant <- read.table("../Data/Occurences_extant_Orectolobiformes.tsv", header = TRUE, sep ="\t")
extant_coordinate <- data.frame(longitude = table_coordinate_extant$Longitude, latitude = table_coordinate_extant$Latitude, species = table_coordinate_extant$Species)    
extant_coordinate_without_whale_shark <- extant_coordinate[!extant_coordinate$species == "Rhincodon typus", ]

paleo_coordinate <- palaeorotate(table_coordinate_extinct, lng = "Longitude", lat = "Latitude", age = "age", model = c("MERDITH2021", "PALEOMAP", "MATTHEWS2016_pmag_ref"))

paleo_coordinate_cleaned <- na.omit(paleo_coordinate)

write.table(paleo_coordinate_cleaned, "../Data/paleo_coordinate.tsv", row.names = FALSE, col.names = TRUE, quote = FALSE, sep ="\t")

ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)

bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = sf::st_crs(4326))
bbox <- st_graticule(crs = st_crs("ESRI:54030"), lat = c(-89.9, 89.9), lon = c(-179.9, 179.9))

CRGrid <- bb %>%
  st_make_grid(cellsize = 5) %>%
  st_cast("MULTIPOLYGON") %>%
  st_sf() %>%
  mutate(cellid = row_number())

coordinates(extant_coordinate_without_whale_shark) <- ~longitude + latitude
    proj4string(extant_coordinate_without_whale_shark) <- CRS("+proj=longlat +datum=WGS84")
    SpatialPoints(extant_coordinate_without_whale_shark, proj4string = CRS("ESRI:54030"))
    coords_sf_extant <- st_as_sf(extant_coordinate_without_whale_shark)  %>%
  group_by(species) %>%
  summarize()

sharks_richness_grid <- CRGrid %>%
     st_join(coords_sf_extant) %>%
     mutate(overlap = ifelse(!is.na(species), 1, 0)) %>%
     group_by(cellid) %>%
     summarize(num_species = sum(overlap))

    coordinates(table_coordinate_extinct) <- ~Longitude + Latitude
    proj4string(table_coordinate_extinct) <- CRS("+proj=longlat +datum=WGS84")
    SpatialPoints(table_coordinate_extinct, proj4string = CRS("ESRI:54030"))
    coords_robinson <- spTransform(table_coordinate_extinct, CRS("+proj=robin +datum=WGS84"))
    coords_sf <- st_as_sf(coords_robinson)

coords_sf$order <- "Orectolobiformes"

pdf("Extant_extinct.pdf")
gpm  %>% ggplot() +
        geom_sf(data = sharks_richness_grid,  aes(fill = num_species), colour = NA) + 
        scale_fill_gradientn(colours = rev(c("#FF6347", "#FF7467","#FFA071", "#FFB480", "#FEDD9E", "#FDF1AD", "#ADD8E6")), name= "Species richness", 
                      labels = c("0", "2", "4", "6", "8", "10"),
                      breaks = c(0, 2, 4, 6, 8, 10)) +
        geom_sf(data = gpm, fill = "#BEB4B0", colour = "black", alpha = 1) +
        geom_sf(data = coords_sf, fill = "#FF6347", aes(color = order, shape = order, size = order)) + 
        scale_color_manual(values = "#9F5C49") + 
        scale_shape_manual(values = 21) +
        scale_size_manual(values = 0.75) + 
        coord_sf(crs = sf::st_crs("ESRI:54030")) +
        theme_void()
dev.off()

table_coordinate_extant_without_whale_shark <- table_coordinate_extant[!table_coordinate_extant$Species == "Rhincodon typus", ]

table_coordinate_extant_without_whale_shark <- table_coordinate_extant_without_whale_shark[!duplicated(table_coordinate_extant_without_whale_shark),]

unique_sp <- unique(table_coordinate_extant_without_whale_shark$Species)

for(i in 1:length(unique_sp)){
    
    temp <- table_coordinate_extant_without_whale_shark[table_coordinate_extant_without_whale_shark$Species == unique_sp[i], ]

    
    if(i == 1){
        if(nrow(temp) < 10){
            table_coordinate_extant_subsampled <- temp[,c(4,5)]
        }
        
        else{
            table_coordinate_extant_subsampled <- clustr(dat = temp, xy = c("longitude", "latitude"), iter = 1, nSite = 10, distMax = 2000)[[1]]
        }

    }
    
    else{
        
        if(nrow(temp) < 10){
            table_coordinate_extant_subsampled <- rbind(table_coordinate_extant_subsampled,temp[,c(4,5)])
        }
        else{
            table_coordinate_extant_subsampled <- rbind(table_coordinate_extant_subsampled, clustr(dat = temp, xy = c("Longitude", "Latitude"), iter = 1, nSite = 10, distMax = 2000)[[1]])
        }
    }
    
}

write.table(table_coordinate_extant_subsampled, "../Data/table_coordinate_extant_subsampled.tsv", sep = "\t", quote = FALSE, col.names = TRUE, row.names = FALSE)

pdf("Paleo_lat_scotese.pdf")
plot(x=paleo_coordinate_cleaned$age, y=paleo_coordinate_cleaned$p_lat_PALEOMAP, axes = FALSE, xlab = NA, ylab = "Latitude (°)", col = "#FAC898", pch = 16, xlim = c(max(paleo_coordinate_cleaned$age), 0))
points(x=rep(0, nrow(table_coordinate_extant_subsampled)), y=table_coordinate_extant_subsampled$Latitude,  col = "#CB99CC", pch = 16)
lines(lowess(x=c(paleo_coordinate_cleaned$age,rep(0, nrow(table_coordinate_extant_subsampled))), y=c(paleo_coordinate_cleaned$p_lat_PALEOMAP, table_coordinate_extant_subsampled$Latitude)), col = "#AEC6CF" , lwd = 3)
box()
axis(2)
axis_geo(side = 1, intervals = list("epoch", "period"),
    abbr = list(TRUE, FALSE))
dev.off()

pdf("Paleo_lat_merdith.pdf")
plot(x=paleo_coordinate_cleaned$age, y=paleo_coordinate_cleaned$p_lat_MERDITH2021, axes = FALSE, xlab = NA, ylab = "Latitude (°)", col = "#FAC898", pch = 16, xlim = c(max(paleo_coordinate_cleaned$age), 0))
points(x=rep(0, nrow(table_coordinate_extant_subsampled)), y=table_coordinate_extant_subsampled$Latitude,  col = "#CB99CC", pch = 16)
lines(lowess(x=c(paleo_coordinate_cleaned$age,rep(0, nrow(table_coordinate_extant_subsampled))), y=c(paleo_coordinate_cleaned$p_lat_PALEOMAP, table_coordinate_extant_subsampled$Latitude)), col = "#AEC6CF", lwd = 3)
box()
axis(2)
axis_geo(side = 1, intervals = list("epoch", "period"),
    abbr = list(TRUE, FALSE)) 
dev.off()

pdf("Paleo_lat_mathews.pdf")
plot(x=paleo_coordinate_cleaned$age, y=paleo_coordinate_cleaned$p_lat_MATTHEWS2016_pmag_ref, axes = FALSE, xlab = NA, ylab = "Latitude (°)", col = "#FAC898", pch = 16, xlim = c(max(paleo_coordinate_cleaned$age), 0))
points(x=rep(0, nrow(table_coordinate_extant_subsampled)), y=table_coordinate_extant_subsampled$Latitude,  col = "#CB99CC", pch = 16)
lines(lowess(x=c(paleo_coordinate_cleaned$age,rep(0, nrow(table_coordinate_extant_subsampled))), y=c(paleo_coordinate_cleaned$p_lat_PALEOMAP, table_coordinate_extant_subsampled$Latitude)), col = "#AEC6CF", lwd = 3)
box()
axis(2)
axis_geo(side = 1, intervals = list("epoch", "period"),
    abbr = list(TRUE, FALSE))
dev.off()
