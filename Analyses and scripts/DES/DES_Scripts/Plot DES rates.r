library("ggplot2")
library("deeptime")
library("pammtools")
library("cowplot")
library("stringr")
library("palaeoverse")
library("ape")
library("ggstream")

args <- commandArgs(trailingOnly = TRUE)

type = args[1]

is.in.interval<-function(age1, age2, interval1, interval2){
    temp_vec<-(-seq(round(age1, 1), round(age2, 1), by = 0.1))
    if(interval1 %in% temp_vec | interval2 %in% temp_vec){
        return(TRUE)
    }
    else{
        return(FALSE)
    }
}

get_age_bound <- function(data){
mn <- as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),]),]))
mx <- as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),]),]))
  
output <- list(deeptime::epochs[mn:mx,2],deeptime::epochs[mn:mx,])
    return(output)
}


extract_ltt <- function(dir){
  files <- Sys.glob(paste0(dir, "*_ltt.txt"))
  files <- files[grepl(pattern = "KEEP", x = files)]
  ltt <- read.table(files[1], header = TRUE)
  ltt$time <- unlist(lapply(X = ltt$time, FUN = round, digits = 1))
  if(length(which(ltt$time > 500)) > 0){
    ltt <- ltt[-which(ltt$time > 500), c("time", "diversity")]
  }
  else{
    ltt <- ltt[, c("time", "diversity")]
  }
  ltt <- ltt %>% rename(diversity_1 = "diversity")
  i = 2
  for(file in files[2:length(files)]){
    f <- read.table(file, header = TRUE)
    if(length(which(f$time > 500)) > 0){
      f <- f[-which(f$time > 500), c("time", "diversity")]
    }
    else{
      f <- f[, c("time", "diversity")]
    }
    f$time <- unlist(lapply(X = f$time, FUN = round, digits = 1))
    colnames(f) <- c("time", paste0("diversity_", i))
    ltt <- merge(ltt, f, by = "time", all = T)
    i <- i+1
  }
  LTT <- data.frame(Age = ltt$time,
                    Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                      MARGIN = 1,
                                      FUN = mean,
                                      na.rm = TRUE),
                    min_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                          MARGIN = 1,
                                          FUN = min,
                                          na.rm = TRUE),
                    max_Diversity = apply(X = ltt[,c(2:ncol(ltt))],
                                          MARGIN = 1,
                                          FUN = max,
                                          na.rm = TRUE))
  
  return(LTT)
}

data_maker<-function(ltt_OT, ltt_M, ltt_T){
data<-c()
for(i in 1:nrow(ltt_T)){
    vec_T<-c(ltt_T[i,1], "T", ltt_T[i,2])
    if(ltt_T[i,1] %in% ltt_OT[i,1]){
        vec_S<-c(ltt_T[i,1], "OT", ltt_OT[i,2])  
    }
    else{
        vec_S<-c(ltt_T[i,1], "OT", 0) 
    }
    if(ltt_T[i,1] %in% ltt_M[i,1]){
        vec_M<-c(ltt_T[i,1], "C", ltt_M[i,2])
    }
    else{
        vec_M<-c(ltt_T[i,1], "C", 0) 
    }
data<-rbind(data,vec_T, vec_S, vec_M)
data<-as.data.frame(data)
colnames(data)<-c("Age", "Geography", "Sample")
data$Sample<-as.numeric(data$Sample)
data$Age<-(as.numeric(data$Age))   
} 
return(data)
} 

unique_geo <- function(df){
    vec <- unique(unclass(df))
    if(1 %in% vec){
        x <- "outside_tethys"
    }
    if(2 %in% vec){
        x <- "tethys"
    }  
    if(1 %in% vec & 2 %in% vec | 3 %in% vec){
        x <- "cosmopolitan"
    }
    return(x)
}

breaks_fun <- function(max_num){
    tot_vec <- c(0.01, 0.02, 0.05, 0.1, 0.2, 0.5)
    return(tot_vec[which.min(abs(c(length(seq(0, max_num, by = 0.01)), length(seq(0, max_num, by = 0.02)), length(seq(0, max_num, by = 0.05)),
    length(seq(0, max_num, by = 0.1)), length(seq(0, max_num, by = 0.2)), length(seq(0, max_num, by = 0.5)))- 10))])
}

get_age_bound<-function(data, type = 1){
    mn<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=min(data$Age),]),]))
    mx<-as.numeric(rownames(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),][nrow(deeptime::epochs[deeptime::epochs[,3]<=max(data$Age),]),])) 
    output<-list(deeptime::epochs[mn:mx,2],deeptime::epochs[mn:mx,])
