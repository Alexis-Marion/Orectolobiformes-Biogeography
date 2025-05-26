library("ape")

args = commandArgs(trailingOnly=TRUE)

prepare_df_BGB <- function(data_bgb){
     data_BGB_0 <- data.frame(matrix(nrow = nrow(data_bgb$relative_probs_of_each_state_at_branch_bottom_below_node_UPPASS),
                                ncol = 8))
      colnames(data_BGB_0) <- c("end_state_1", "end_state_2", "end_state_3",
                              "end_state_1_pp", "end_state_2_pp", "end_state_3_pp", 
                              "end_state_other_pp", "node")

    for (i in 1:nrow(data_bgb$ML_marginal_prob_each_state_at_branch_top_AT_node)) {
        row <- data_bgb$ML_marginal_prob_each_state_at_branch_top_AT_node[i,]
        data_BGB_0[i, 1] <- order(row,decreasing=T)[1]
        data_BGB_0[i, 2] <- order(row,decreasing=T)[2]
        data_BGB_0[i, 3] <- order(row,decreasing=T)[3]
        data_BGB_0[i, 4] <- row[order(row,decreasing=T)[1]]
        data_BGB_0[i, 5] <- row[order(row,decreasing=T)[2]]
        data_BGB_0[i, 6] <- row[order(row,decreasing=T)[3]]
        data_BGB_0[i, 7] <- sum(row[order(row,decreasing=T)[4:length(row)]]) 
        data_BGB_0[i, 8] <- i
    }
    
    states_BGB <- sort(unique(c(data_BGB_0$end_state_1,data_BGB_0$end_state_2, data_BGB_0$end_state_3)))
    full_data <- c()
    for(i in 1:nrow(data_BGB_0)){
        temp_row <- rep(0, length(states_BGB))
        temp_row[which(states_BGB == data_BGB_0[i,1])] <- data_BGB_0[i, 4]
        temp_row[which(states_BGB == data_BGB_0[i,2])] <- data_BGB_0[i, 5]
        temp_row[which(states_BGB == data_BGB_0[i,3])] <- data_BGB_0[i, 6]
        temp_row[length(states_BGB)+1] <- data_BGB_0[i, 7]
        full_data <- rbind(full_data, temp_row)
    }
    full_data <- as.data.frame(cbind(full_data, data_BGB_0$node))
    colnames(full_data) <- c(as.character(states_BGB), "Uncertain", "node")
    rownames(full_data) <- data_BGB_0$node
return(full_data)
}

clean_data <- function(res, filter){
    temp <-  unlist(as.vector(prepare_df_plot(res)[filter, -ncol(prepare_df_plot(res))]))
    temp <- temp[temp != 0]
    return(temp)
}

make_data <- function(data_list){
    data_cleaned <- c()
    sorted_colnames <- c(sort(as.numeric(unique(names(unlist(data_list))))), "Uncertain")
    for(i in data_list){
        vec_temp <- rep(NA, length(sorted_colnames))
        names(vec_temp) <- sorted_colnames
        for(j in 1:length(round(tapply(i, names(i), sum)/100,3))){
            vec_temp[names(vec_temp) == names(round(tapply(i, names(i), sum)/100,3)[j])] <- paste(round(tapply(i, names(i), sum)/100,3)[j], "土", round(tapply(i, names(i), sd),3)[j],sep = " ")
        }
        data_cleaned <- rbind(data_cleaned, vec_temp)

    }   
    data_cleaned <- as.data.frame(data_cleaned)
    rownames(data_cleaned) <- c("Parascylliidae", "Brachaeluridae", "Orectolobidae", "Brachaeluridae + Orectolobidae",
                                "Ginglymostomatidae + Rhincodontidae + Stegostomatidae", "Hemiscylliidae", "Hemiscylliidae + Ginglymostomatidae + Rhincodontidae + Stegostomatidae", "Root")
    return(data_cleaned)
}

temp_para <- c()
temp_brach <- c()
temp_orecto <- c()
temp_brach_orecto <- c()
temp_gingly <- c()
temp_hemi <- c()
temp_gingly_hemi <- c()
temp_root <- c()

