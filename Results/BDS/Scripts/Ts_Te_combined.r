library("SpeciesAge")
library("ape")

tree_list <- read.tree("../../../Data/Trees/posterior_distribution_100_tree_orecto.tree")

phy <- read.tree("../../../Data/Trees/consensus_tree_orecto.tree")

table_taxo <- read.table("../../BDS/Results/Biogeo/Species/outside_Tethys/Data_Occ_sp_Orecto_outside_Tethys_TaxonList.txt", sep ="\t", header = TRUE)

lst_files_TS_TE <- list.files("../Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", full.names = TRUE, pattern = "se_est.txt")

tab <- read.table("../Rate_shifts/Rates_sp.csv", header = TRUE, sep = ";")

tr_nb_list<-sample(100, 20, replace = FALSE)
for (i in 1:20){
    tr <- tree_list[[tr_nb_list[i]]]
    temp_Ts_Te <- read.table(lst_files_TS_TE[[i]], sep ="\t", header = TRUE)
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
    write.table(data_TS_TE, paste("../Results/Main_analyses/Species_combined/", i, "_G_KEEP_BDS_se_est.txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
    write.table(data_TS_TE_CDD, paste("../Results/Main_analyses/Species_combined_CDD/", i, "_G_KEEP_BDS_se_est.txt", sep =""), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
}
