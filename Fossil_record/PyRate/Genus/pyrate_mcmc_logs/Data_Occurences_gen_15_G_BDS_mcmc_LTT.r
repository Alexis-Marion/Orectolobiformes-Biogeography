

pdf(file='../Genus/pyrate_mcmc_logs/Data_Occurences_gen_15_G_BDS_mcmc_LTT.pdf',width=0.6*20, height=0.6*10)
title = "Data_Occurences_gen_15_G_BDS_mcmc"
ts=c(86.21031291977728, 114.04067847255999,114.99657661375146,179.04702868081867,144.4579047497514,43.67695160324733,156.8757583803409,119.7745513177118,128.7502709218446,55.45781281134286,142.18269667248163,64.39854437957507,170.08851161325373,59.28312086132644,66.08085065877734,182.35789721970698,71.43755268296738,142.10068657911404,89.96319922195804,77.80923785614463,169.50424193328976,58.81242792438345,141.96387422549518,96.26636218593701,69.03462297957574,55.48969332047973,170.84008993154868,156.86012463765525,127.58531354523116,52.126786184990145,181.7329702466297,182.6033587276139,158.4525799565544,154.62508783838936,57.711653647836215,71.23085256278455,142.45363650122388,113.72721901611938,50.98183113370915,161.11251301297085,83.1160884762348,56.64598812628221,77.0953152044083,168.5960265406861,80.82277927581941,29.058166903754206,60.302960806861556,47.25852098705495)
te=c(84.27022545825179, 78.9680934728494,78.65675689166669,98.13924050933763,120.50494847088945,0.0,67.2266405483687,70.48690574226485,0.0,37.14991079151955,65.77762328661153,49.530179125379135,165.37750963017655,50.00402082494695,30.003664642060393,166.3903275414169,64.81480151908629,129.5394243122292,0.0,0.0,164.92558723569383,52.134263401257066,129.70391435463247,93.6600417006812,0.0,36.82429341001415,60.47668571333298,151.78447766032738,17.7164433859446,0.0,108.60245565081279,113.73138125408796,137.85818065971577,147.23640476591888,38.98330163822795,69.13065158544349,130.21021326384627,33.80256440660911,0.0,143.21470947168743,65.62637460210013,44.601145324813025,0.0,95.55526731526761,65.00012590294816,0.0,39.06571349781713,0.0)
div_traj=c(0, 1,2,3,4,5,6,7,8,7,6,5,6,7,8,9,10,9,8,9,8,9,10,11,12,11,10,9,8,9,10,9,10,11,12,11,12,11,10,11,10,9,10,11,10,11,12,11,10,11,12,13,14,13,12,13,12,13,12,11,10,9,10,9,10,11,12,13,14,15,16,15,16,17,16,15,16,15,16,15,14,13,12,11,10,11,10)
time_events=c(182.6033587276139, 182.35789721970698,181.7329702466297,179.04702868081867,170.84008993154868,170.08851161325373,169.50424193328976,168.5960265406861,166.3903275414169,165.37750963017655,164.92558723569383,161.11251301297085,158.4525799565544,156.8757583803409,156.86012463765525,154.62508783838936,151.78447766032738,147.23640476591888,144.4579047497514,143.21470947168743,142.45363650122388,142.18269667248163,142.10068657911404,141.96387422549518,137.85818065971577,130.21021326384627,129.70391435463247,129.5394243122292,128.7502709218446,127.58531354523116,120.50494847088945,119.7745513177118,114.99657661375146,114.04067847255999,113.73138125408796,113.72721901611938,108.60245565081279,98.13924050933763,96.26636218593701,95.55526731526761,93.6600417006812,89.96319922195804,86.21031291977728,84.27022545825179,83.1160884762348,80.82277927581941,78.9680934728494,78.65675689166669,77.80923785614463,77.0953152044083,71.43755268296738,71.23085256278455,70.48690574226485,69.13065158544349,69.03462297957574,67.2266405483687,66.08085065877734,65.77762328661153,65.62637460210013,65.00012590294816,64.81480151908629,64.39854437957507,60.47668571333298,60.302960806861556,59.28312086132644,58.81242792438345,57.711653647836215,56.64598812628221,55.48969332047973,55.45781281134286,52.134263401257066,52.126786184990145,50.98183113370915,50.00402082494695,49.530179125379135,47.25852098705495,44.601145324813025,43.67695160324733,39.06571349781713,38.98330163822795,37.14991079151955,36.82429341001415,33.80256440660911,30.003664642060393,29.058166903754206,17.7164433859446,0.0)
                par(mfrow=c(1,2))
                L = length(ts)
                plot(ts, 1:L , xlim=c(-max(ts)-1,0), pch=20, type="n", main=title,xlab="Time (Ma)",ylab="Lineages")
                for (i in 1:L){segments(x0=-te[i],y0=i,x1=-ts[i],y1=i)}    
                t = -time_events
                plot(div_traj ~ t,type="s", main = "Diversity trajectory",xlab="Time (Ma)",ylab="Number of lineages",xlim=c(-max(ts)-1,0))
                abline(v=c(65,200,251,367,445),lty=2,col="gray")
                