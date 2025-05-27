library("ape")
library("SpeciesAge")

table_occ <- read.table("../../../Data/Occurences/Occurences_extinct_Orectolobiformes.tsv", sep ="\t", header = TRUE)

status_gen <- read.table("../../../Data/Occurences/Data_Occ_gen_Orecto_TaxonList.txt", sep ="\t", header = TRUE)
status_sp <- read.table("../../../Data/Occurences/Data_Occ_sp_Orecto_TaxonList.txt", sep ="\t", header = TRUE)

table_species <- table_occ[-grep("sp[.]", table_occ$Species),]

make_table_DES <- function(table_fossil, prefix, col){ 
    temp_table <- cbind(table_fossil[,col], table_fossil$Earliest.Age, table_fossil$Latest.Age, table_fossil$Paleobiogeography)
    for(i in 1:nrow(table_fossil)){
        if(table_fossil$Paleobiogeography[i] != "Tethys"){
            temp_table[i,4] <- "Outside_Tethys"
        }
    }
    temp_table <- as.data.frame(temp_table)
    colnames(temp_table) <- c("scientificName", "earliestAge", "latestAge", "higherGeography")
write.table(temp_table[as.numeric(temp_table$latestAge) < 100.5,], paste(prefix, "_Tethys.txt", sep = ""), col.names = TRUE, row.names = FALSE, quote = FALSE, sep = "\t")
}

make_table_PyRate <- function(table_fossil, prefix, prefix2, col, status){ 
    status <- status[status$Status == "extant",]
    temp_table <- cbind(gsub(" ", "_", table_fossil[,col]), rep("extinct", nrow(table_fossil)), table_fossil$Latest.Age, table_fossil$Earliest.Age, table_fossil$Paleobiogeography)
    for(i in 1:nrow(temp_table)){
        if(temp_table[i,1] %in% status$Species){
            temp_table[i,2] <- "extant"
        }
    }
    
    table_outside <- temp_table[temp_table[,5] != "Tethys",]
    table_tethys <- temp_table[temp_table[,5] == "Tethys",]
    table_outside <- as.data.frame(table_outside)
    table_outside <- table_outside[,-5]
    colnames(table_outside) <- c("Species", "Status", "MinT", "MaxT")    
    table_tethys <- as.data.frame(table_tethys)
    table_tethys <- table_tethys[,-5]
    colnames(table_tethys) <- c("Species", "Status", "MinT", "MaxT")
    
write.table(table_outside[as.numeric(table_outside$MinT) < 100.5,], paste(prefix, "outside_Tethys/Data_Occ_", prefix2, "_Orecto_outside_Tethys.tsv", sep = ""), col.names = TRUE, row.names = FALSE, quote = FALSE, sep = "\t")
write.table(table_tethys[as.numeric(table_tethys$MinT) < 100.5,], paste(prefix, "Tethys/Data_Occ_", prefix2, "_Orecto_Tethys.tsv", sep = ""), col.names = TRUE, row.names = FALSE, quote = FALSE, sep = "\t")
}

table_species

table_fossil, prefix, prefix2, col, status)
table_species, "../../BDS/Results/Biogeo/Species/", "sp", 4, status_sp)

status <- status[status$Status == "extant",]
    temp_table <- cbind(gsub(" ", "_", table_fossil[,col]), rep("extinct", nrow(table_fossil)), table_fossil$Latest.Age, table_fossil$Earliest.Age, table_fossil$Paleobiogeography)
    for(i in 1:nrow(temp_table)){
        if(temp_table[i,1] %in% status$Species){
            temp_table[i,2] <- "extant"
        }
    }
    
    table_outside <- temp_table[temp_table[,5] != "Tethys",]
    table_tethys <- temp_table[temp_table[,5] == "Tethys",]
    table_outside <- as.data.frame(table_outside)
    table_outside <- table_outside[,-5]
    colnames(table_outside) <- c("Species", "Status", "MinT", "MaxT")    
    table_tethys <- as.data.frame(table_tethys)
    table_tethys <- table_tethys[,-5]
    colnames(table_tethys) <- c("Species", "Status", "MinT", "MaxT")

make_table_DES(table_species, "../Input/Sp", 4)

make_table_PyRate(table_species, "../../BDS/Results/Biogeo/Species/", "sp", 4, status_sp)

make_table_DES(table_occ, "../Input/Gen", 3)

make_table_PyRate(table_occ, "../../BDS/Results/Biogeo/Genus/", "gen", 3, status_gen)
