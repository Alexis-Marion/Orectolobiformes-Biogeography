# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 14:32:14 2023

Parse and save preservation rate estimates from multiple replicates.

@author: Lucas Buffan
"""
import os
import pandas as pd
import numpy as np
import argparse

### Enable users to specify directory where individual q_rates were assessed and where to store the parsed ouput
p = argparse.ArgumentParser()
p.add_argument('-dir', type=str, help='directory of the .r files plotting Q_rates')
p.add_argument('-out', type=str, help='name and directory of the output .csv file')
args = p.parse_args()
dir = args.dir
out = args.out

files = os.listdir(dir)
files = [file for file in files if ".r" in file] #select R scripts written by PyRate where q_rates are stored

age_q = pd.DataFrame([])
mean_q = pd.DataFrame([])
min_HPD = pd.DataFrame([])
max_HPD = pd.DataFrame([])

i = 0
for file in files:
    i += 1
    tmp_qage = []
    tmp_qmean = []
    tmp_minHPD = []
    tmp_maxHPD = []
    
    with open(dir+"/"+file) as f:
        for line in f:
            if "age = " in line:
                q = line.split("c(")[1]
                q = abs(float(q.split(",")[0]))
                tmp_qage.append(q)
            if "Q_mean = " in line:
                q = float(line.split(" = ")[1])
                tmp_qmean.append(q)
            elif "Q_hpd_m = " in line:
                q = float(line.split(" = ")[1])
                tmp_minHPD.append(q)
            elif "Q_hpd_M = " in line:
                q = float(line.split(" = ")[1])
                tmp_maxHPD.append(q)
    age_q["replicate_"+str(i)] = pd.Series(tmp_qage)
    mean_q["replicate_"+str(i)] = pd.Series(tmp_qmean)
    min_HPD["replicate_"+str(i)] = pd.Series(tmp_minHPD)
    max_HPD["replicate_"+str(i)] = pd.Series(tmp_maxHPD)

final = pd.DataFrame([])
final["Age"] = age_q.apply(np.mean, axis = 1)
final["mean_Q"] = mean_q.apply(np.mean, axis = 1)
final["min_HPD"] = min_HPD.apply(np.nanmin, axis = 1)
final["max_HPD"] = max_HPD.apply(np.nanmax, axis = 1)

final.to_csv(out,
             index = False, sep = "\t")
