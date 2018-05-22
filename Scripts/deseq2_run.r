library("pheatmap")
library(RColorBrewer)
library("DESeq2")

directory <- "/mnt/c/Genome_Analysis/Results/HTSEQ_RESULTS/"
setwd(directory)

# Loads data from HTSEQ Count
sampleFiles <- grep(".result.txt",list.files(directory),value=TRUE)
sampleNames=sub('.result.txt','',sampleFiles)
sampleCondition=sub('1','',sampleNames)
sampleTable=data.frame(sampleName=sampleNames, fileName=sampleFiles, condition=sampleCondition)

ddsHTSeq=DESeqDataSetFromHTSeqCount(sampleTable=sampleTable,directory=directory,design=~1)

dds <- DESeq(ddsHTSeq)
res <- results(dds)

# Extract the significantly differentially expressed genes
resOrdered<- res[order(res$padj),]
resSig <- subset(resOrdered, padj<0.05)

# use the log transform on the data set
rld <- rlog(dds, blind=FALSE)

sampleDists <- dist(t(assay(rld)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors,
         filename =  "/mnt/c/Genome_Analysis/distmap.png")

rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors,
         filename =  "/mnt/c/Genome_Analysis/distmap_2.png")

write.csv(res, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/deseq_res.csv")
write.csv(resSig, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/deseq_resSig.csv")
write.csv(resOrdered, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/deseq_resOrdered.csv")
