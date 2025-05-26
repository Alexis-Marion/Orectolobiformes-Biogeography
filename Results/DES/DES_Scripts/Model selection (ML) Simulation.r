library("stringr")
library("tidyverse")
library("ggpubr")
library("rstatix")
library("ggplot2")

lappend <- function (lst, ...){
lst <- c(lst, list(...))
  return(lst)
}

fancy_hist = function(x, 
                      xlim,
                      xlab = '',
                      main = '',
                      breaks = 100,
                      vline = 0.5,
                      col_hist = "#A25050"){
  if(missing(xlim)){
    xlim <- range(x)
  }
  
  hist(x, 
       xlim = xlim,
       xlab = xlab,
       ylab = "Number of runs",
       col = col_hist,
       border = 'white',
       lwd = 2,
       breaks = breaks,
       main = main)
    abline(v = vline, , col= "#7393B3", lwd = 5, lty = 1)
}


make_prop <- function(list_all_dir){
    list_prop <- list()
    dir_name <- c("1_none", "1_one", "1_two")
    for (dir in list_all_dir){
        list_all_files <- list.files(dir, pattern = "Mlsbplx.log", full.names = TRUE)
        AICc <- c()
        for (files in list_all_files){
            temp_tab <- read.table(files, sep ="\t", header = TRUE)
            AICc <- c(AICc, temp_tab$AICc)
        }
    
    splt_1 <- str_split_fixed(list_all_files, pattern = "_DES_", 2)[,2]
    splt_2_1 <- str_split_fixed(splt_1, pattern = "_", 2)[,1]
    splt_2_2 <- str_split_fixed(splt_1, pattern = "_", 2)[,2]
    splt_3 <- str_split_fixed(splt_2_2, pattern = "0_q_", 2)[,2]
    splt_4 <- str_split_fixed(splt_3, pattern = "_TdD_TdE_G_Mlsbplx.log", 2)[,1]
    splt_4[splt_4 == ""] <- "0"
    Replicate <- splt_2_1
    Model <- splt_4
        
    df<-as.data.frame(cbind(Model, AICc, Replicate))

    df$AICc <- as.numeric(AICc)
    print(df)
    nb_rep <- 0
    nb_best_model <- rep(0,3)
    for( i in unique((Replicate))){
        temp_df <- df[df$Replicate == i,]
            
        if(nrow(temp_df) == 3){
            nb_rep <- nb_rep + 1
            nb_best_model[which.min(temp_df$AICc)] <- nb_best_model[which.min(temp_df$AICc)] + 1
        }
    }
    print(nb_rep)
    prop_best_model <- nb_best_model/nb_rep
    names(prop_best_model) <- rev(c("No shift",  "One shift (33.9)", "Two shifts"))
    list_prop <- lappend(list_prop, prop_best_model)
}
    names(list_prop) <- dir_name
return(list_prop)
}

transfo_prop <- function(list_prop){
    Var_1 <- c(rep("No shift", 3), rep("One shift (33.9)", 3), rep("Two shifts", 3))
    Var_2 <- c()
    Freq <- c()
    for(i in 1:length(list_prop)){
        Var_2 <- c(Var_2, (names(list_prop[[i]])))
        Freq <- c(Freq, list_prop[[i]])
    }
    return(data.frame(Var_1, Var_2, Freq, stringsAsFactors = TRUE))
}

list_all_dir_low <- c("../Simulation/Input/No_shift_low/", "../Simulation/Input/One_shift_low/", "../Simulation/Input/Two_shifts_low/")

list_all_dir_mid <- c("../Simulation/Input/No_shift_mid/", "../Simulation/Input/One_shift_mid/", "../Simulation/Input/Two_shifts_mid/")

list_all_dir_combined <- c("../Simulation/Input/No_shift_combined/", "../Simulation/Input/One_shift_combined/", "../Simulation/Input/Two_shifts_combined/")

list_prop_low <- make_prop(list_all_dir_low)
tab_low <- transfo_prop(list_prop_low)
tab_low$Var_1 <- factor(tab_low$Var_1, c("No shift", "One shift (33.9)","Two shifts"))
tab_low$Var_2 <- factor(tab_low$Var_2, c("No shift", "One shift (33.9)","Two shifts"))

pdf("../Simulation/Plot/Confusion_plots/Confusion_plot_low.pdf")
ggplot(tab_low, aes(Var_2,  Var_1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = scales::percent(Freq))) +
  scale_fill_gradient(low = "white", high = "#3575b5") +
  labs(x = "Best model", y = "Generating model", title = "ML model selection for small dataset",
       fill = "Proportion") +
  theme(plot.title = element_text(size = 25, hjust = 0.5, 
                                  margin = margin(20, 0, 20, 0)),
        legend.title = element_text(size = 14, margin = margin(0, 20, 10, 0)),
        axis.title.x = element_text(margin = margin(20, 20, 20, 20), size = 18),
        axis.title.y = element_text(margin = margin(0, 20, 0, 10), size = 18))
