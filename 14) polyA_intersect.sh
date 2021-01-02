#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=0:10:00

module add UHTS/Analysis/BEDTools/2.29.2

ASSEMBLY=/data/courses/rnaseq/lncRNAs/Project1/michele/stringtie/stringtie_merged.gtf

cd /data/courses/rnaseq/lncRNAs/Project1/michele/polyA

wget https://polyasite.unibas.ch/download/atlas/2.0/GRCh38.96/atlas.clusters.2.0.GRCh38.96.bed.gz
gunzip atlas.clusters.2.0.GRCh38.96.bed.gz

# get polyA coordinates adding 'chr' to first column
awk '{print $1="chr" $1,$2,$3,$6}' atlas.clusters.2.0.GRCh38.96.bed | tr ' ' \\t > polyA_for_intersect.bed

# get 3' coordinates of transcripts +/- 50nt from merged-assembly
awk '$3=="transcript"{print $1,$5-50,$5+50,$7,$9,$10,$11,$12}' $ASSEMBLY | tr ' ' \\t > polyA_100.bed

bedtools intersect -a polyA_100.bed -b polyA_for_intersect.bed -wa > polyA_intersect100.bed
