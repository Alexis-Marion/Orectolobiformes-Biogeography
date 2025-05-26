library("dplyr")

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

net_loss <- function(ltt, bin1, bin2){
    count_1 <- ltt[ltt[,1] == bin1,2]
    count_2 <- ltt[ltt[,1] == bin2,2]
    return((1 -count_2/count_1))
}

ltt_genus <- extract_ltt("../Results/Main_analyses/Genus_plot/output_ltt/")

ltt_species <- extract_ltt("../Results/Main_analyses/Species_plot/output_ltt/")

ltt_species_combined <- extract_ltt("../Results/Main_analyses/Species_combined_plot/output_ltt/")

ltt_species_combined_CDD <- extract_ltt("../Results/Main_analyses/Species_combined_CDD_plot/output_ltt/")

net_loss(ltt_genus, 67, 65)

net_loss(ltt_species, 67, 65)

net_loss(ltt_species_combined, 67, 65)

net_loss(ltt_species_combined_CDD, 67, 65)

net_loss(ltt_genus, 41.3, 33.9)

net_loss(ltt_species, 41.3, 33.9)

net_loss(ltt_species_combined, 41.3, 33.9)

net_loss(ltt_species_combined_CDD, 41.3, 33.9)
