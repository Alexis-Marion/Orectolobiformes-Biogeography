library("simDES")

Time <- 100.5
Step <- 0.5
N_low <- 50
N_mid <- 100
N_high <- 150

BinSize_05 = 0.5
BinSize_1 = 1
BinSize_5 = 5
BinSize_10 = 10

shift_KPG <- c(66)
shift_EOT <- c(33.9)
shifts_KPG_EOT <- c(66, 33.9)

sim_data_maker <- function(BinSize, Ntaxa, Shifts, pattern, combined = NULL){
    Time <- 100.5
    Step <- 0.5
    mG <- 1
    for(i in 1:100){
        shift_ex_1 <- c(0.25, 0.5)
        shift_ex_2 <- c(0.5, 0.25)
        shift_ds_1 <- c(0.25, 0.5)
        shift_ds_2 <- c(0.5, 0.25)
        shift_q_1 <- c(1, 2)
        
        if(length(combined) == 0){
            shift_q_2 <- c(0.125, 0.25)
        }
        
        if(length(combined) != 0){
            shift_q_2 <- c(2, 4)
        }        
        
        if(length(Shifts) == 0){
            SimD <- shift_ds_1
            SimE <- shift_ex_1
            SimQ <- shift_q_1
        }
        
        if(length(Shifts) == 1){
            SimD <- c(shift_ds_1, shift_ds_2)
            SimE <- c(shift_ex_1, shift_ex_2)
            SimQ <- c(shift_q_1, shift_q_2)
        }
        
        if(length(Shifts) == 2){
            SimD <- c(shift_ds_1, shift_ds_2, shift_ds_1)
            SimE <- c(shift_ex_1, shift_ex_2, shift_ex_1)
            SimQ <- c(shift_q_1, shift_q_1, shift_q_2)
        }
        
        if(length(Shifts) == 4){
            SimD <- c(shift_ds_1, shift_ds_2, shift_ds_1, shift_ds_2, shift_ds_1)
            SimE <- c(shift_ex_1, shift_ex_2, shift_ex_1, shift_ex_2, shift_ex_1)
            SimQ <- c(shift_q_1, shift_q_1, shift_q_1, shift_q_1, shift_q_2)
        }
        
        
        output <- paste("Simulation/Input/", pattern, "/", pattern, "_DES_", i, ".txt", sep = "")
        Sim_data <- sim_DES(Time = Time, Step = Step, BinSize = BinSize, Nspecies = Ntaxa, SimD = SimD, SimE = SimE, SimQ = SimQ, Qtimes = Shifts, Ncat = Inf, alpha = mG)
        write.table(Sim_data[[1]], output, sep = "\t", row.names = FALSE, quote = FALSE, na = "NaN")
    }
}

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_low, Shifts = NULL, "No_shift_low")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_mid, Shifts = NULL, "No_shift_mid")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_high, Shifts = NULL, "No_shift_combined",  combined = TRUE)

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_low, Shifts = shift_EOT, "One_shift_low")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_mid, Shifts = shift_EOT, "One_shift_mid")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_high, Shifts = shift_EOT, "One_shift_combined",  combined = TRUE)

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_low, Shifts = shifts_KPG_EOT, "Two_shifts_low")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_mid, Shifts = shifts_KPG_EOT, "Two_shifts_mid")

sim_data_maker(BinSize = BinSize_1, Ntaxa = N_high, Shifts = shifts_KPG_EOT, "Two_shifts_combined",  combined = TRUE)
