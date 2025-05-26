library("SpeciesAge")
library("ape")

tree_list <- read.tree("../../../Data/Trees/posterior_distribution_100_tree_orecto.tree")

phy <- read.tree("../../../Data/Trees/consensus_tree_orecto.tree")

table_taxo <- read.table("../../BDS/Results/Biogeo/Species/outside_Tethys/Data_Occ_sp_Orecto_outside_Tethys_TaxonList.txt", sep ="\t", header = TRUE)

lst_files_TS_TE <- list.files("../Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", full.names = TRUE, pattern = "se_est.txt")

lst_files_DES <- list.files("../../DES/Analysis_Bayesian/sp/", full.names = TRUE, pattern = ".txt")

table_extant_biogeo <- read.table("../../../Data/DEC_BGB/7_area_biogeography_Orecto_extant.tsv", sep ="\t", header = TRUE)

tab <- read.table("../Rate_shifts/Rates_sp.csv", header = TRUE, sep = ";")

tr_nb_list<-sample(100, 20, replace = FALSE)

NE = FALSE

for (i in 1:20){
    tr <- tree_list[[tr_nb_list[i]]]
    temp_Ts_Te <- read.table(lst_files_TS_TE[[i]], sep ="\t", header = TRUE)
    temp_DES <- read.table(lst_files_DES[[i]], sep ="\t")
    table_extant_biogeo <- table_extant_biogeo[!table_extant_biogeo$Species %in% temp_DES$scientificName,]
    table_extant_biogeo <- table_extant_biogeo[gsub(" ", "_", table_extant_biogeo$Species) %in% phy$tip.label, ]
    table_extant_biogeo$Species <- gsub(" ", "_", table_extant_biogeo$Species)
    colnames(temp_DES) <- as.character(temp_DES[1,])
    temp_DES <- temp_DES[-1, ]
    temp_table_taxo <- cbind(table_taxo, temp_Ts_Te)
    temp_phy <- as.data.frame(SpeciesAge::calculateTipAges(tr))
    temp_phy_corr <- as.data.frame(cbind(SpeciesAge::calculateTipAges(tr)[,1], lapply(SpeciesAge::calculateTipAges(tr)[,2], meanAge, lambda = mean(unlist(tab[6,-1])), mu = mean(unlist(tab[7,-1])), rho = 38/44)))
    temp_phy2 <- temp_phy[! temp_phy[,1] %in% temp_table_taxo[,1],2]    
    temp_phy_corr2 <- temp_phy_corr[! temp_phy_corr[,1] %in% temp_table_taxo[,1],2]
    temp_neonto <- as.data.frame(cbind(rep(0,length(temp_phy2)), ((nrow(temp_table_taxo)+1):(nrow(temp_table_taxo)+length(temp_phy2))), temp_phy2, rep(0,length(temp_phy2))))
    temp_neonto_corr <- as.data.frame(cbind(rep(0,length(temp_phy_corr2)), ((nrow(temp_table_taxo)+1):(nrow(temp_table_taxo)+length(temp_phy_corr2))), temp_phy_corr2, rep(0,length(temp_phy_corr2))))
    colnames(temp_neonto) <- colnames(temp_Ts_Te)
    colnames(temp_neonto_corr) <- colnames(temp_Ts_Te)
    data_TS_TE <- rbind(temp_Ts_Te, temp_neonto)
    data_TS_TE$clade <- unlist(data_TS_TE$clade)
    data_TS_TE$species <- unlist(data_TS_TE$species)
    data_TS_TE$ts <- unlist(data_TS_TE$ts)
    data_TS_TE$te <- unlist(data_TS_TE$te)
    data_TS_TE_CDD <- rbind(temp_Ts_Te, temp_neonto_corr)
    data_TS_TE_CDD$clade <- unlist(data_TS_TE_CDD$clade)
    data_TS_TE_CDD$species <- unlist(data_TS_TE_CDD$species)
    data_TS_TE_CDD$ts <- unlist(data_TS_TE_CDD$ts)
    data_TS_TE_CDD$te <- unlist(data_TS_TE_CDD$te)
    
    write.table(data_TS_TE, paste("../Results/Biogeo/Species_combined/", i, "_G_KEEP_BDS_se_est.txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
    write.table(data_TS_TE_CDD, paste("../Results/Biogeo/Species_combined_CDD/", i, "_G_KEEP_BDS_se_est.txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
    
    temp_phy3 <- temp_phy[! temp_phy[,1] %in% temp_table_taxo[,1],]
    temp_phy_corr3 <- temp_phy_corr[! temp_phy_corr[,1] %in% temp_table_taxo[,1],]
    temp_numbers <- as.numeric(colnames(temp_DES)[-1])
    matrix_DES <- matrix(NaN, nrow(temp_phy3), (ncol(temp_DES))-1)
    matrix_DES_corr <- matrix(NaN, nrow(temp_phy_corr3), (ncol(temp_DES))-1)
    temp_tab_range <- table_extant_biogeo[,-c(1:3)]
    
    if(NE == TRUE){
            for(j in 1:nrow(temp_phy3)){
                if(temp_tab_range[j,4] == 0|temp_tab_range[j,3] == 0){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "1.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) == 1|temp_tab_range[j,3] == 1 & sum(temp_tab_range[j,]) == 1){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "2.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) != 1|temp_tab_range[j,3] == 1 & sum(temp_tab_range[j,]) != 1){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "3.0" 
                }
    
            }
    
            for(j in 1:nrow(temp_phy_corr3)){
                if(temp_tab_range[j,4] == 0){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "1.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) == 1){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "2.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) != 1){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "3.0" 
                }
    
            }
    }
    else{
            for(j in 1:nrow(temp_phy3)){
                if(temp_tab_range[j,4] == 0){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "1.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) == 1){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "2.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) != 1){
                    matrix_DES[j,c(min(which(temp_numbers < temp_phy3[j,2]))-1, which(temp_numbers < temp_phy3[j,2]))] <- "3.0" 
                }
    
            }
    
            for(j in 1:nrow(temp_phy_corr3)){
                if(temp_tab_range[j,4] == 0){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "1.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) == 1){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "2.0" 
                }
                if(temp_tab_range[j,4] == 1 & sum(temp_tab_range[j,]) != 1){
                    matrix_DES_corr[j,c(min(which(temp_numbers < temp_phy_corr3[j,2]))-1, which(temp_numbers < temp_phy_corr3[j,2]))] <- "3.0" 
                }
    
            }
        
    }    
    matrix_DES <- cbind(gsub("_", " ", temp_phy3[,1]), matrix_DES)
    colnames(matrix_DES) <- colnames(temp_DES)
    full_matrix_DES <- rbind(temp_DES, matrix_DES)
    full_matrix_DES[,2] <- "NaN"
    matrix_DES_corr <- as.data.frame(cbind(gsub("_", " ", temp_phy3[,1]), matrix_DES_corr))
    colnames(matrix_DES_corr) <- colnames(temp_DES)
    full_matrix_DES_corr <- rbind(temp_DES, matrix_DES_corr)
    full_matrix_DES_corr[,2] <- "NaN"
    write.table(full_matrix_DES, paste("../../DES/Analysis_Bayesian/sp_combined/sp_combined_DES_", i, ".txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
    write.table(full_matrix_DES_corr, paste("../../DES/Analysis_Bayesian/sp_combined_CDD/sp_combined_DES_", i, ".txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
}
