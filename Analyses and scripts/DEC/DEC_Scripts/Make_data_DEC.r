library("tidygraph")
library("igraph")
library("ggraph")
library("tidyverse")
library("ape")

table <- read.table("../../../Data/DEC_BGB/Connectivity_through_time.tsv", sep ="\t", header = TRUE)

table_biogeo <- read.table("../../../Data/DEC_BGB/7_area_biogeography_Orecto_extant.tsv", sep ="\t", header = TRUE)

phy <- read.tree("../../../Data/consensus_tree_orecto.tree")

table_biogeo <- table_biogeo[gsub(" ", "_", table_biogeo$Species) %in% phy$tip.label, ]
table_biogeo$Species <- gsub(" ", "_", table_biogeo$Species)
table_DEC_biogeo <- rbind(c(length(phy$tip.label), 7), cbind(table_biogeo$Species, as.matrix((apply(X = table_biogeo[,c(4:10)], MARGIN = 1, FUN = paste, collapse = "")))))

write.table(table_DEC_biogeo, "../../../Data/DEC_BGB/7_area_biogeography_Orecto.txt", sep ="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

make_table_BioGeoBEARS <- function(time_periods_table, prefix){
    temp_length <- (ncol(time_periods_table) - 2)
    table_adjacency <- c()
    table_dispersal <- c()
    temp_mat_adj <- matrix(0, temp_length, temp_length)
    for(i in 1:nrow(time_periods_table)){
        temp_mat_adj <- matrix(0, temp_length, temp_length)
        temp_period_table <- time_periods_table[i, c(3:ncol(time_periods_table))]
        from <- c()
        to <- c()
        
        for(j in 1:temp_length){
            if(temp_period_table[j] != "0"){
                temp_mat_adj[j,eval(parse(text = temp_period_table[j]))] <- 1
                from <- c(from, rep(j,length(eval(parse(text = temp_period_table[j])))))
                to <- c(to, eval(parse(text = temp_period_table[j])))
            }
        }
        
        nodes <- tibble(id = 1:temp_length)
        edges <- tibble(from = from, to = to)
        
        temp_data_from <- edges[edges[,1] != edges[,2],]

        temp_data_to_1 <- edges[edges[,1] != edges[,2],]

        temp_data_to_2 <- edges[edges[,1] != edges[,2],]

        colnames(temp_data_to_1) <- c("to", "to_2")

        colnames(temp_data_to_2) <- c("to_2", "to_3")

        temp_data_03 <- merge(temp_data_from, temp_data_to_1, by = "to")
        temp_data_03 <- temp_data_03[temp_data_03[,2] != temp_data_03[,3],]

        temp_data_04 <- merge(temp_data_03, temp_data_to_1, by = "to_2")
        temp_data_04 <- temp_data_04[temp_data_04[,3] != temp_data_04[,4],]

        temp_mat_dispersal <- matrix(0.001, 7, 7)
        
        temp_data_direct <- as.matrix(edges)
        
        for(k in 1:nrow(temp_data_direct)){
            if(temp_data_direct[k,1] == temp_data_direct[k,2]){
                temp_mat_dispersal[temp_data_direct[k,1], temp_data_direct[k,2]] <- 1 
            }
            if(temp_data_direct[k,1] != temp_data_direct[k,2]){
                temp_mat_dispersal[temp_data_direct[k,1], temp_data_direct[k,2]] <- 0.5
            }
        
        }

        for(k in 1:nrow(temp_data_03)){
            if(temp_mat_dispersal[temp_data_03[k,2], temp_data_03[k,3]] == 0.001){
                temp_mat_dispersal[temp_data_03[k,2], temp_data_03[k,3]] <- 0.25
            }
        }

        for(k in 1:nrow(temp_data_04)){
            if(temp_mat_dispersal[temp_data_04[k,3], temp_data_04[k,4]] == 0.001){
                temp_mat_dispersal[temp_data_04[k,3], temp_data_04[k,4]] <- 0.125
            }
        }
        
        table_adjacency <- rbind(table_adjacency, LETTERS[1:7], temp_mat_adj, matrix(data=" ", ncol=7, nrow=1))
        
        table_dispersal <- rbind(table_dispersal, LETTERS[1:7], temp_mat_dispersal, matrix(data=" ", ncol=7, nrow=1))
    }
    table_adjacency <- rbind(table_adjacency, cbind("END", matrix(data = " ", ncol=6, nrow=1)))
    table_dispersal <- rbind(table_dispersal, cbind("END", matrix(data = " ", ncol=6, nrow=1)))
    write.table(time_periods_table[,2], paste(prefix, "_time_period.txt", sep = ""), sep ="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
    write.table(table_adjacency, paste(prefix, "_area_matrix.txt", sep = ""), sep ="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
    write.table(table_dispersal, paste(prefix, "_dispersal_matrix.txt", sep = ""), sep ="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

data <- make_table_BioGeoBEARS(table, "../../../Data/DEC_BGB/7_area")
