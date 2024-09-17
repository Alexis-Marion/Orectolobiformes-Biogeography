plot_ancestral_states = function(tree_file, 
                                 summary_statistic="MAP", 
                                 tree_layout="rectangular",
                                 include_start_states=FALSE, 
                                 xlim_visible=c(0, 40), 
                                 ylim_visible=NULL,
                                 tip_label_size=4, 
                                 tip_label_offset=3,
                                 node_label_size=4, 
                                 node_label_hjust=-0.2, 
                                 shoulder_label_size=3, 
                                 shoulder_label_hjust=1.5, 
                                 alpha=0.5, 
                                 node_size_range=c(6, 15), 
                                 color_low="#D55E00",
                                 color_mid="#F0E442",
                                 color_high="#009E73") { 

    if ( (summary_statistic %in% c("MAP", "mean", "MAPChromosome")) == FALSE ) {
        print("Invalid summary statistic.")
        return()
    }

    # read in tree
    t = read.beast(tree_file)
    tree = attributes(t)$phylo
    n_node = getNodeNum(tree)

    # remove underscores from tip labels
    attributes(t)$phylo$tip.label = gsub("_", " ", attributes(t)$phylo$tip.label)

    # add tip labels
    p = ggtree(t, layout=tree_layout) 
    p = p + geom_tiplab(size=tip_label_size, offset=tip_label_offset)
       

    if (summary_statistic == "MAPChromosome") {
        
        if (include_start_states) {
            
            if (!("start_state_1" %in% colnames(attributes(t)$stats))) {
                print("Start states not found in input tree.")
                return()
            }

            # add ancestral states as node labels
            p = p + geom_text(aes(label=end_state_1), hjust=node_label_hjust, size=node_label_size)

            # set the root's start state to NA
            attributes(t)$stats$start_state_1[n_node] = NA

            # add clado daughter lineage start states on "shoulders" of tree
            # get x, y coordinates of all nodes
            x = getXcoord(tree)
            y = getYcoord(tree)
            x_anc = numeric(n_node)
            node_index = numeric(n_node)
            for (i in 1:n_node) {
                if (getParent(tree, i) != 0) {
                    # if not the root, get the x coordinate for the parent node
                    x_anc[i] = x[getParent(tree, i)]
                    node_index[i] = i
                }
            }
            shoulder_data = data.frame(node=node_index, x_anc=x_anc, y=y)
            p = p %<+% shoulder_data
            
            # plot the states on the "shoulders"
            p = p + geom_text(aes(label=start_state_1, x=x_anc, y=y), hjust=shoulder_label_hjust, size=shoulder_label_size, na.rm=TRUE)
            
            # show ancestral states as size / posteriors as color
            p = p + geom_nodepoint(aes(colour=end_state_1_pp, size=end_state_1), alpha=alpha)
            min_low = 0.0
            max_up = 1.0
            p = p + scale_colour_gradient2(low=color_low, mid=color_mid, high=color_high, limits=c(min_low, max_up), midpoint=0.5)
            p = p + guides(size = guide_legend("Chromosome Number"))
            p = p + guides(colour = guide_legend("Posterior Probability", override.aes = list(size=8)))

        } else {
    
            if (!("anc_state_1" %in% colnames(attributes(t)$stats))) {
                anc_data = data.frame(node=names(attributes(t)$stats$end_state_1), 
                                      anc_state_1=as.numeric(levels(attributes(t)$stats$end_state_1))[attributes(t)$stats$end_state_1],
                                      anc_state_1_pp=as.numeric(levels(attributes(t)$stats$end_state_1_pp))[attributes(t)$stats$end_state_1_pp])
                p = p %<+% anc_data
            }

            # add end states as node labels
            p = p + geom_text(aes(label=anc_state_1), hjust=node_label_hjust, size=node_label_size)

            # show ancestral states as size / posteriors as color
            p = p + geom_nodepoint(aes(colour=end_state_1_pp, size=end_state_1), alpha=alpha)
            min_low = 0.0
            max_up = 1.0
            p = p + scale_colour_gradient2(low=color_low, mid=color_mid, high=color_high, limits=c(min_low, max_up), midpoint=0.5)
            p = p + guides(size = guide_legend("Chromosome Number"))
            p = p + guides(colour = guide_legend("Posterior Probability", override.aes = list(size=8)))
        }

    } else if (summary_statistic == "MAP") {

        if (include_start_states) {
            print("Start states not yet implemented for MAP ancestral states.")
            return()
    
        }
        
        if (!("anc_state_1" %in% colnames(attributes(t)$stats))) {
            anc_data = data.frame(node=names(attributes(t)$stats$end_state_1), 
                                  anc_state_1=as.numeric(levels(attributes(t)$stats$end_state_1))[attributes(t)$stats$end_state_1],
                                  anc_state_1_pp=as.numeric(levels(attributes(t)$stats$end_state_1_pp))[attributes(t)$stats$end_state_1_pp])
            p = p %<+% anc_data
        }

        # add ancestral states as node labels
        p = p + geom_text(aes(label=anc_state_1), hjust=node_label_hjust, size=node_label_size)

        # show ancestral states as size / posteriors as color
        p = p + geom_nodepoint(aes(colour=anc_state_1_pp, size=anc_state_1), alpha=alpha)
        
        # show the tip values
        p = p + geom_tippoint(aes(size=anc_state_1), color="grey", alpha=alpha)
        
        # set up the legend
        min_low = 0.0
        max_up = 1.0
        p = p + scale_colour_gradient2(low=color_low, mid=color_mid, high=color_high, limits=c(min_low, max_up), midpoint=0.5)
        p = p + guides(size = guide_legend("State"))
        p = p + guides(colour = guide_legend("Posterior Probability", override.aes = list(size=4)))


    } else if (summary_statistic == "mean") {
    
        if (include_start_states) {
            print("Start states not implemented for mean ancestral states.")
            return()
        }

        # add ancestral states as node labels
        p = p + geom_text(aes(label=round(mean, 2)), hjust=node_label_hjust, size=node_label_size)

        # show the size of the 95% CI as color 
        lowers = as.numeric(levels(attributes(t)$stats$lower_0.95_CI))[attributes(t)$stats$lower_0.95_CI]
        uppers = as.numeric(levels(attributes(t)$stats$upper_0.95_CI))[attributes(t)$stats$upper_0.95_CI]
        diffs = uppers - lowers
        diffs_df = data.frame(node=names(attributes(t)$stats$lower_0.95_CI), diff_vals=diffs)
        p = p %<+% diffs_df 

        min_low = min(diffs, na.rm=TRUE)
        max_up = max(diffs, na.rm=TRUE)
        mid_val = min_low + (max_up - min_low) / 2.0
        p = p + scale_colour_gradient2(low=color_low, mid=color_mid, high=color_high, limits=c(min_low, max_up), midpoint=mid_val)
        p = p + geom_nodepoint(aes(size=mean, colour=diff_vals), alpha=alpha)

        # show the tip values
        p = p + geom_tippoint(aes(size=mean), color="grey", alpha=alpha)

        # set up the legend
        legend_text = "Mean State"
        p = p + guides(size = guide_legend(legend_text))
        p = p + guides(colour = guide_legend("95% CI Width", override.aes=list(size=4)))
        
    
    } 
    p = p + scale_size(range = node_size_range)
    p = p + theme(legend.position="left")

    # set visible area
    p = p + coord_cartesian(xlim = xlim_visible, ylim=ylim_visible, expand=TRUE)
    print(p)
    return(p)
}
