tree_grafting_manual<-function(phy, data_frame_fossil, fossil, taxa_list, seed_value){
set.seed(seed_value)
data_frame_fossil$Ts<-as.numeric(str_replace(data_frame_fossil$Ts, "-", ""))
data_frame_fossil$Te<-as.numeric(str_replace(data_frame_fossil$Te, "-", ""))
tab_fossil<-data_frame_fossil[data_frame_fossil$Latin_binom==fossil,]

Ts <- tab_fossil$Ts
Ts_sd <- tab_fossil$Ts_sd
Te <- tab_fossil$Te
Te_sd <- tab_fossil$Te_sd
    
Ts<-rnorm(1, Ts, Ts_sd)
Te<-rnorm(1, Te, Te_sd)
while(Ts < Te){
    Ts<-rnorm(1, Ts, Ts_sd)
    Te<-rnorm(1, Te, Te_sd)
}
            tree_ages <- tree.age(phy, order = "past", fossil = TRUE, digits = 3)
    
            if(length(taxa_list) > 1){
                TO_C <- c(tree_ages[tree_ages[, 2] == getMRCA(phy, taxa_list), ][, 1])
                TO_S <- c(tree_ages[tree_ages[, 2] == phy$edge[phy$edge[, 2] == getMRCA(phy, taxa_list), 1], ][, 1])
                tree_clade <- getMRCA(phy, taxa_list)
            }
    
            if(length(taxa_list) == 1){
                TO_C <- 0
                TO_S <- c(tree_ages[tree_ages[, 2] == phy$edge[phy$edge[, 2] == which(phy$tip.label == taxa_list), 1], ][, 1])
                tree_clade <- which(phy$tip.label == taxa_list)
            }
    
            if(Ts > TO_C & Ts < TO_S){
                edge_length <- (TO_S - TO_C)
                Ts_branch <- runif(1, min = (Ts-TO_C), max = edge_length)
                Te_branch <- TO_C + Ts_branch - Te
                phy <- AddTip(phy, tree_clade, label = tab_fossil$Latin_binom, lengthBelow = Ts_branch, edgeLength = Te_branch)
            }
    
            if(Ts < TO_C & Ts < TO_S){
                edge_length <- (TO_S - TO_C)
                Ts_branch <- runif(1, min = 0, max = edge_length)
                Te_branch <- TO_C + Ts_branch - Te
                phy <- AddTip(phy, tree_clade, label = tab_fossil$Latin_binom, lengthBelow = Ts_branch, edgeLength = Te_branch)
            }
            if(Ts > TO_S){
                warning("Incompatible branching patterns")

            }
    return(phy)
}
