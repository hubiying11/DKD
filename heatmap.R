# PID of current job: 264556
mSet<-InitDataObjects("conc", "pathqea", FALSE)
mSet<-Read.TextData(mSet, "Replacing_with_your_file_path", "rowu", "disc");
mSet<-SanityCheckData(mSet)
mSet<-ReplaceMin(mSet);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-SanityCheckData(mSet)
mSet<-RemoveMissingPercent(mSet, percent=0.5)
mSet<-ImputeMissingVar(mSet, method="min")
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-SanityCheckData(mSet)
mSet<-FilterVariable(mSet, "none", "F", 25)
mSet<-PreparePrenormData(mSet)
mSet<-GetGroupNames(mSet, "")
mSet<-PreparePrenormData(mSet)
mSet<-Normalization(mSet, "NULL", "NULL", "NULL", ratio=FALSE, ratioNum=20)
mSet<-PlotNormSummary(mSet, "norm_0_", "png", 72, width=NA)
mSet<-PlotSampleNormSummary(mSet, "snorm_0_", "png", 72, width=NA)
mSet<-SetKEGG.PathLib(mSet, "mmu", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateQeaScore(mSet, "rbc", "gt")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 72, width=NA, NA, NA )

library(readr)
library(plyr)
library(RColorBrewer)
library(pheatmap)
library(dplyr)
df<-read.csv(file="mSet.csv",header = T,row.names = 1,check.names = F)
df[is.na(df)]<-0
annotation_row<-read.csv(file="rowclass.csv",header = T,row.names = 1)
row.names(annotation_row) <- rownames(df)
annotation_col<-read.csv(file="col-class.csv",header = T,row.names = 1)
row.names(annotation_col) <- colnames(df)
groupcolor <- c("#00913A","#E60012") 
names(groupcolor) <- c("db/m","db/db") 
classcolor <- c("#E58216","#EBCC00","#E78CA8","#7A957D","#C7AFD0","#DBE1B4") 
names(classcolor) <- c("Lipids",
                       "Nucleosides",
                       "Organic acids and derivatives",
                       "Organoheterocyclic compounds",
                       "Organic oxygen compounds",
                       "other")
sourcecolor <- c("#3CB371","#009AD6")
names(sourcecolor) <- c("Microbiota","Co-Metabolism")
ann_colors<-list(group=groupcolor,Super.Class=classcolor,Origin= sourcecolor)
p<-pheatmap(df,
            cluster_rows = T,
            cluster_cols = F,
         color=colorRampPalette(c("blue","white","orange"))(1000),
         show_colnames = F,
         border_color = NA,
         scale = "row",
         show_rownames =T,
         fontsize=10,
         cellwidth=9,
         cellheight=10,
        annotation_row = annotation_row,
        annotation_col = annotation_col,
        annotation_colors = ann_colors)

