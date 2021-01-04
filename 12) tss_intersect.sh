#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=0:10:00

module add UHTS/Analysis/BEDTools/2.29.2

ASSEMBLY=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie/stringtie_merged.gtf

cd /data/courses/rnaseq/lncRNAs/Project1/michele/CAGE

# get CAGE peak file and extract TSS coordinates
wget https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_latest/extra/CAGE_peaks/hg38_liftover+new_CAGE_peaks_phase1and2.bed.gz
gunzip hg38_liftover+new_CAGE_peaks_phase1and2.bed.gz
awk '{print $1,$7,$8,$6}' hg38_liftover+new_CAGE_peaks_phase1and2.bed | tr ' ' \\t > CAGE_tss.bed

# get 5' coordinates of transcripts +/- 50nt from merged-assembly
awk '$3=="transcript"{print $1,$4-50,$4+50,$7,$9,$10,$11,$12}' $ASSEMBLY | tr ' ' \\t > TSS_100.bed

bedtools intersect -a TSS_100.bed -b CAGE_tss.bed -wa > tss_intersect100.bed
