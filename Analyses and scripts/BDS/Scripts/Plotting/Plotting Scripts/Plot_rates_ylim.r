library("hash")

library("DDD")

args <- commandArgs(trailingOnly=TRUE)

## Source accessory functions for plotting -------------------------------------
source("1-extract_param_from_PyRate_outputs.R")
source("2-plotting_facilities.R")

## Full plots ------------------------------------------------------------------
  ### All in one
rtt_all_in_one <- extract_rtt(args[1], ana = args[7])

# Time bins

t_bins <- read.table(args[2])[,1]

# Q bins

q_bins <- read.table(args[3])[,1]

#Origination and Extinction rates

sp_ex_all_in_one <- rtt_plot(data = rtt_all_in_one,
                            type = "SpEx",
                            x_breaks = c(0, t_bins),
                            y_breaks = seq(from = 0, to = 0.15,by=0.05),
                            y_labels = seq(from = 0, to = 0.15 ,by=0.05),
                            y_limits = c(0, 0.15 , by = 0.05))

#net

net_div_all_in_one <- rtt_plot(data = rtt_all_in_one,
                             type = "net", x_breaks = c(0, t_bins), y_limits = c(-0.05,0.1), y_labels = seq(from = -0.05, to = 0.1,by=0.025),y_breaks = seq(from = -0.05, to = 0.1,by=0.025))

ltt<-extract_ltt(dir = args[4])

ltt.plot <- ltt_plot(ltt, y_breaks = seq(0,(round(max(ltt$Diversity), -1) + 10),5), y_limits = c(0,(round(max(ltt$Diversity), -1) + 10)), x_breaks = c(0,t_bins))

omega<-read.csv(args[5], sep ="\t")

Q_plot<-q_plot(omega, ltt, y_limits = c(0, 0.8), x_breaks = c(0, q_bins))

p <- comb_ltt_rtt(sp_ex_all_in_one, net_div_all_in_one, ltt.plot, Q_plot, n_plots = 4)
ggsave(args[6],
           plot = p,
           height = 350,
           width = 450,
           units = "mm",
           dpi = 300)