for(i in list.files(args[1] full.names = TRUE)){
    
    load(i)
    temp_tree <- read.tree(res$inputs$trfn)
    
    parascylliidae <- getMRCA(temp_tree, c('Parascyllium_collare','Parascyllium_ferrugineum','Cirrhoscyllium_formosanum'))
    brachaeluridae <- getMRCA(temp_tree, c('Brachaelurus_waddi','Brachaelurus_colcloughi'))
    orectolobidae <- getMRCA(temp_tree, c('Orectolobus_floridus','Sutorectus_tentaculatus','Orectolobus_ornatus','Orectolobus_hutchinsi','Orectolobus_parvimaculatus','Orectolobus_maculatus','Orectolobus_leptolineatus','Orectolobus_japonicus','Orectolobus_halei','Eucrossorhinus_dasypogon','Orectolobus_wardi','Orectolobus_reticulatus'))
    brachae_orecto <- getMRCA(temp_tree, c('Brachaelurus_waddi','Brachaelurus_colcloughi','Orectolobus_floridus','Sutorectus_tentaculatus','Orectolobus_ornatus','Orectolobus_hutchinsi','Orectolobus_parvimaculatus','Orectolobus_maculatus','Orectolobus_leptolineatus','Orectolobus_japonicus','Orectolobus_halei','Eucrossorhinus_dasypogon','Orectolobus_wardi','Orectolobus_reticulatus'))
    ginglymo_stego_rhinco <- getMRCA(temp_tree, c('Ginglymostoma_cirratum','Ginglymostoma_unami','Nebrius_ferrugineus','Rhincodon_typus','Pseudoginglymostoma_brevicaudatum','Stegostoma_fasciatum'))
    hemiscylliidae <- getMRCA(temp_tree, c('Hemiscyllium_ocellatum','Hemiscyllium_michaeli','Hemiscyllium_trispeculare','Hemiscyllium_hallstromi','Hemiscyllium_halmahera','Hemiscyllium_galei','Hemiscyllium_henryi','Hemiscyllium_strahani','Chiloscyllium_griseum','Chiloscyllium_hasseltii','Chiloscyllium_arabicum','Chiloscyllium_burmensis','Chiloscyllium_plagiosum','Chiloscyllium_indicum','Chiloscyllium_punctatum'))
    ginglymo_stego_rhinco_hemiscyllium <- getMRCA(temp_tree, c('Ginglymostoma_cirratum','Ginglymostoma_unami','Nebrius_ferrugineus','Rhincodon_typus','Pseudoginglymostoma_brevicaudatum','Stegostoma_fasciatum', 'Hemiscyllium_ocellatum','Hemiscyllium_michaeli','Hemiscyllium_trispeculare','Hemiscyllium_hallstromi','Hemiscyllium_halmahera','Hemiscyllium_galei','Hemiscyllium_henryi','Hemiscyllium_strahani','Chiloscyllium_griseum','Chiloscyllium_hasseltii','Chiloscyllium_arabicum','Chiloscyllium_burmensis','Chiloscyllium_plagiosum','Chiloscyllium_indicum','Chiloscyllium_punctatum'))
    root_orectolobiformes <- getMRCA(temp_tree, temp_tree$tip.label)
    
    temp_para <- c(temp_para, clean_data(res, parascylliidae))
    temp_brach <- c(temp_brach, clean_data(res, brachaeluridae))
    temp_orecto <- c(temp_orecto, clean_data(res, orectolobidae))
    temp_brach_orecto<- c(temp_brach_orecto, clean_data(res, brachae_orecto))
    temp_gingly <- c(temp_gingly, clean_data(res, ginglymo_stego_rhinco))
    temp_hemi <- c(temp_hemi, clean_data(res, hemiscylliidae))
    temp_gingly_hemi <- c(temp_gingly_hemi, clean_data(res, ginglymo_stego_rhinco_hemiscyllium))
    temp_root <- c(temp_root, clean_data(res, root_orectolobiformes))
}

data_list <- list(temp_para,temp_brach, temp_orecto, temp_brach_orecto, temp_gingly, temp_hemi, temp_gingly_hemi, temp_root)

write.table(make_data(data_list), paste("../DEC_Results/ARE_proportion/Prop", args[2], ".tsv", sep = ""), sep ="\t", quote = FALSE)
