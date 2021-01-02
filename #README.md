# RNA expression in cisplatin resistant non-small lung cancer cells

## Workflow of the project

Dataset: 3 replicates for each of 4 condition (A24wt, Pt2, Pt4, Pt8), each replicate has 4 fastq-files (R1_L1, R1_L2, R2_L1, R2_L2) 

* lane-merging of fastq-files: **fastq_lane_merging.sh**
* quality control of the merged reads: **fastqc.sh**
* build hisat2 index for mapping: **index_hisat2.sh** 
* read mapping: **run_hisat2.sh**
* sorting mapped BAM files: **sorting_bam.sh**
* merging the 3 BAM files of each condition: **bam_merging.sh**
* transcriptome assembly: **stringtie.sh**
* merging assembled GTF files: **stringtie_gtf_merging.sh**
* statistics on the meta-assembly file: **stringtie_stats.sh**
* build kallisto index for quantification: **kallisto_index.sh**
* transcript expression quantification: **kallisto.sh**
* differential expression analysis: **sleuth.R**
* compare end annotaions: **tss_intersect.sh, polyA_intersect.sh** 
* evaluation of coding potential: **cpat.sh**
* detection of intergenic genes: **intergenic.sh**
