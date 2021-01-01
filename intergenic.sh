#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=02:00:00

module add UHTS/Analysis/BEDTools/2.29.2

bedtools intersect -a /data/courses/rnaseq/lncRNAs/Project1/michele/stringtie/stringtie_merged.gtf \
                   -b /data/courses/rnaseq/lncRNAs/Project1/references/annotation_gtf/gencode.v35.annotation.gtf \
                   -v > /data/courses/rnaseq/lncRNAs/Project1/michele/integrative/intersect.bed
