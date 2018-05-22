#!/bin/bash -l
#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 09:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_SAMSORT
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load samtools

cd /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/TOPHAT_RESULTS/ 

ls | while read line; do samtools sort ${line}/accepted_hits.bam > ${line}_sorted_accepted_hits.bam; \
samtools index ${line}_sorted_accepted_hits.bam; done