dev.off()

list_prop_mid <- make_prop(list_all_dir_mid)
tab_mid <- transfo_prop(list_prop_mid)
tab_mid$Var_1 <- factor(tab_mid$Var_1, c("No shift", "One shift (33.9)","Two shifts"))
tab_mid$Var_2 <- factor(tab_mid$Var_2, c("No shift", "One shift (33.9)","Two shifts"))

pdf("../Simulation/Plot/Confusion_plots/Confusion_plot_mid.pdf")
ggplot(tab_mid, aes(Var_2,  Var_1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = scales::percent(Freq))) +
  scale_fill_gradient(low = "white", high = "#3575b5") +
  labs(x = "Best model", y = "Generating model", title = "ML model selection for moderate dataset",
       fill = "Proportion") +
  theme(plot.title = element_text(size = 25, hjust = 0.5, 
                                  margin = margin(20, 0, 20, 0)),
        legend.title = element_text(size = 14, margin = margin(0, 20, 10, 0)),
        axis.title.x = element_text(margin = margin(20, 20, 20, 20), size = 18),
        axis.title.y = element_text(margin = margin(0, 20, 0, 10), size = 18))
dev.off()

list_prop_combined <- make_prop(list_all_dir_combined)
tab_combined <- transfo_prop(list_prop_combined)
tab_combined$Var_1 <- factor(tab_combined$Var_1, c("No shift", "One shift (33.9)","Two shifts"))
tab_combined$Var_2 <- factor(tab_combined$Var_2, c("No shift", "One shift (33.9)","Two shifts"))

pdf("../Simulation/Plot/Confusion_plots/Confusion_plot_combined.pdf")
ggplot(tab_combined, aes(Var_2,  Var_1, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = scales::percent(Freq))) +
  scale_fill_gradient(low = "white", high = "#3575b5") +
  labs(x = "Best model", y = "Generating model", title = "ML model selection for combined dataset",
       fill = "Proportion") +
  theme(plot.title = element_text(size = 25, hjust = 0.5, 
                                  margin = margin(20, 0, 20, 0)),
        legend.title = element_text(size = 14, margin = margin(0, 20, 10, 0)),
        axis.title.x = element_text(margin = margin(20, 20, 20, 20), size = 18),
        axis.title.y = element_text(margin = margin(0, 20, 0, 10), size = 18))
dev.off()

