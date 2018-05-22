library("DESeq2")
directory <- "../HTSEQ_RESULTS/"
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
         filename =  "distmap_heat.png")

# select the 'contrast' you want
annotation_data <- as.data.frame(colData(rld)[c("ConditionA","ConditionB")])
pheatmap(matrix, annotation_col=annotation_data, filename="heatmap.png")