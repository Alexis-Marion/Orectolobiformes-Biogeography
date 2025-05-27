################################################################################
################# Accessory functions to plot PyRate outputs ###################
################################################################################

library(ggplot2)
library(deeptime)
library(pammtools)
library(cowplot)

## Function for age ---------------------------------

get_age_bound<-function(data){
mn<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=min(data$time),][nrow(deeptime::epochs[deeptime::epochs[,3]<=min(data$time),]),]))
mx<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=max(data$time),][nrow(deeptime::epochs[deeptime::epochs[,3]<=max(data$time),]),]))
  
output<-list(deeptime::epochs[mn:mx,2],deeptime::epochs[mn:mx,])
    return(output)
}

## Function for preservation rates ---------------------------------

correct_q<-function(q_df,ltt_df){
  return(rbind(q_df, c(min(ltt_df$Age), q_df[nrow(q_df),2], q_df[nrow(q_df),3], q_df[nrow(q_df),4])))
}


## Function for Rates Through Time (RTT) plots ---------------------------------
rtt_plot <- function(data, #has to be formatted as the output of the `extract_rtt()` function from the `extract_param_from_PyRate_outputs.r` script
                     type = c("sp", "ex", "SpEx", "net"), #type of rates we want to represent ("SpEx" => combined speciation and extinction)
                     restrict_y = TRUE, restrict_thr = 1.4, #should we restrict y scale to a certain threshold?
                     x_breaks = get_age_bound(data)[[1]],
                     y_breaks = seq(from = -1.4, to = 1.4, by = 0.2),
                     y_labels = c(-1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4),
                     y_limits = c(-1.5, 1.5),
                     main=NA,
                     x_lab = "Time (Ma)",
                     y_lab = "Rate (event/lineage/Myr)",
                     geoscale = get_age_bound(data)[[2]],
                     abbr = TRUE #geologic times displayed with abbreviations?
                     ){
  #Restrict `data` to erase outliers from plotting window
  if(restrict_y){
    for(col in colnames(data)[-which(colnames(data) == "time")]){
      idx <- which(data[, col] > restrict_thr)
      if(length(idx) > 0){
        data[idx, col] <- restrict_thr
      }
    }
  }
  #Plot
  if(type == "sp"){
    p <- ggplot(data = data, aes(x = time, y = sp_rate)) +
      geom_ribbon(data = data, aes(x = time, ymin = sp_minHPD, ymax = sp_maxHPD),
                  fill = "#4c4cec",
                  alpha = 0.2) +
      geom_line(aes(x = time, y = sp_rate),
                linewidth = 1, colour = "#4c4cec")
  }
  else if(type == "ex"){
    p <- ggplot(data = data, aes(x = time, y = ex_rate)) +
      geom_ribbon(data = data, aes(x = time, ymin = ex_minHPD, ymax = ex_maxHPD),
                  fill = "#e34a33",
                  alpha = 0.2) +
      geom_line(aes(x = time, y = ex_rate),
                linewidth = 1, colour = "#e34a33")
  }
  else if(type == "SpEx"){
    p <- ggplot(data = data, aes(x = time, y = sp_rate)) +
      geom_ribbon(data = data, aes(x = time, ymin = sp_minHPD, ymax = sp_maxHPD),
                fill = "#4c4cec",
                alpha = 0.2) +
      geom_ribbon(data = data, aes(x = time, ymin = ex_minHPD, ymax = ex_maxHPD),
                  fill = "#e34a33",
                  alpha = 0.2) +
      geom_line(aes(x = time, y = sp_rate),
                linewidth = 1, colour = "#4c4cec",) +
      geom_line(aes(x = time, y = ex_rate),
                linewidth = 1, colour = "#e34a33")
  }
  else if(type == "net"){
    p <- ggplot(data = data, aes(x = time, y = net_rate)) +
      geom_ribbon(data = data, aes(x = time, ymin = net_minHPD, ymax = net_maxHPD),
                  fill = "#504A4B",
                  alpha = 0.2) +
      geom_line(aes(x = time, y = net_rate),
                linewidth = 1, colour = "#504A4B") +
      geom_hline(yintercept = 0,
                 linetype = "dashed", colour = "red")
  }
  p <- p +
    scale_x_reverse(breaks = x_breaks) +
    scale_y_continuous(breaks = y_breaks,
                       labels = y_labels,
                       limits = y_limits) +
     labs(x = x_lab,
         y = y_lab) +
    theme(axis.title.x = element_text(size = 20),
          axis.title.y = element_text(size = 20),
          axis.text = element_text(size = 15),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_geo(dat = geoscale, abbrv = abbr, size = 5)
  return(p)
}


get_age_bound2<-function(data){
mn<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),]),]))
mx<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),]),]))
  
