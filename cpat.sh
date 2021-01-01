#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=02:00:00

module add SequenceAnalysis/GenePrediction/cpat/1.2.4

HOME_DIR=/data/courses/rnaseq/lncRNAs/Project1/michele/cpat
GENE_FILE=/data/courses/rnaseq/lncRNAs/Project1/michele/kallisto2/transcripts.fa

cd $HOME_DIR

wget https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/Human_Hexamer.tsv -O Human_Hexamer.tsv
wget https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/Human_logitModel.RData -O Human_logitModel.RData

cpat.py -x Human_Hexamer.tsv -d Human_logitModel.RData -g $GENE_FILE -o $HOME_DIR/cpat
