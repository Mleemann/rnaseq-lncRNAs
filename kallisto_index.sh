#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=30000M
#SBATCH --time=5:00:00

module add UHTS/Assembler/cufflinks/2.2.1
module add UHTS/Analysis/kallisto/0.46.0

GENOME=/data/courses/rnaseq/lncRNAs/Project1/references/hg38/GRCh38.p13.fa
GTF=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie/stringtie_merged.gtf

gffread -w transcripts.fa -g $GENOME $GTF

kallisto index -i hg38.transcript.idx transcripts.fa
