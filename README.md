# RNA expression in cisplatin resistant non-small lung cancer cells

## Workflow of the project

Dataset: 3 replicates for each of 4 condition (A24wt, Pt2, Pt4, Pt8), each replicate has 4 fastq-files (R1_L1, R1_L2, R2_L1, R2_L2) 

1. lane-merging of fastq-files: **fastq_lane_merging.sh**
2. quality control of the merged reads: **fastqc.sh**
3. build hisat2 index for mapping: **index_hisat2.sh** 
4. read mapping: **run_hisat2.sh**
5. sorting mapped BAM files: **sorting_bam.sh**
6. merging the 3 BAM files of each condition: **bam_merging.sh**
7. transcriptome assembly: **stringtie.sh**
8. merging assembled GTF files: **stringtie_gtf_merging.sh**
9. statistics on the meta-assembly file: **stringtie_stats.sh**
10. build kallisto index for quantification: **kallisto_index.sh**
11. transcript expression quantification: **kallisto.sh**
12. differential expression analysis: **sleuth.R**
13. compare 5' end annotaions: **tss_intersect.sh** 
14. compare 3' end annotaions: **polyA_intersect.sh** 
15. evaluation of coding potential: **cpat.sh**
16. detection of intergenic genes: **intergenic.sh**