#!/bin/bash -l

#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J husw7547_Genome_Analysis_TOPHAT
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load bowtie
module load bowtie2
module load tophat

cd /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/Reads/

ls | sed 's/.trim.*$//' | sort | uniq | while read line; do tophat -p 8 -o /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/TOPHAT_RESULTS/${line} /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/sel4_NW_015503979_mapped ${line}.trim_1P.fastq.gz ${line}.trim_2P.fastq.gz ;done 
