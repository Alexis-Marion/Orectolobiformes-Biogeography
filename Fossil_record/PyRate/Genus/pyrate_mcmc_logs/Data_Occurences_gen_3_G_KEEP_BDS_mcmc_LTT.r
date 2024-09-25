

pdf(file='../Genus/pyrate_mcmc_logs/Data_Occurences_gen_3_G_KEEP_BDS_mcmc_LTT.pdf',width=0.6*20, height=0.6*10)
title = "Data_Occurences_gen_3_G_KEEP_BDS_mcmc"
ts=c(86.03656897388792, 105.78220532306015,109.23847478360392,184.45884595441734,145.20403569625515,45.14589634931666,159.14419629331098,119.67992899146903,125.40499636308364,54.78972936000589,142.98383203770132,66.94216215264765,169.08341869033987,57.604372066990955,65.18548864891038,180.8201761646757,70.8501188420304,141.71149127917616,88.59214308766519,77.1965459613812,168.77951859717123,59.34699385991237,140.57425532654483,98.29951168016177,66.70852058474178,55.28321625217511,171.88110516437166,159.3788028959524,131.91031510438808,50.31263209914227,184.8444212303847,185.69437338778133,155.804365974522,151.60792127482944,59.069348222510534,72.66254196281602,142.55180016049565,112.81901339999276,48.69460339430271,163.49699477306845,80.60045985813419,54.64389604126622,77.02314074896499,169.8643837436831,82.40187802284412,29.800752634850884,60.19163454794655,45.70695795527212)
te=c(84.44980706057146, 79.69456096396118,79.97410271221383,96.825922378742,119.8896181226779,0.0,67.93738311346462,70.57904811194848,0.0,36.392769903575584,64.8591014742701,47.56191399445674,164.7080032877393,47.62945806640709,29.135616897079338,170.30683708609536,65.40587230713994,130.8824690798501,0.0,0.0,163.82612159359735,51.26288441916434,129.4123350832252,95.21468860463357,0.0,36.62986193346846,60.30482493229909,154.67441328484256,17.58711793535936,0.0,114.8248996299356,111.58691440687261,139.42702996412564,145.91374736127645,37.1732149674191,70.52966231179111,132.56558467216234,32.174829567349846,0.0,142.10005310727792,65.49470418504667,45.59959527316898,0.0,93.85700904348064,65.5055218340563,0.0,44.17908832080931,0.0)
div_traj=c(0, 1,2,3,4,5,4,5,6,7,6,5,6,7,8,9,8,9,8,9,10,11,10,11,12,11,10,11,10,9,10,9,10,9,10,9,10,11,12,11,10,9,10,11,10,11,12,11,10,11,12,13,14,13,12,11,12,13,12,11,10,11,10,9,10,11,12,13,14,15,16,15,16,17,16,15,16,15,16,15,14,13,12,11,12,11,10)
time_events=c(185.69437338778133, 184.8444212303847,184.45884595441734,180.8201761646757,171.88110516437166,170.30683708609536,169.8643837436831,169.08341869033987,168.77951859717123,164.7080032877393,163.82612159359735,163.49699477306845,159.3788028959524,159.14419629331098,155.804365974522,154.67441328484256,151.60792127482944,145.91374736127645,145.20403569625515,142.98383203770132,142.55180016049565,142.10005310727792,141.71149127917616,140.57425532654483,139.42702996412564,132.56558467216234,131.91031510438808,130.8824690798501,129.4123350832252,125.40499636308364,119.8896181226779,119.67992899146903,114.8248996299356,112.81901339999276,111.58691440687261,109.23847478360392,105.78220532306015,98.29951168016177,96.825922378742,95.21468860463357,93.85700904348064,88.59214308766519,86.03656897388792,84.44980706057146,82.40187802284412,80.60045985813419,79.97410271221383,79.69456096396118,77.1965459613812,77.02314074896499,72.66254196281602,70.8501188420304,70.57904811194848,70.52966231179111,67.93738311346462,66.94216215264765,66.70852058474178,65.5055218340563,65.49470418504667,65.40587230713994,65.18548864891038,64.8591014742701,60.30482493229909,60.19163454794655,59.34699385991237,59.069348222510534,57.604372066990955,55.28321625217511,54.78972936000589,54.64389604126622,51.26288441916434,50.31263209914227,48.69460339430271,47.62945806640709,47.56191399445674,45.70695795527212,45.59959527316898,45.14589634931666,44.17908832080931,37.1732149674191,36.62986193346846,36.392769903575584,32.174829567349846,29.800752634850884,29.135616897079338,17.58711793535936,0.0)
                par(mfrow=c(1,2))
                L = length(ts)
                plot(ts, 1:L , xlim=c(-max(ts)-1,0), pch=20, type="n", main=title,xlab="Time (Ma)",ylab="Lineages")
                for (i in 1:L){segments(x0=-te[i],y0=i,x1=-ts[i],y1=i)}    
                t = -time_events
                plot(div_traj ~ t,type="s", main = "Diversity trajectory",xlab="Time (Ma)",ylab="Number of lineages",xlim=c(-max(ts)-1,0))
                abline(v=c(65,200,251,367,445),lty=2,col="gray")
                