return(output)
}

DES_rates <- function(list_files_DES_rates, burnin = 1000){
    whole_tab_rates <- c()
    tab_rates <- c()
    for(i in list_files_DES_rates){
        table <- read.table(i, sep ="\t", header = TRUE)
        table_burnin <- table[-c(1:burnin),]
        whole_tab_rates <- rbind(whole_tab_rates, table_burnin)
    }   
    return(whole_tab_rates)
}

PyRate_turnover_rates <- function(list_files_PyRate_rates, trimming = FALSE){
    list_files_PyRate_rates <- list_files_PyRate_rates[grepl(pattern = "KEEP", x = list_files_PyRate_rates)]
    whole_tab_PyRate_rates <- c()
    for(i in list_files_PyRate_rates){
        table_PyRate <- read.table(i, header = TRUE)
        table_burnin <- table_PyRate[-c(1:100),]
        if(trimming){
            table_trimmed <- table_PyRate[, -c(2:17, 
                                        seq(2 + (ncol(table_burnin) - 1)/3, ((ncol(table_burnin) - 1)/3 + 17), by = 1),
                                        seq(2 + 2*(ncol(table_burnin) - 1)/3, (2*(ncol(table_burnin) - 1)/3 + 17), by = 1)), ]
            temp_table <- cbind(unique(as.vector(table_trimmed))[2], unique(as.vector(table_trimmed))[3], unique(as.vector(table_trimmed))[4],
                           unique(as.vector(table_trimmed))[5], unique(as.vector(table_trimmed))[6], unique(as.vector(table_trimmed))[7])
            whole_tab_PyRate_rates <- rbind(whole_tab_PyRate_rates, temp_table)
            
        }
        else{
            temp_table <- cbind(unique(as.vector(table_burnin))[2], unique(as.vector(table_burnin))[3], unique(as.vector(table_burnin))[4],
                                unique(as.vector(table_burnin))[5], unique(as.vector(table_burnin))[6], unique(as.vector(table_burnin))[7])
            whole_tab_PyRate_rates <- rbind(whole_tab_PyRate_rates, temp_table)  
        }

    }
    turnover_rate_tab <- cbind(as.numeric(unlist(whole_tab_PyRate_rates[,1])) + as.numeric(unlist(whole_tab_PyRate_rates[,4])),
    as.numeric(unlist(whole_tab_PyRate_rates[,2])) + as.numeric(unlist(whole_tab_PyRate_rates[,5])),
    as.numeric(unlist(whole_tab_PyRate_rates[,3])) + as.numeric(unlist(whole_tab_PyRate_rates[,6])))
    return(turnover_rate_tab)
}

extract_data_DES <- function(table, val, upper_bound, time_slices){
       temp_col <- colnames(table)[grep(val, colnames(table))]
    q_low <- nrow(table)*0.025
    q_high <- nrow(table)*0.975
    clean_data <- data.frame()
    for(i in temp_col){
        temp_vec <- table[colnames(table) == i]
        sorted_vec <- sort(temp_vec[,1])
        extinction_vec <- c(as.numeric(str_split_fixed(i, "_t", 2)[1,2]), sorted_vec[q_low], 
                        median(sorted_vec), sorted_vec[q_high])
        clean_data <- rbind(clean_data, extinction_vec)
    }
    temp_vec <- c(upper_bound, clean_data[,1])
    clean_data <- rbind(clean_data, clean_data[nrow(clean_data), ])
    clean_data[,1] <- temp_vec   
    colnames(clean_data) <- c("Age", "min_HPD", "median", "max_HPD")
    if(exists("time_slices")){
        clean_data$Age <- time_slices
    }
    return(clean_data)
}

extract_data_PyRate <- function(table, vec){

    clean_data <- data.frame()
    q_low <- nrow(table)*0.025
    q_high <- nrow(table)*0.975
    
    for(i in 1:ncol(table)){
        temp_vec <- table[,i]
        sorted_vec <- sort(temp_vec)
        extinction_vec <- c(vec[i], sorted_vec[q_low], median(sorted_vec), sorted_vec[q_high])
        clean_data <- rbind(clean_data, extinction_vec)
    }
    colnames(clean_data) <- c("Age", "min_HPD", "median", "max_HPD")
    last_vec <- c(0, clean_data[nrow(clean_data), -1])
    names(last_vec) <- c("Age", "min_HPD", "median", "max_HPD")
    clean_data <- rbind(clean_data, last_vec) 
    return(clean_data)
}

