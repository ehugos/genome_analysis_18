#!/bin/bash -l
#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_RNA_QUAST
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load quast
# Run scripts
quast.py /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/SOAPDENOVO2/SOAPdenovo_2_results.contig -R /proj/g2018003/nobackup/private/eckalbar_2016/additional_data/sel4_NW_015503979.fna.gz -o /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/QUAST/ -t 4 --min-contig 100 --eukaryote 
