args = commandArgs(trailingOnly=TRUE)

library("tidyverse")
library("ggpubr")
library("rstatix")

tab<-read.csv(args[1], sep =";", header =TRUE)

colnames(tab)<-gsub("X", "", colnames(tab))

tab<-tab[,-c(length(tab[1,]))]

tab <- tab[!(tab[,length(tab[1,])] == "" | is.na(tab[,length(tab[1,])])), ]

chtcr<-"gather(key = 'Model', value = 'AICc', "
for (i in 1:length(colnames(tab)[-1])){
    if(i == length(colnames(tab)[-1])){
        var<-as.name(colnames(tab)[-1][i])
        chtcr<-paste(c(chtcr, var, ", data = tab)"),sep = " ")
    }
    else{
        var<-as.name(colnames(tab)[-1][i])
        chtcr<-paste(c(chtcr, var, ","), sep = " ")
    }
}

tab2 <- eval(parse(text = chtcr)) %>%
  convert_as_factor(File_name, Model)

tab_test_shap <- tab2 %>%
  group_by(Model) %>%
  shapiro_test(AICc)

tab_mean<-tab2 %>%
  group_by(Model) %>%
  get_summary_stats(AICc, type = "mean_sd")
if(any(tab_test_shap$p < 0.05)){
res.aov <- tab2 %>% friedman_test(AICc ~ Model |File_name)
    pwc <- tab2 %>%
  wilcox_test(AICc ~ Model, paired = TRUE, p.adjust.method = "bonferroni")
}else{
    res.aov <- anova_test(data = tab2, dv = AICc, wid = File_name, within = Model)
    tab_aov<-get_anova_table(res.aov)
    pwc <- tab2 %>%
    pairwise_t_test(
    AICc ~ Model, paired = TRUE,
    p.adjust.method = "bonferroni"
    )
}

pwc <- tab2 %>%
    pairwise_t_test(
    AICc ~ Model, paired = TRUE,
    p.adjust.method = "bonferroni")

vec0<-as.character((tab_mean$Model[-c((nrow(tab_mean)-2):nrow(tab_mean))]))
age<-vec0[order(as.numeric(vec0))]

vec<-c()
vecAICc<-c()
for (i in 1:length(age)){
    for(j in 1:nrow(tab_mean)){
    if (age[i] == tab_mean[j,1]){
        for (k in 1:nrow(pwc)){
            if(pwc[k,2] == age[i] & pwc[k,3] == "TPP" & pwc[k,9] !="ns" & tab_mean[j,4] < tab_mean[tab_mean$Model == "TPP",4]){
                vec<-c(vec, age[i])   
                vecAICc<-c(vecAICc, tab_mean[j,4])
            }
        }
    }
}
}

if(tab_mean[tab_mean$Model == "TPP",4] == min(tab_mean$mean)){
    pwc2 <- pwc %>% add_xy_position(x = "time")
    ggboxplot(tab2, x = "Model", y = "AICc", add = "point") +
      stat_pvalue_manual(pwc2, hide.ns = TRUE) +
      labs(
        subtitle = get_test_label(res.aov,  detailed = TRUE),
        caption = get_pwc_label(pwc2)
          )
    ggsave("result_boxplot.pdf")
    write.table(as.data.frame(pwc), "tab_model.tsv", sep ="\t")
}else{
    write.table(as.data.frame(age[age!=vec[which.min(vecAICc)]]), args[2], sep =";", col.names = F, row.names = F,quote = FALSE)
}

