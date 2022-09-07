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
