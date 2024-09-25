################################################################################
################# Accessory functions to treat PyRate outputs ##################
################################################################################

library(dplyr)

split_vector <- function(str_vec){ #str_vec has to be a stringged vector, i.e "c(...)"
  coma_split <- strsplit(str_vec, split = ",")[[1]]
  #left parenthesis
  coma_split[1] <- strsplit(coma_split[1], 
                            split = "\\(")[[1]][2]
  #right parenthesis
  coma_split[length(coma_split)] <- strsplit(coma_split[length(coma_split)],
                                             split = "\\)")[[1]][1]
  #convert to numeric
  vec_num <- as.numeric(coma_split)
  return(vec_num)
}

extract_rtt <- function(path, ana = c("RJMCMC", "BDS")){ #path = PATH TO THE .R SCRIPT WRITTEN BY PyRate
  #Raw output of PyRate
  raw_script <- readLines(path)
  if (ana == "RJMCMC"){
  #Extracting time
  time_all <- raw_script[grepl("time=", raw_script)] #all mentions of the same vector in the scipt (n=4)
  time_str <- time_all[1] #could have been any index between 1 and 4
  time_num <- split_vector(time_str) #convert to numeric
  time_num <- -time_num #by default, negative
  #Extracting mean estimates for origination, extinction and net diversification rates
  rates <- raw_script[grepl("rate=", raw_script)] #1:origination, 2:extinction, 3:net_diversification, 4:longevity
  sp_rate <- split_vector(rates[1])
  ex_rate <- split_vector(rates[2])
  net_rate <- split_vector(rates[3])
  #Extracting max HPD for Sp and Ex rates
  maxHPD <- raw_script[grepl("maxHPD=", raw_script)]
  sp_maxHPD <- split_vector(maxHPD[1])
  ex_maxHPD <- split_vector(maxHPD[2])
  net_maxHPD <- split_vector(maxHPD[3])
  #Extracting min HPD for Sp and Ex rates
  minHPD <- raw_script[grepl("minHPD=", raw_script)]
  sp_minHPD <- split_vector(minHPD[1])
  ex_minHPD <- split_vector(minHPD[2])
  net_minHPD <- split_vector(minHPD[3])
  #Summarising and returning as a table
  sp_df <- data.frame(time = time_num,
                      sp_rate = sp_rate,
                      sp_maxHPD = sp_maxHPD,
                      sp_minHPD = sp_minHPD)
  ex_df <- data.frame(ex_rate = ex_rate,
                      ex_maxHPD = ex_maxHPD,
                      ex_minHPD = ex_minHPD)
  net_df <- data.frame(net_rate = net_rate,
                      net_maxHPD = net_maxHPD,
                      net_minHPD = net_minHPD)
  final <- cbind.data.frame(sp_df, ex_df, net_df)
  return(final)
  }
    if (ana == "BDS"){
  #Extracting mean estimates for origination, extinction and net diversification rates
  rates <- raw_script[grepl("L_mean=", raw_script)] 
  sp_rate <- split_vector(rates[1])
  rates <- raw_script[grepl("M_mean=", raw_script)] 
  ex_rate <- split_vector(rates[1])
  rates <- raw_script[grepl("R_mean=", raw_script)] 
  net_rate <- split_vector(rates[1])
  #Extracting max HPD for Sp and Ex rates
  maxHPD <- raw_script[grepl("L_hpd_M95=", raw_script)]
  sp_maxHPD <- split_vector(maxHPD[1])
  maxHPD <- raw_script[grepl("M_hpd_M95=", raw_script)]
  ex_maxHPD <- split_vector(maxHPD[1])
  maxHPD <- raw_script[grepl("R_hpd_M95=", raw_script)]
  net_maxHPD <- split_vector(maxHPD[1])
  #Extracting min HPD for Sp and Ex rates
  minHPD <- raw_script[grepl("L_hpd_m95=", raw_script)]
  sp_minHPD <- split_vector(minHPD[1])
  minHPD <- raw_script[grepl("M_hpd_m95=", raw_script)]
  ex_minHPD <- split_vector(minHPD[1])
  minHPD <- raw_script[grepl("R_hpd_m95=", raw_script)]
  net_minHPD <- split_vector(minHPD[1])
  #Extracting time
  time <- raw_script[grepl("age=", raw_script)]
  time_num<-abs(eval(parse(text=time)))
  #Summarising and returning as a table
  sp_df <- data.frame(time = time_num,
                      sp_rate = sp_rate,
                      sp_maxHPD = sp_maxHPD,
                      sp_minHPD = sp_minHPD)
  ex_df <- data.frame(ex_rate = ex_rate,
                      ex_maxHPD = ex_maxHPD,
                      ex_minHPD = ex_minHPD)
  net_df <- data.frame(net_rate = net_rate,
                      net_maxHPD = net_maxHPD,
                      net_minHPD = net_minHPD)
  final <- cbind.data.frame(sp_df, ex_df, net_df)
  return(final)
  }
}

extract_ltt <- function(dir){ #dir = path to the DIRECTORY where LTT PER REPLICATE were stored
  #target ltt tables per replicate
  files <- Sys.glob(paste0(dir, "*_ltt.txt"))
  #initialisation
  ltt <- read.table(files[1], header = TRUE)
  ltt$time <- unlist(lapply(X = ltt$time, FUN = round, digits = 1))
  if(length(which(ltt$time > 500)) > 0){
    ltt <- ltt[-which(ltt$time > 500), c("time", "diversity")]
  }
  else{
    ltt <- ltt[, c("time", "diversity")]
  }
  ltt <- ltt %>% rename(diversity_1 = "diversity")
  #iterative processing
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
  #Assess mean max min
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