make_tab <- function(tab_init){
    tab<-c()
    for(i in seq(-100.5, 0, by = 0.5)){
        div_vec<-c(i)
        div<-0
        for (k in 1:nrow(tab_init)){
            if (is.in.interval(as.numeric(tab_init[k,2]), as.numeric(tab_init[k,1]), i, i + 0.5)){
                div <- div + 1
            }
        }
        div_vec<-c(div_vec, div)
        tab<-rbind(tab, div_vec)
    }
    return(tab)
}

plot_DES_rates <- function(data_1, data_2, 
                   x_breaks = data_1$Age,
                   y_breaks = seq(from = 0, to = c(round(max(data_1$max_HPD), 1) + 0.1), by = breaks_fun(round(max(data_1$max_HPD), 1))),
                   y_labels = seq(from = 0, to = c(round(max(data_1$max_HPD), 1) + 0.1), by = breaks_fun(round(max(data_1$max_HPD), 1))),
                   y_limits = c(0, c(round(max(data_1$max_HPD), 1) + 0.05)),
                   x_lab = "Time (Ma)",
                   y_lab = "Rate (event/lineage/Myr)",
                   geoscale = get_age_bound(data_1)[2],
                   abbr = TRUE,
                   colour = c("#260154", "#B0E9D5")
                   ){
    
    data_1[data_1$max_HPD>max(y_limits),4] <- max((y_limits))
    data_2[data_2$max_HPD>max(y_limits),4] <- max((y_limits))   
    
    rate.plot <- ggplot(data_1, aes(x = Age, y = median))+
        scale_x_reverse(breaks = x_breaks) +
        scale_y_continuous(breaks = y_breaks,
                           labels = y_labels,
                           limits = y_limits) +
    geom_stepribbon(data = data_1, mapping=aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                    fill = colour[1],
                    alpha = 0.25) +
    geom_stepribbon(data = data_2, mapping=aes(x = Age, ymin = min_HPD, ymax = max_HPD),
                    fill = colour[2],
                    alpha = 0.25) +
    geom_step(data = data_1, aes(x = Age, y = median),
              linewidth = 2, colour = colour[1]) +
    geom_step(data = data_2, aes(x = Age, y = median),
              linewidth = 2, colour = colour[2]) +
    labs(x = x_lab,
         y = y_lab) +
    theme(axis.title.x = element_text(size = 10),
          axis.title.y = element_text(size = 10),
          axis.text.x = element_text(size = 8), 
          axis.text.y = element_text(size = 8), 
          axis.text = element_text(size = 10),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
          coord_geo(dat = geoscale, abbrv = abbr, size = 4, )
  return(rate.plot)
}

ltt_plot <- function(ltt_df_1,
                     ltt_df_2,
                     x_breaks = c(0, 33.9, 66, 100.5),
                     y_labels = seq(0,250,50),
                     y_limits = c(0,max(ltt_df_1$max_Diversity, ltt_df_2$max_Diversity)),
                     y_breaks = seq(0, y_limits[2], 5),
                     main=NA,
                     x_lab = "Time (Ma)",
                     y_lab = "Diversity (nb. lineages)",
                     geoscale = get_age_bound(ltt_df_2)[[2]],
                     abbr = TRUE){
  p <- ggplot() +
    scale_x_reverse(breaks = x_breaks) +
    scale_y_continuous(breaks = y_breaks,
                       limits = y_limits) +
    geom_ribbon(data = ltt_df_1, aes(x = Age, ymin = min_Diversity, ymax = max_Diversity), 
                fill = "#B0E9D5",
                alpha = 0.25) +
    geom_ribbon(data = ltt_df_2, aes(x = Age, ymin = min_Diversity, ymax = max_Diversity), 
                fill = "#DAA07F",
                alpha = 0.25) +
    
    geom_line(data = ltt_df_2, aes(x = Age, y = Diversity), linewidth = 2, colour = "#DAA07F") +
    geom_line(data = ltt_df_1, aes(x = Age, y = Diversity), linewidth = 2, colour = "#B0E9D5") +
    xlab(x_lab) +
    ylab(y_lab) +
    theme(axis.title.x = element_text(size = 10),
          axis.title.y = element_text(size = 10),
          axis.text.x = element_text(size = 8), 
          axis.text.y = element_text(size = 8), 
          axis.text = element_text(size = 10),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5)) +
          coord_geo(dat = geoscale, abbrv = abbr, size = 4)
    return(p)
}