output<-list(deeptime::epochs[mn:mx,2],deeptime::epochs[mn:mx,])
    return(output)
}


## Function for Lineage Through Time (LTT) plot from individual replicates -----
ltt_plot <- function(ltt_df, #has to be in the format returned by the `extract_ltt()` function from the `extract_param_from_PyRate_outputs.r` script
                     x_breaks = get_age_bound2(ltt_df)[[1]],
                     y_breaks = seq(0,250,50),
                     y_labels = seq(0,250,50),
                     y_limits = c(0, 250),
                     main=NA,
                     x_lab = "Time (Ma)",
                     y_lab = "Diversity (nb. lineages)",
                     geoscale = get_age_bound2(ltt_df)[[2]],
                     abbr = TRUE){
  # Proper plot
  p <- ggplot(data = ltt_df, aes(x = Age, y = Diversity)) +
    scale_x_reverse(breaks = x_breaks) +
    scale_y_continuous(breaks = y_breaks,
                       limits = y_limits) +
    geom_ribbon(aes(x = Age, ymin = min_Diversity, ymax = max_Diversity), 
                fill = "#a1d99b",
                alpha = 0.8) +
    geom_line(linewidth = 1, colour = "#329507") +
    xlab(x_lab) +
    ylab(y_lab) +
    theme(axis.title.x = element_text(size = 20),
          axis.title.y = element_text(size = 20),
          axis.text = element_text(size = 15),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_geo(dat = geoscale, abbrv = abbr, size = 5)
    return(p)
}

## Function to combine RTT and LTT plots in a single figure --------------------
comb_ltt_rtt <- function(SpEx_plot, net_plot, ltt_plot, q_plot=NA, n_plots=c(3,4)){ #if n_plots = 4, needs q_plot not to be NA
  if(n_plots == 3){
    top_row <- cowplot::plot_grid(SpEx_plot, net_plot,
                                  ncol = 2,
                                  rel_widths = c(1/2, 1/2))
    bottom_row <- cowplot::plot_grid(NULL, ltt_plot, NULL,
                                     ncol = 3,
                                     rel_widths = c(1, 2.5, 1))
    p <- cowplot::plot_grid(top_row, bottom_row, nrow = 2)
  }
  else{
    top_row <- cowplot::plot_grid(SpEx_plot, net_plot,
                                  ncol = 2,
                                  rel_widths = c(1/2, 1/2))
    bottom_row <- cowplot::plot_grid(ltt_plot, q_plot,
                                     ncol = 2,
                                     rel_widths = c(1/2, 1/2))
    p <- cowplot::plot_grid(top_row, bottom_row, nrow = 2)
  }
  return(p)
}

## Preservation rates plot -----------------------------------------------------
q_plot <- function(data, ltt_input,  #input data containing Q rates assembled from all replicates => output from `parse_Q_rates.py`
                   x_breaks = correct_q(data, ltt_input)$Age,
                   y_breaks = seq(from = 0, to = 2, by = 0.2),
                   y_labels = seq(from = 0, to = 2, by = 0.2),
                   y_limits = c(0, 2.1),
                   x_lab = "Time (Ma)",
                   y_lab = "Preservation rate (occurrence/lineage/Myr)",
                   geoscale = get_age_bound2(ltt_input)[2],
                   abbr = TRUE
                   ){
  q.plot <- ggplot(correct_q(data, ltt_input), aes(x = Age, y = mean_Q))+
    scale_x_reverse(breaks = x_breaks) +
    scale_y_continuous(breaks = y_breaks,
                       labels = y_labels,
                       limits = y_limits) +
    geom_stepribbon(data=correct_q(data, ltt_input), mapping=aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                    fill = "#260154",
                    alpha = 0.2) +
    geom_step(aes(x = Age, y = mean_Q),
              linewidth = 1, colour = "#260154") +
    labs(x = x_lab,
         y = y_lab) +
    theme(axis.title.x = element_text(size = 20),
          axis.title.y = element_text(size = 20),
          axis.text = element_text(size = 15),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
    coord_geo(dat = geoscale, abbrv = abbr, size = 4)
  return(q.plot)
}
