# src: http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#ma-plot

library('regionReport')
library("pheatmap")
library("RColorBrewer")
library("DESeq2")
library("ggplot2")

directory <- "/mnt/c/Genome_Analysis/Results/HTSEQ_RESULTS/"
setwd(directory)

# Loads data from HTSEQ Count
sampleFiles <- grep(".result.txt",list.files(directory),value=TRUE)
sampleNames=sub('.result.txt','',sampleFiles)
sampleCondition=sub('1','',sampleNames)
sampleTable=data.frame(sampleName=sampleNames, fileName=sampleFiles, condition=sampleCondition)

ddsHTSeq=DESeqDataSetFromHTSeqCount(sampleTable=sampleTable,directory=directory,design=~1)
dds <- DESeq(ddsHTSeq)

# Get differential expression results
res <- results(dds)

# Summarizes res
res_sum = summary(res)  

table(res$padj<0.05)

# Order by the adjusted p-value
res <- res[order(res$padj), ]

# Order our results table by the smallest p value
resOrdered_min <- res[order(res$pvalue),]

resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)

names(resdata)[1] <- "Gene"

head(resdata)

# Plot dispersions
# First, gene-wise MLEs are obtained using only the respective gene’s data (black dots). 
# Then, a curve (red) is fit to the MLEs to capture the overall trend of dispersion-mean dependence. 
# This fit is used as a prior mean for a second estimation round, which results in the final MAP estimates of dispersion (arrow heads). 
# This can be understood as a shrinkage (along the blue arrows) of the noisy gene-wise estimates toward the consensus represented by the red line. 
# The black points circled in blue are detected as dispersion outliers and not shrunk toward the prior (shrinkage would follow the dotted line
png("/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/qc-dispersions.png", 1000, 1000, pointsize=20)
plotDispEsts(dds, main="Dispersion plot")
dev.off()

# Regularized log transformation for clustering/heatmaps, etc.
# src: https://www.bioconductor.org/help/course-materials/2014/SeattleOct2014/B02.1.1_RNASeqLab.html#eda
# The regularized-logarithm transformation, or rlog for short performs a where the values are shrunken towards the genes' averages across all samples.
# The function rlog returns a SummarizedExperiment object which contains the rlog-transformed values in its assay slot
rld <- rlogTransformation(dds)
head(assay(rld))
hist(assay(rld))

# Heatmap of sample distances 

# Performs a t-distribution on the assay of the rld-values (ie: the log-transformaion)
sampleDists <- dist(t(assay(rld)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors,
         filename =  "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/samp_distmap.png")
dev.off()

# src: https://www.bioinformatics.babraham.ac.uk/projects/seqmonk/Help/3%20Visualisation/3.2%20Figures%20and%20Graphs/3.2.13%20The%20MA%20Plot.html 
# MA-plot for the shrunken log2 fold changes, points will be colored red if the adjusted p value is less than 0.1. 
# This is carried out by transforming the data onto log ratio and the mean average (M resp. A).
# The output allows us to see the relationship between intensity and the difference between two data sets
# It creates a 2d-plot with a point for each entry where x-axis represents the avg. quantitated value across the data stores, and the y axis shows the difference between them
# Script taken from: https://gist.github.com/stephenturner/f60c1934405c127f09a6#file-deseq2-analysis-template-r-L47
maplot <- function (res, thresh=0.05, labelsig=TRUE, textcx=1, ...) {
  with(res, plot(baseMean, log2FoldChange, pch=20, cex=.5, log="x", ...))
  with(subset(res, padj<thresh), points(baseMean, log2FoldChange, col="red", pch=20, cex=1.5))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<thresh), textxy(baseMean, log2FoldChange, labs=Gene, cex=textcx, col=2))
  }
}

# src: https://en.wikipedia.org/wiki/Fold_change
# Fold change is a ratio. If it wasn't plotted as log(fold change), cases of downregulated expression would all be between 0 and 1, whereas upregulated expression could have any value between 1 and infinity.
# Log2 is used because that way a two-fold increase in expression (for example) has a log2(fold change) value of +1, while a two-fold decrease in expression has a log2(fold change) value of -1
# On a plot axis showing log2-fold-changes, an 8-fold increase will be displayed at an axis value of 3 (since 2^3 = 8)
png("/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/ma_plot.png", 1500, 1000, pointsize=20)
maplot(resdata, main="MA Plot")
dev.off()

png("/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/ma_plot_v2.png", 1500, 1000, pointsize=20)
DESeq2::plotMA(res)
dev.off()

# Returns a plot of normalized counts for a single gene, in this case the one with the lowest p-value
png("/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/counts_plot.png")
plotCounts(dds, gene=which.min(res$padj), intgroup="condition") 
dev.off()

# Creates a html-report
report <- DESeq2Report(dds, project = 'DESeq2 HTML report',
    intgroup = "condition", outdir = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/",
    output = 'index', theme = theme_bw())

# Creates a .pdf report
report <- DESeq2Report(dds, project = 'DESeq2 PDF report',
    intgroup = "condition", outdir = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/",
    output = 'deseq2_pdf',  output_format = 'pdf_document',  device = 'pdf', theme = theme_bw())

# Shows the no. p values less then 0.1
res_les_0_1 <- subset(res, padj<0.1)
deseq_sum_0_1 = summary(res_les_0_1)

res_les_0_0_5 <- results(dds, alpha=0.05)
deseq_sum_0_0_5 = summary(res_les_0_0_5)

# Write the resdata to .csv
write.csv(resdata, file="/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/diffexpr-results.csv")

# Writes the result of the DESeq
write.csv(res, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/deseq_res.csv")

# Writes the result ordered by smallet p-value
write.csv(resOrdered_min, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/resOrdered_min.csv")

# Writes the differentially expressed genes, p < 0.1
write.csv(res_les_0_1, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/res_les_0_1.csv")

# Writes the differentially expressed genes, p < 0.5
write.csv(res_les_0_0_5, file = "/mnt/c/Genome_Analysis/Results/DESEQ2_RESULTS/res_les_0_0_5.csv")
