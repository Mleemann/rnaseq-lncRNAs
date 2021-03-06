#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00

module add UHTS/Aligner/hisat/2.2.1

cd /data/courses/rnaseq/lncRNAs/Project1/references/hg38

wget -O GRCh38.p13.fa.gz ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/GRCh38.p13.genome.fa.gz
gunzip GRCh38.p13.fa.gz > GRCh38.p13.fa
wget -O GRCh38.p13.gtf.gz ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/gencode.v35.annotation.gtf.gz
gunzip GRCh38.p13.gtf.gz > GRCh38.p13.gtf

GENOME=/data/courses/rnaseq/lncRNAs/Project1/references/hg38/GRCh38.p13
INDEX_BASE=hg38

extract_splice_sites.py ${GENOME}.gtf > ${INDEX_BASE}.ss
extract_exons.py ${GENOME}.gtf > ${INDEX_BASE}.exon

hisat2-build --ss ${INDEX_BASE}.ss --exon ${INDEX_BASE}.exon ${GENOME}.fa ${INDEX_BASE}
