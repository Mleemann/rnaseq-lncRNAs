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

keep <- rowSums(counts(ddsHTSeq)) >= 10
dds <- ddsHTSeq[keep,]

dds$condition <- relevel(dds$condition, ref = "A24wt")

dds <- DESeq(dds)
res <- results(dds)

resOrdered <- res[order(res$pvalue),]
summary(res)
write.csv(as.data.frame(resOrdered), file = 'deseq2_genes.csv')

sum(res$padj < 0.1, na.rm=TRUE)
plotMA(res, ylim=c(-2,2))

resSig <- subset(resOrdered, padj < 0.1)
write.csv(as.data.frame(resSig), file = 'significant_de_genes.csv')
write.table(resSig, file = 'DESeq2_significant_genes.txt', sep = "\t")

EnhancedVolcano(res, lab = rownames(res), x = 'log2FoldChange', y = 'pvalue')

EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'wt versus treated',
                selectLab = c('MSTRG.4734', 'MSTRG.20167', 'MSTRG.5661', 'MSTRG.23045', 'MSTRG.23124', 'MSTRG.21707', 'MSTRG.16545', 'MSTRG.19589', 'MSTRG.26151'),
                pCutoff = 10e-32,
                FCcutoff = 0.5,
                xlim = c(-21, 21),
                ylim = c(-2, 300),
                pointSize = 3.0,
                labSize = 4.0,
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 3.0,
                labCol = 'black',
                drawConnectors = TRUE,
                widthConnectors = .5,
                colConnectors = 'black')
