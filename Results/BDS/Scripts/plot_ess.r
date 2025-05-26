library("ggplot2")
library("ggpubr")
library("ggplotify")

args = commandArgs(trailingOnly=TRUE)

tab<-read.csv(args[1], sep ="\t", header =TRUE, row.names =NULL)

ESS_post<-as.data.frame(cbind(tab$ESS_posterior, rep("1", length(tab$ESS_posterior))))

col<-rep("Above 200",length(tab$ESS_posterior))

colnames(ESS_post)<-c("dose", "len")

col[as.numeric(ESS_post[,1])<200]<-"Below 200"
col[as.numeric(ESS_post[,1])<100]<-"Below 100"

ESS_post<-cbind(ESS_post, col)

strp<-ggplot(ESS_post, aes(y = len, x = as.numeric(dose), color = col)) +
    geom_jitter(width=1) +
    xlim(0,round(max(tab$ESS_posterior), digits = -1)) +
    xlab(label = "") + 
    ylab(label = "") + 
    scale_color_manual(values = c("#40826D", "orange", "red"))+
    theme_classic()+
    theme(legend.position = "none") +
    ggtitle("ESS value for posterior probabilites")+
    theme(axis.text.y = element_blank(), axis.ticks.y=element_blank())+
    theme(axis.text.x = element_text(size = 15))+ 
    theme(axis.title.y = element_text(size = 15, vjust=2))+
    theme(plot.title = element_text(size = 15, hjust = 0.5))+
    geom_vline(xintercept = 100, color = "red")+
    geom_vline(xintercept = 200, color = "orange")

df<-as.data.frame(cbind(c(tab$Proportion_Ts_CV, tab$Proportion_Te_CV), c(rep("Ts", length(tab$Proportion_Ts_CV)), rep("Te", length(tab$Proportion_Te_CV)))))

colnames(df)<-c("Proportions", "Ts_Te")

bxp1<-ggplot(df, aes(x=reorder(Ts_Te,as.numeric(Proportions)),y=as.numeric(Proportions), fill=Ts_Te, colour=Ts_Te)) +
    geom_jitter(width=0.25) +
    geom_boxplot(alpha=0.5)+ 
    xlab(label = "") + 
    ylab(label = "Proportions of ESS above 200") + 
    theme_classic()+ 
    theme(legend.position = "none") +
    ggtitle("Estimate ESS values for TS & TE") +
    scale_color_manual(values = c("#800020", "#319377"))+
    scale_fill_manual(values = c("#800020", "#319377"))+
    theme(axis.text.y = element_text(size = 15))+
    theme(axis.text.x = element_text(size = 15))+ 
    theme(axis.title.y = element_text(size = 15, vjust=2))+
    theme(plot.title = element_text(size = 15, hjust = 0.5))

root_age <- data.frame(cbind(c(tab$Mean_root_age, tab$min_HPD_root_age, tab$max_HPD_root_age), c(rep("Mean", length(tab$Mean_root_age)), rep("Min", length(tab$min_HPD_root_age)), rep("Max", length(tab$max_HPD_root_age)))))

colnames(root_age)<-c("Values", "Group")

bxp2<-ggplot(root_age, aes(x=reorder(Group,as.numeric(Values)),y=as.numeric(Values), fill=Group, colour=Group)) +
    geom_jitter(width=0.25) +
    geom_boxplot(alpha=0.5)+ 
    xlab(label = "") + 
    ylab(label = "Age in Myrs") + 
    theme_classic()+ 
    theme(legend.position = "none") +
    ggtitle("Root age distribution") +
    scale_color_manual(values = c("#FA8072", "orange", "#E3DAC9"))+
    scale_fill_manual(values = c("#FA8072", "orange", "#E3DAC9"))+
    theme(axis.text.y = element_text(size = 15))+
    theme(axis.text.x = element_text(size = 15))+ 
    theme(axis.title.y = element_text(size = 15, vjust=2))+
    theme(plot.title = element_text(size = 15, hjust = 0.5))

death_age <- data.frame(cbind(c(tab$Mean_death_age, tab$min_HPD_death_age, tab$max_HPD_death_age), c(rep("Mean", length(tab$Mean_death_age)), rep("Min", length(tab$min_HPD_death_age)), rep("Max", length(tab$max_HPD_death_age)))))

colnames(death_age)<-c("Values", "Group")

bxp3<-ggplot(death_age, aes(x=reorder(Group,as.numeric(Values)),y=as.numeric(Values), fill=Group, colour=Group)) +
    geom_jitter(width=0.25) +
    geom_boxplot(alpha=0.5)+ 
    xlab(label = "") + 
    ylab(label = "Age in Myrs") + 
    theme_classic()+ 
    theme(legend.position = "none") +
    ggtitle("Death age distribution") +
    scale_color_manual(values = c("#40826D", "#0D98BA", "#D3D3D3"))+
    scale_fill_manual(values = c("#40826D", "#0D98BA", "#D3D3D3"))+
    theme(axis.text.y = element_text(size = 15))+
    theme(axis.text.x = element_text(size = 15))+ 
    theme(axis.title.y = element_text(size = 15, vjust=2))+
    theme(plot.title = element_text(size = 15, hjust = 0.5))

if(is.na(tab$ESS_death_age)[1]){
ggarrange(strp, bxp1, bxp2, 
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)
ggsave(filename = args[2], width = 12, height = 12)
}else{
ggarrange(strp, bxp1, bxp2, bxp3, 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)
ggsave(filename = args[2], width = 12, height = 12)  
}
