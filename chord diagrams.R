metabolite <- read.csv('metabolite.csv', row.names = 1,header = TRUE,stringsAsFactors=FALSE)
class<-read.csv('class.csv')
metabolite<- t(metabolite) 
metabolite <- log(metabolite+1)
library(Hmisc)
metabolite1 <- rcorr(as.matrix(metabolite))
flattenCorrMatrix <- function(cormat, pmat) {
ut <- upper.tri(cormat)
data.frame(
row = rownames(cormat)[row(cormat)[ut]],
column = rownames(cormat)[col(cormat)[ut]],
cor  =(cormat)[ut],
p = pmat[ut]
)
}
cor_p<-flattenCorrMatrix(metabolite1$r, metabolite1$P)
cor_p <- subset(cor_p, cor != 0) 
diag(cor_p) <- 0
cor1<-cor_p[abs(cor_p$cor)>0.6 & cor_p$p<0.05,]
cor1= cor1[,-4]
library(dplyr)
colnames(cor1)<-c("HMDB","HMDB2","cor")
colnames(cor1)
cor2<-dplyr::left_join(cor1,class,by="HMDB")
head(cor2)
colnames(class)<-c("HMDB2","superclass2")
cor3<-dplyr::left_join(cor2,class,by="HMDB2")
head(cor3)
cor4<-cor3[, c("Super.Class","superclass2","cor")]
head(cor4)
cor4 <- rename(cor4,c("HMDB" = "Super.Class","HMDB2" = "superclass2"))
head(cor4)
cor4[cor4 == 'Amino acids, peptides, and analogues']<- 'Amino'
cor4[cor4 == 'Lipids and lipid-like molecules']<- 'Lipids'
cor4[cor4 == 'Organoheterocyclic compounds']<- 'Organoheterocyclic'
cor4[cor4 == 'Nucleosides, nucleotides, and analogues']<- 'Nucleosides'
cor4[cor4 == 'Organic oxygen compounds']<- 'oxygen'
cor4[cor4 == 'Organicnitrogen']<- 'other'
head(cor4)
cor4$HMDB[cor4$HMDB == 'Amino acids']<- 'Amino'
cor4=na.omit(cor4)
head(cor4)
library(circlize)
p<-chordDiagram(cor4,
annotationTrack = c('grid', 'name'), 
#grid.col = c(Amino = 'green3', Lipids = 'red', Organoheterocyclic = 'orange', Nucleosides = 'purple', oxygen = 'skyblue', other = 'blue'), #定义基因颜色
col = colorRamp2(c(-1, 0, 1), c('darkcyan', 'white', 'Deeppink'), transparency = 0.7), #根据相关性大小展示连线的颜色范围
annotationTrackHeight = c(0.05, 0.1), 
)













