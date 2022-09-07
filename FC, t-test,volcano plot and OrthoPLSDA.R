# PID of current job: 205201
mSet<-InitDataObjects("pktable", "stat", FALSE)
mSet<-Read.TextData(mSet, "Replacing_with_your_file_path", "colu", "disc");
mSet<-SanityCheckData(mSet)
mSet<-ReplaceMin(mSet);
mSet<-SanityCheckData(mSet)
mSet<-FilterVariable(mSet, "none", "F", 25)
mSet<-PreparePrenormData(mSet)
mSet<-Normalization(mSet, "NULL", "NULL", "NULL", ratio=FALSE, ratioNum=20)
mSet<-PlotNormSummary(mSet, "norm_0_", "png", 72, width=NA)
mSet<-PlotSampleNormSummary(mSet, "snorm_0_", "png", 72, width=NA)
mSet<-FC.Anal(mSet, 2.0, 0, FALSE)
mSet<-PlotFC(mSet, "fc_0_", "png", 72, width=NA)
mSet<-Ttests.Anal(mSet, F, 0.05, FALSE, TRUE, "fdr", FALSE)
mSet<-PlotTT(mSet, "tt_0_", "png", 72, width=NA)
mSet<-OPLSR.Anal(mSet, reg=TRUE)
mSet<-PlotOPLS2DScore(mSet, "opls_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)
mSet<-PlotOPLS.Splot(mSet, "opls_splot_0_", "all", "png", 72, width=NA);
mSet<-PlotOPLS.Imp(mSet, "opls_imp_0_", "png", 72, width=NA, "vip", "tscore", 15,FALSE)
mSet<-PlotOPLS.MDL(mSet, "opls_mdl_0_", "png", 72, width=NA)
mSet<-Volcano.Anal(mSet, FALSE, 2.0, 0, F, 0.1, TRUE, "raw")
mSet<-PlotVolcano(mSet, "volcano_0_",1, 0, "png", 72, width=NA)
