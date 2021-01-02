#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=5:00:00

module add UHTS/Aligner/stringtie/1.3.3b

stringtie --merge -G /data/courses/rnaseq/lncRNAs/Project1/references/annotation_gtf/gencode.v35.annotation.gtf -o stringtie_merged.gtf mergelist.txt
