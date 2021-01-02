#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=1:00:00

# # of exons and transcripts
echo "number of exons and transcripts:" > stringtie_stats.txt
cat stringtie_merged.gtf | grep -v "^#" | cut -f3 | sort | uniq -c >> stringtie_stats.txt

# # of genes --> extract unique gene ID
echo ""
echo "number of genes:" >> stringtie_stats.txt
cat stringtie_merged.gtf | grep -v '^#' | cut -f9 | cut -f1 -d';' | cut -f2 -d' ' | tr -d '"' | sort | uniq | wc -l >> stringtie_stats.txt

# # of novel exons
echo ""
echo "number of novel exons:" >> stringtie_stats.txt
cat stringtie_merged.gtf | grep -v '^#' | cut -f9 | grep -i "transcript_id \"MSTRG" > novel_genes.txt
cat novel_genes.txt | grep -i "exon" | wc -l >> stringtie_stats.txt

# # of novel transcripts
echo ""
echo "number of novel transcripts:" >> stringtie_stats.txt
cat novel_genes.txt | grep -i "exon_number \"1\"" | wc -l >> stringtie_stats.txt

# # of novel genes
echo ""
echo "number of novel genes:" >> stringtie_stats.txt
cat novel_genes.txt | cut -f1 -d';' | sort | uniq | wc -l >> stringtie_stats.txt

# # of transcripts with more than one exon
echo ""
echo "number of transcripts with more than one exon:" >> stringtie_stats.txt
cat stringtie_merged.gtf | grep -v '^#' | cut -f9 | grep -i "exon_number \"2\"" | wc -l >> stringtie_stats.txt
echo "number of novel transcripts with more than one exon:" >> stringtie_stats.txt
cat novel_genes.txt | grep -i "exon_number \"2\"" | wc -l >> stringtie_stats.txt

# # of genes with more than one exon
echo "number of genes with more than one exon:" >> stringtie_stats.txt
cat stringtie_merged.gtf | grep -v '^#' | cut -f9 | grep -i "exon_number \"2\"" | cut -f1 -d';' | sort | uniq | wc -l >> stringtie_stats.txt
echo "number of novel genes with more than one exon:" >> stringtie_stats.txt
cat novel_genes.txt | grep -i "exon_number \"2\"" | cut -f1 -d';' | sort | uniq | wc -l >> stringtie_stats.txt
