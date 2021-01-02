library('sleuth')
library('BUSpaRse')
library('dplyr')

setwd('/Users/Michele/Desktop/sleuth')

sample_id <- dir(file.path('/Users/Michele/Desktop/sleuth/kallisto2/'))

kal_dirs <- file.path('/Users/Michele/Desktop/sleuth/kallisto2/', sample_id)

s2c <- read.table('s2c_table.txt', header = TRUE)
s2c <- dplyr::mutate(s2c, path = file.path('kallisto2', sample, 'abundance.h5'))
s2c

tr2g <- tr2g_gtf('/Users/Michele/Desktop/sleuth/stringtie_merged.gtf', get_transcriptome = FALSE, write_tr2g = FALSE, save_filtered_gtf = FALSE)
colnames(tr2g) = c('target_id', 'gene_id', 'gene_name')
tr2g

so <- sleuth_prep(s2c, ~condition, extra_bootstrap_summary=TRUE, target_mapping = tr2g,
                  aggregation_column = 'gene_id')
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')

sleuth_save(so, file = "so_object.rds")

# gene-level differential expression
sleuth_table_genes <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE, pval_aggregate = TRUE)
write.table(sleuth_table_genes, file = 'sleuth_table_genes.txt', sep = "\t")

sleuth_significant_genes <- dplyr::filter(sleuth_table_genes, qval <= 0.1)
write.table(sleuth_significant_genes, file = 'sleuth_significant_genes.txt', sep = "\t")
head(sleuth_significant_genes)

# transcript-level differential expression
sleuth_table_transcripts <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE, pval_aggregate = FALSE)
write.table(sleuth_table_transcripts, file = 'sleuth_table_transcripts.txt', sep = "\t")

sleuth_significant_transcripts <- dplyr::filter(sleuth_table_transcripts, qval <= 0.1)
write.table(sleuth_significant_transcripts, file = 'sleuth_significant_transcripts.txt', sep = "\t")
head(sleuth_significant_transcripts)

# plots of the 3 most significant genes
#plot_bootstrap(so, 'MSTRG.12056.3', units = "est_counts", color_by = "condition")
#plot_bootstrap(so, 'ENST00000301522.3', units = "est_counts", color_by = "condition")
#plot_bootstrap(so, 'ENST00000230419.9', units = "est_counts", color_by = "condition")
