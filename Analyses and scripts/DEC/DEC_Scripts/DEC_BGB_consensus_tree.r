library("ape")
library("optimx")
library("GenSA")
library("rexpokit")
library("cladoRcpp")
library("snow") 
library("parallel")
library("BioGeoBEARS")

args = commandArgs(trailingOnly=TRUE)

make_matrix <- function(max_range, total_area, constraint){
    final_vec <- c()
    for(i in 1:max_range){
        temp_mat <- combn(1:total_area, i)
        temp_vec <- rep(0, ncol(temp_mat))
        for(j in 1:ncol(temp_mat)){
            if(constraint %in% temp_mat[,j]){
                temp_vec[j] <- 1
            }
        }
        final_vec <- c(final_vec, temp_vec)
    }
    return(final_vec)
}

phy = paste("../../../Data/consensus_tree_orecto.tree", sep = "")
temp <- read.tree(phy)

table_geo = "../../../Data/DEC_BGB/7_area_biogeography_Orecto.txt"

time_period= "../../../Data/DEC_BGB/7_area_time_period.txt"

connectivity_matrix = "../../../Data/DEC_BGB/7_area_area_matrix.txt"

if(args[1]){
    dispersal_matrix = "../../../Data/DEC_BGB/7_area_dispersal_matrix.txt"
}

DEC_orectolobiformes = define_BioGeoBEARS_run()

DEC_orectolobiformes$trfn = phy

DEC_orectolobiformes$geogfn = table_geo

tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=table_geo)

max_range_size = 6
DEC_orectolobiformes$max_range_size = max_range_size

areas = getareas_from_tipranges_object(tipranges)
states_area_list = rcpp_areas_list_to_states_list(areas=areas, maxareas=max_range_size, include_null_range=FALSE)
DEC_orectolobiformes$states_list = states_area_list

DEC_orectolobiformes$timesfn = time_period

DEC_orectolobiformes$timeperiods = unlist((unname(c(read.table(time_period)))))

DEC_orectolobiformes$areas_adjacency_fn = connectivity_matrix

if(args[1]){
    DEC_orectolobiformes$dispersal_multipliers_fn = dispersal_matrix
}

if(args[2] == 2){
    DEC_orectolobiformes$fixnode = sort(c(getMRCA(temp, c("Chiloscyllium_griseum","Chiloscyllium_hasseltii", "Chiloscyllium_arabicum", "Chiloscyllium_burmensis", "Chiloscyllium_plagiosum", "Chiloscyllium_indicum", "Chiloscyllium_punctatum", "Hemiscyllium_ocellatum", "Hemiscyllium_strahani", "Hemiscyllium_halmahera", "Hemiscyllium_galei", "Hemiscyllium_henryi", "Hemiscyllium_trispeculare", "Hemiscyllium_michaeli", "Hemiscyllium_hallstromi", "Ginglymostoma_cirratum", "Ginglymostoma_unami", "Nebrius_ferrugineus", "Pseudoginglymostoma_brevicaudatum", "Rhincodon_typus", "Stegostoma_fasciatum")),
                                 getMRCA(temp, c("Orectolobus_parvimaculatus", "Orectolobus_hutchinsi", "Orectolobus_maculatus", "Orectolobus_japonicus", "Orectolobus_leptolineatus", "Orectolobus_halei", "Orectolobus_ornatus", "Orectolobus_floridus", "Sutorectus_tentaculatus", "Eucrossorhinus_dasypogon", "Orectolobus_wardi", "Orectolobus_reticulatus", "Brachaelurus_waddi", "Brachaelurus_colcloughi"))))
    DEC_orectolobiformes$fixlikes = rbind(make_matrix(6, 7, 4), make_matrix(6, 7, 4))
}

