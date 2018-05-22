#!/bin/bash -l

#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 09:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_HTSEQ
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load htseq

cd /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/Reads/

ls | sed 's/.trim.*$//' | sort | uniq | while read line; do htseq-count -f bam -s no -t gene -i Name /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/TOPHAT_RESULTS/${line}_sorted_accepted_hits.bam /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/MAKER2/NW_015503979.1/NW_015503979%2E1.gff > /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/HTSEQ/HTSEQ_RESULTS/${line}_htseq_counted_result.txt ;done