for (dir in list_all_dir_low[[3]]){
    list_all_files <- list.files(dir, pattern = "33.9_66.0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)   

    d12_t66.0 <-c()
    d21_t66.0 <-c()
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t66.0 <-c()
    e2_t66.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t66.0 <- c(d12_t66.0, temp_tab$d12_t66.0)
            d21_t66.0 <- c(d21_t66.0, temp_tab$d21_t66.0)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t66.0 <- c(e1_t66.0, temp_tab$e1_t66.0)
            e2_t66.0 <- c(e2_t66.0, temp_tab$e2_t66.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_two_small.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(e1_t66.0, xlim = c(0, 2), breaks = 20, main = "Extinction rates (1 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t66.0, xlim = c(0, 2), breaks = 15, main = "Extinction rates (2 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 20, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 10, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 750, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 750, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_two_small.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(d12_t66.0, xlim = c(0, 2), breaks = 25, main = "Dispersal rates (1 -> 2 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t66.0, xlim = c(0, 2), breaks = 1000, main = "Dispersal rates (2 -> 1 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 750, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 25, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 750, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 1000, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()

for (dir in list_all_dir_low[[2]]){
    list_all_files <- list.files(dir, pattern = "33.9_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_one_small.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 10, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 750, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 750, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_one_small.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 50, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 500, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 500, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

dev.off()

for (dir in list_all_dir_low[[1]]){
    list_all_files <- list.files(dir, pattern = "_0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    

    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_none_small.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 10, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_none_small.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 15, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()

for (dir in list_all_dir_mid[[3]]){
    list_all_files <- list.files(dir, pattern = "33.9_66.0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    

    d12_t66.0 <-c()
    d21_t66.0 <-c()
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t66.0 <-c()
    e2_t66.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t66.0 <- c(d12_t66.0, temp_tab$d12_t66.0)
            d21_t66.0 <- c(d21_t66.0, temp_tab$d21_t66.0)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t66.0 <- c(e1_t66.0, temp_tab$e1_t66.0)
            e2_t66.0 <- c(e2_t66.0, temp_tab$e2_t66.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_two_medium.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(e1_t66.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t66.0, xlim = c(0, 2), breaks = 10, main = "Extinction rates (2 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 10, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 25, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 100, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_two_medium.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(d12_t66.0, xlim = c(0, 2), breaks = 15, main = "Dispersal rates (1 -> 2 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t66.0, xlim = c(0, 2), breaks = 250, main = "Dispersal rates (2 -> 1 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 50, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 750, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 1000, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()

for (dir in list_all_dir_mid[[2]]){
    list_all_files <- list.files(dir, pattern = "33.9_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_one_medium.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 3, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 500, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 100, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_one_medium.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 20, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 750, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 750, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

dev.off()

for (dir in list_all_dir_mid[[1]]){
    list_all_files <- list.files(dir, pattern = "_0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    

    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_none_medium.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 2, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_none_medium.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 3, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()

for (dir in list_all_dir_combined[[3]]){
    list_all_files <- list.files(dir, pattern = "33.9_66.0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    

    d12_t66.0 <-c()
    d21_t66.0 <-c()
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t66.0 <-c()
    e2_t66.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t66.0 <- c(d12_t66.0, temp_tab$d12_t66.0)
            d21_t66.0 <- c(d21_t66.0, temp_tab$d21_t66.0)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t66.0 <- c(e1_t66.0, temp_tab$e1_t66.0)
            e2_t66.0 <- c(e2_t66.0, temp_tab$e2_t66.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_two_combined.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(e1_t66.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t66.0, xlim = c(0, 2), breaks = 10, main = "Extinction rates (2 : 66 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 10, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()


pdf("../Simulation/Plot/Rate_estimates/Dispersal_two_combined.pdf", height = 10)
par(mfrow= c(3,2))

fancy_hist(d12_t66.0, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (1 -> 2 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t66.0, xlim = c(0, 2), breaks = 25, main = "Dispersal rates (2 -> 1 : 66 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 25, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 25, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()

for (dir in list_all_dir_combined[[2]]){
    list_all_files <- list.files(dir, pattern = "33.9_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    
    d12_t33.9 <-c()
    d21_t33.9 <-c()
    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t33.9 <-c()
    e2_t33.9 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t33.9 <- c(d12_t33.9, temp_tab$d12_t33.9)
            d21_t33.9 <- c(d21_t33.9, temp_tab$d21_t33.9)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t33.9 <- c(e1_t33.9, temp_tab$e1_t33.9)
            e2_t33.9 <- c(e2_t33.9, temp_tab$e2_t33.9)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_one_combined.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(e1_t33.9, xlim = c(0, 2), breaks = 3, main = "Extinction rates (1 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t33.9, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 33.9 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 3, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_one_combined.pdf", height = 10)
par(mfrow= c(2,2))

fancy_hist(d12_t33.9, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (1 -> 2 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t33.9, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (2 -> 1 : 33.9 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 10, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)

dev.off()

for (dir in list_all_dir_combined[[1]]){
    list_all_files <- list.files(dir, pattern = "_0_TdD_TdE_G_Mlsbplx.log", full.names = TRUE)
    

    d12_t0.0 <-c()
    d21_t0.0 <-c()
    e1_t0.0 <-c()
    e2_t0.0 <-c()
    
    for (files in list_all_files){
        temp_tab <- read.table(files, sep ="\t", header = TRUE)
            d12_t0.0 <- c(d12_t0.0, temp_tab$d12_t0.0)
            d21_t0.0 <- c(d21_t0.0, temp_tab$d21_t0.0)
            e1_t0.0 <- c(e1_t0.0, temp_tab$e1_t0.0)
            e2_t0.0 <- c(e2_t0.0, temp_tab$e2_t0.0)
        }
    

}

pdf("../Simulation/Plot/Rate_estimates/Extinction_none_combined.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(e1_t0.0, xlim = c(0, 2), breaks = 1, main = "Extinction rates (1 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.25, col_hist = "#BFD4D8")
fancy_hist(e2_t0.0, xlim = c(0, 2), breaks = 5, main = "Extinction rates (2 : 0 Myr)", xlab = "Extinction rate (event/lineage/Myr)", vline = 0.5, col_hist = "#BFD4D8")

dev.off()

pdf("../Simulation/Plot/Rate_estimates/Dispersal_none_combined.pdf", height = 5)
par(mfrow= c(1,2))

fancy_hist(d12_t0.0, xlim = c(0, 2), breaks = 3, main = "Dispersal rates (1 -> 2 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.25)
fancy_hist(d21_t0.0, xlim = c(0, 2), breaks = 5, main = "Dispersal rates (2 -> 1 : 0 Myr)", xlab = "Dispersal rate (event/lineage/Myr)", vline = 0.5)

dev.off()