if(args[3] == 4){
    DEC_orectolobiformes$fixnode = sort(c(getMRCA(temp, c("Chiloscyllium_griseum","Chiloscyllium_hasseltii", "Chiloscyllium_arabicum", "Chiloscyllium_burmensis", "Chiloscyllium_plagiosum", "Chiloscyllium_indicum", "Chiloscyllium_punctatum", "Hemiscyllium_ocellatum", "Hemiscyllium_strahani", "Hemiscyllium_halmahera", "Hemiscyllium_galei", "Hemiscyllium_henryi", "Hemiscyllium_trispeculare", "Hemiscyllium_michaeli", "Hemiscyllium_hallstromi", "Ginglymostoma_cirratum", "Ginglymostoma_unami", "Nebrius_ferrugineus", "Pseudoginglymostoma_brevicaudatum", "Rhincodon_typus", "Stegostoma_fasciatum")),
                                 getMRCA(temp, c("Orectolobus_parvimaculatus", "Orectolobus_hutchinsi", "Orectolobus_maculatus", "Orectolobus_japonicus", "Orectolobus_leptolineatus", "Orectolobus_halei", "Orectolobus_ornatus", "Orectolobus_floridus", "Sutorectus_tentaculatus", "Eucrossorhinus_dasypogon", "Orectolobus_wardi", "Orectolobus_reticulatus", "Brachaelurus_waddi", "Brachaelurus_colcloughi")),
                                 getMRCA(temp, c("Orectolobus_parvimaculatus", "Orectolobus_hutchinsi", "Orectolobus_maculatus", "Orectolobus_japonicus", "Orectolobus_leptolineatus", "Orectolobus_halei", "Orectolobus_ornatus", "Orectolobus_floridus", "Sutorectus_tentaculatus", "Eucrossorhinus_dasypogon", "Orectolobus_wardi", "Orectolobus_reticulatus")),
                                 getMRCA(temp, c("Brachaelurus_waddi", "Brachaelurus_colcloughi"))))
    DEC_orectolobiformes$fixlikes = rbind(make_matrix(6, 7, 4), make_matrix(6, 7, 4), make_matrix(6, 7, 4), make_matrix(6, 7, 4))
}

DEC_orectolobiformes$force_sparse = FALSE
DEC_orectolobiformes$on_NaN_error = -1e50
DEC_orectolobiformes$speedup = FALSE        
DEC_orectolobiformes$use_optimx = TRUE    
DEC_orectolobiformes$num_cores_to_use = 24

DEC_orectolobiformes$return_condlikes_table = TRUE
DEC_orectolobiformes$calc_TTL_loglike_from_condlikes_table = TRUE
DEC_orectolobiformes$calc_ancprobs = TRUE

DEC_orectolobiformes = section_the_tree(inputs=DEC_orectolobiformes, make_master_table=TRUE, plot_pieces=FALSE, fossils_older_than=0.001, cut_fossils=FALSE)

DEC_orectolobiformes = readfiles_BioGeoBEARS_run(DEC_orectolobiformes)

check_BioGeoBEARS_run(DEC_orectolobiformes)

runslow = TRUE
run_results = paste("../DEC_Results/Consensus_tree/Raw_results/DEC_", args[3], ".Rdata", sep ="")
if (runslow){
    res = bears_optim_run(DEC_orectolobiformes)
    res    
    save(res, file=run_results)
    resDEC = res
} else {
    load(run_results)
    resDEC = res
}

prepare_df_plot <- function(data_bgb){
     data_plot_0 <- data.frame(matrix(nrow = nrow(data_bgb$relative_probs_of_each_state_at_branch_bottom_below_node_UPPASS),
                                ncol = 8))
      colnames(data_plot_0) <- c("end_state_1", "end_state_2", "end_state_3", 
                              "end_state_1_pp", "end_state_2_pp", "end_state_3_pp", 
                              "end_state_other_pp", "node")

    for (i in 1:nrow(data_bgb$ML_marginal_prob_each_state_at_branch_top_AT_node)) {
        row <- data_bgb$ML_marginal_prob_each_state_at_branch_top_AT_node[i,]
        data_plot_0[i, 1] <- order(row,decreasing=T)[1]
        data_plot_0[i, 2] <- order(row,decreasing=T)[2]
        data_plot_0[i, 3] <- order(row,decreasing=T)[3]
        data_plot_0[i, 4] <- row[order(row,decreasing=T)[1]]
        data_plot_0[i, 5] <- row[order(row,decreasing=T)[2]]
        data_plot_0[i, 6] <- row[order(row,decreasing=T)[3]]
        data_plot_0[i, 7] <- sum(row[order(row,decreasing=T)[4:length(row)]]) 
        data_plot_0[i, 8] <- i
    }
    
    states_plot <- sort(unique(c(data_plot_0$end_state_1,data_plot_0$end_state_2, data_plot_0$end_state_3)))
    full_data <- c()
    for(i in 1:nrow(data_plot_0)){
        temp_row <- rep(0, length(states_plot))
        temp_row[which(states_plot == data_plot_0[i,1])] <- data_plot_0[i, 4]
        temp_row[which(states_plot == data_plot_0[i,2])] <- data_plot_0[i, 5]
        temp_row[which(states_plot == data_plot_0[i,3])] <- data_plot_0[i, 6]
        temp_row[length(states_plot)+1] <- data_plot_0[i, 7]
        full_data <- rbind(full_data, temp_row)
    }
    full_data <- as.data.frame(cbind(full_data, data_plot_0$node))
    colnames(full_data) <- c(as.character(states_plot), "Uncertain", "node")
    rownames(full_data) <- data_plot_0$node
return(full_data)
}

saveRDS(prepare_df_plot(resDEC), paste("../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_", args[3], ".rds", sep =""))