if(type == 1){
    list_files_DES_rates <- list.files(paste("../Analysis_Bayesian/gen/", sep = ""), pattern = "G.log", full.names = TRUE)  
    DES_rates_tab <- DES_rates(list_files_DES_rates)
    Q_rates_raw_NT <- list.files("../../BDS/Results/Biogeo/Genus/outside_Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_NT <- DES_rates(Q_rates_raw_NT, 100)
    Q_rates_raw_T <- list.files("../../BDS/Results/Biogeo/Genus/Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_T <- DES_rates(Q_rates_raw_T, 100)
    list_files_PyRate_rates_NT <- list.files("../../BDS/Results/Biogeo/Genus/outside_Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    list_files_PyRate_rates_T <- list.files("../../BDS/Results/Biogeo/Genus/Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    turnover_NT_raw <- PyRate_turnover_rates(list_files_PyRate_rates_NT, TRUE)
    turnover_T_raw <- PyRate_turnover_rates(list_files_PyRate_rates_T)
    ltt_T <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_genus/Tethys/output_ltt/")
    ltt_NT <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_genus/outside_Tethys/output_ltt/")
    ltt_T <- ltt_T[ltt_T$Age > 15,]
    ltt_T <- ltt_T[ltt_T$Age < 100.5,]
    ltt_NT <- ltt_NT[ltt_NT$Age < 100.5,]
}
if(type == 2){
    list_files_DES_rates <- list.files(paste("../Analysis_Bayesian/sp/", sep = ""), pattern = "G.log", full.names = TRUE)
    DES_rates_tab <- DES_rates(list_files_DES_rates)
    Q_rates_raw_NT <- list.files("../../BDS/Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_NT <- DES_rates(Q_rates_raw_NT, 100)
    Q_rates_raw_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_T <- DES_rates(Q_rates_raw_T, 100)
    list_files_PyRate_rates_NT <- list.files("../../BDS/Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    list_files_PyRate_rates_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    turnover_NT_raw <- PyRate_turnover_rates(list_files_PyRate_rates_NT, TRUE)
    turnover_T_raw <- PyRate_turnover_rates(list_files_PyRate_rates_T)
    ltt_T <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/Tethys/output_ltt/")
    ltt_NT <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/outside_Tethys/output_ltt/")
    ltt_T <- ltt_T[ltt_T$Age > 15,]
    ltt_T <- ltt_T[ltt_T$Age < 100.5,]
    ltt_NT <- ltt_NT[ltt_NT$Age < 100.5,]
}
if(type == 3){
    list_files_DES_rates <- list.files(paste("../Analysis_Bayesian/sp_combined/", sep = ""), pattern = "G.log", full.names = TRUE)
    DES_rates_tab <- DES_rates(list_files_DES_rates)
    Q_rates_raw_NT <- list.files("../../BDS/Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_NT <- DES_rates(Q_rates_raw_NT, 100)
    Q_rates_raw_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_T <- DES_rates(Q_rates_raw_T, 100)
    list_files_PyRate_rates_NT <- list.files("../../BDS/Results/Biogeo/Species_combined/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    list_files_PyRate_rates_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    turnover_NT_raw <- PyRate_turnover_rates(list_files_PyRate_rates_NT, TRUE)
    turnover_T_raw <- PyRate_turnover_rates(list_files_PyRate_rates_T)
    ltt_T <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/Tethys/output_ltt/")
    ltt_NT <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/Combined/output_ltt/")
    ltt_T <- ltt_T[ltt_T$Age > 15,]
    ltt_T <- ltt_T[ltt_T$Age < 100.5,]
    ltt_NT <- ltt_NT[ltt_NT$Age < 100.5,]
}
if(type == 4){
    list_files_DES_rates <- list.files(paste("../Analysis_Bayesian/sp_combined_CDD/", sep = ""), pattern = "G.log", full.names = TRUE)
    DES_rates_tab <- DES_rates(list_files_DES_rates)
    Q_rates_raw_NT <- list.files("../../BDS/Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_NT <- DES_rates(Q_rates_raw_NT, 100)
    Q_rates_raw_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "mcmc.log", full.names = TRUE)
    Q_rates_T <- DES_rates(Q_rates_raw_T, 100)
    list_files_PyRate_rates_NT <- list.files("../../BDS/Results/Biogeo/Species_combined_CDD/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    list_files_PyRate_rates_T <- list.files("../../BDS/Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/", pattern = "marginal_rates.log", full.names = TRUE)
    turnover_NT_raw <- PyRate_turnover_rates(list_files_PyRate_rates_NT, TRUE)
    turnover_T_raw <- PyRate_turnover_rates(list_files_PyRate_rates_T)
    ltt_T <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/Tethys/output_ltt/")
    ltt_NT <- extract_ltt(dir = "../../BDS/Results/Biogeo/Plot_species/Combined_CDD/output_ltt/")
    ltt_T <- ltt_T[ltt_T$Age > 15,]
    ltt_T <- ltt_T[ltt_T$Age < 100.5,]
    ltt_NT <- ltt_NT[ltt_NT$Age < 100.5,]
}

extinction_T <- extract_data_DES(DES_rates_tab, "e1", 100.5, c(100.5, 66, 33.9, 0))
extinction_NT <- extract_data_DES(DES_rates_tab, "e2", 100.5, c(100.5, 66, 33.9, 0))

max_val_E <- round(max(rbind(extinction_T, extinction_NT)[,3]),1) + 0.1

extinction_plot <- plot_DES_rates(data_1 = extinction_T, data_2 = extinction_NT, colour = c("#DAA07F", "#B0E9D5"),
                   y_breaks = seq(from = 0, to = max_val_E, by = 0.05),
                   y_labels = seq(from = 0, to = max_val_E, by = 0.05),
                   y_limits = c(0, max_val_E),
                   y_lab = "Extinction rate (event/lineage/Myr)")

dispersal_T <- extract_data_DES(DES_rates_tab, "d1", 100.5, c(100.5, 66, 33.9, 0))
dispersal_NT <- extract_data_DES(DES_rates_tab, "d2", 100.5, c(100.5, 66, 33.9, 0))

max_val_D <- round(max(rbind(dispersal_T, dispersal_NT)[,3]),1) + 0.1

dispersal_plot <- plot_DES_rates(data_1 = dispersal_T, data_2 = dispersal_NT, colour = c("#B0E9D5","#DAA07F"),
                   y_breaks = seq(from = 0, to = max_val_D, by = 0.05),
                   y_labels = seq(from = 0, to = max_val_D, by = 0.05),
                   y_limits = c(0, max_val_D),
                   y_lab = "Dispersal rate (event/lineage/Myr)")

preservation_T <- extract_data_DES(Q_rates_T, "q_", 100.5, c(100.5, 66, 33.9, 0))
preservation_NT <- extract_data_DES(Q_rates_NT, "q_", 100.5, c(100.5, 66, 33.9, 0))

max_val_Q <- round(max(rbind(preservation_T, preservation_NT)[,3]),1) + 0.1

preservation_plot <- plot_DES_rates(data_1 = preservation_T, data_2 = preservation_NT, colour = c("#B0E9D5","#DAA07F"),
                   y_breaks = seq(from = 0, to = max_val_Q, by = 0.1),
                   y_labels = seq(from = 0, to = max_val_Q, by = 0.1),
                   y_limits = c(0, max_val_Q),
                   y_lab = "Preservation rate (Occurence/lineage/Myr)")

turnover_T <- extract_data_PyRate(turnover_T_raw, c(100.5, 66, 33.9))
turnover_NT <- extract_data_PyRate(turnover_NT_raw, c(100.5, 66, 33.9))

max_val_T <- round(max(rbind(turnover_T, turnover_NT)[,3]),1) + 0.1

turnover_plot <- plot_DES_rates(data_1 = turnover_T, data_2 = turnover_NT, colour = c("#B0E9D5","#DAA07F"),
                   y_breaks = seq(from = 0, to = max_val_T, by = 0.05),
                   y_labels = seq(from = 0, to = max_val_T, by = 0.05),
                   y_limits = c(0, max_val_T),
                   y_lab = "Turnover rate (event/lineage/Myr)")

ltt_plot <- ltt_plot(ltt_T, ltt_NT)

top_row <- plot_grid(extinction_plot, dispersal_plot, labels = c("A", "B"))

mid_row <- plot_grid(preservation_plot, turnover_plot, labels = c("C", "D"))

bottom_row <-  plot_grid(ltt_plot, labels = c("E"))

if(type == 1){
    title_plot <- paste("../Plot_results_DES/DES_gen.pdf", sep = "")
}
if(type == 2){
    title_plot <- paste("../Plot_results_DES/DES_sp.pdf", sep = "")
}
if(type == 3){
    title_plot <- paste("../Plot_results_DES/DES_sp_comb.pdf", sep = "")
}
if(type == 4){
    title_plot <- paste("../Plot_results_DES/DES_sp_comb_corr.pdf", sep = "")
}
pdf(file = title_plot, width = 10, height = 10)
plot_grid(top_row, mid_row, bottom_row, ncol = 1)
dev.off()
