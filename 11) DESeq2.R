BiocManager::install('EnhancedVolcano')
devtools::install_github('kevinblighe/EnhancedVolcano')

library('DESeq2')
library('ggplot2')
library('ggrepel')
library('EnhancedVolcano')

directory <- "/Users/Michele/Documents/UNI/HS2020/rnaSequencing/Project/htseq_count/"
sampleFiles <- grep("*.txt", list.files(directory), value = TRUE)
sampleCondition <- c("A24wt", "A24wt", "A24wt", "D_Pt2", "D_Pt2", "D_Pt2", "D_Pt4", "D_Pt4", "D_Pt4", "D_Pt8", "D_Pt8", "D_Pt8")
sampleTable <- data.frame(sampleName = sampleFiles, fileName = sampleFiles, condition = sampleCondition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design = ~ condition)

# pre-filtering of counts
keep <- rowSums(counts(ddsHTSeq)) >= 10
dds <- ddsHTSeq[keep,]

dds$condition <- relevel(dds$condition, ref = "A24wt")

# apply LRT
dds <- DESeq(dds, test = 'LRT', reduced = ~1)
res <- results(dds)

resOrdered <- res[order(res$pvalue),]
summary(res)
write.csv(as.data.frame(resOrdered), file = 'deseq2_genes_lrt.csv')

sum(res$padj < 0.1, na.rm=TRUE)

# significant differential expressed genes
resSig <- subset(resOrdered, padj < 0.1)
write.csv(as.data.frame(resSig), file = 'significant_de_genes_lrt.csv')

# volcano plot
EnhancedVolcano(res,
                lab = rownames(res),
                selectLab = c(''),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'wt versus treated',
                pCutoff = 10e-32,
                FCcutoff = 0.5,
                xlim = c(-21, 21),
                pointSize = 3.0,
                labSize = 4.0,
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 3.0)


# plot counts of three top genes
col <- c('black', 'blue', 'red', 'green')
plotCounts(dds, 'MSTRG.13994', intgroup='condition', col = c(rep(col, each = 3)), pch = 16)
plotCounts(dds, 'MSTRG.17365', intgroup='condition', col = c(rep(col, each = 3)), pch = 16)
plotCounts(dds, 'MSTRG.10917', intgroup='condition', col = c(rep(col, each = 3)), pch = 16)


# draw heatmap of sample-to-sample distances
library('pheatmap')
library('RColorBrewer')

vsd <- vst(dds, blind=FALSE)
sampleDists <- dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condition, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, 'Blues')) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)
