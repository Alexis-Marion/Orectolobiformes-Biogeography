library("stringr")
library("phytools")
library("ggtree")
library("ggplot2")
library("ggpmisc")
library("deeptime")

args = commandArgs(trailingOnly=TRUE)

trait_model<-readRDS(args[1])
phy<-read.tree("../../../Data/consensus_tree_orecto.tree")

if(args[2] == 3){
   trait_model <- trait_model[,-(ncol(trait_model) - 1)] 
}

phy$tip.label <- gsub("_", " ", phy$tip.label)

node_states_biogeo <- trait_model[(length(phy$tip.label) + 1):(2*length(phy$tip.label) - 1),]
tip_states_biogeo <- trait_model[1:length(phy$tip.label),]

color_list <- c("#DAA07F", "#E3DCB8", "#C8E8AB", "#B0E9D5", "#B68FCD", "#FFD1C2", "#569BE0", 
                "#e0be9b", "#ef6f7f", "chocolate",
                "#697F5C", "darkorchid",
                "#add0bd",  "#c72c48",
                "coral", "#b7a2cf",
                "darkseagreen", "deepskyblue", "darkcyan", "Grey")

color_list <- setNames(color_list, (c(1:8,12,13,14,19,20,23,24,26,28,63,123, "Uncertain")))

phylo_plot <- ggtree(phy) +
           geom_tiplab(offset = 2, fontface = "italic", size = 2) +
           theme_bw() +
           theme(panel.border = element_blank(),
           legend.key = element_blank(),
           axis.ticks = element_blank(),
           axis.text.y = element_blank(),
           axis.text.x = element_blank(),
           panel.grid = element_blank(),
           panel.grid.minor = element_blank(), 
           panel.grid.major = element_blank(),
           panel.background = element_blank(),
           plot.background = element_rect(fill = "transparent",colour = NA)) + 
coord_geo(neg = T, pos = as.list(rep("bottom", 2)),
dat = list("epochs", "periods"), height = list(unit(1, "lines"), unit(1, "line")), size = list(2, 3), abbrv = "auto", skip = c("Pliocene", "Pleistocene", "Holocene"))

phylo_plot <- revts(phylo_plot) +
           xlim(-250, 100) + ylim(0, 40)

pies <- nodepie(node_states_biogeo, cols=1:(ncol(trait_model)-1), color=color_list, alpha=1)
anc <- tibble::tibble(node=as.numeric(node_states_biogeo$node), pies=pies)

phy_plot_anc <- phylo_plot %<+% anc
phy_plot_anc <- phy_plot_anc + geom_plot(data=td_filter(!isTip), mapping=aes(x=x,y=y, label=pies), vp.width=0.04, vp.height=0.04, hjust=0.6, vjust=0.6)

tips_vec <- c()

for(i in 1:nrow(tip_states_biogeo)){
    temp_tip_states_biogeo <- tip_states_biogeo[,-ncol(tip_states_biogeo)]
    tips_vec <- c(tips_vec, colnames(temp_tip_states_biogeo)[which(temp_tip_states_biogeo[i,]==1)])
}

tips_vec <- as.factor(tips_vec)
levels(tips_vec) <- c(levels(tips_vec), setdiff(rownames(tip_states_biogeo[-1]), levels(tips_vec)))
df_tips <- data.frame(Species = phy$tip.label, tips_vec)

phy_complete <- phy_plot_anc %<+% df_tips
ASE_plot <- phy_complete + geom_tippoint(aes(color = as.character(tips_vec)), show.legend = TRUE) + 
    scale_color_manual(values = color_list, drop = TRUE, limits = names(color_list)) +
    theme(legend.position = c(0.20, 0.875)) + 
guides(color = guide_legend(ncol=4, title = "Biogeographic regions"))

ggsave(ASE_plot, filename = args[3],  bg = "transparent")
