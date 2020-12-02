#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=michele.leemann@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mleemann/output_fastqc_%j.o
#SBATCH --error=/home/mleemann/error_fastqc_%j.e
#SBATCH --partition=pcourse80

module add UHTS/Quality_control/fastqc/0.11.7

for f in `ls /data/courses/rnaseq/lncRNAs/Project1/michele/fastq/merged_fastq/*.fastq.gz | sed 's/.fastq.gz//' `
do
fastqc -t 2 ${f}.fastq.gz
done

mv /data/courses/rnaseq/lncRNAs/Project1/michele/fastq/merged_fastq/*fastqc* /data/courses/rnaseq/lncRNAs/Project1/michele/fastqc/D_Pt8

cd /data/courses/rnaseq/lncRNAs/Project1/michele/fastqc/

module add UHTS/Analysis/MultiQC/1.8
multiqc .
