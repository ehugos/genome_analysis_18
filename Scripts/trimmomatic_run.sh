#!/bin/bash -l
#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_RNA_Trim
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com
# Load modules


#Load modules
module load bioinfo-tools
module load trimmomatic

java -jar /sw/apps/bioinfo/trimmomatic/0.36/rackham/trimmomatic-0.36.jar PE -phred33 /proj/g2018003/nobackup/private/eckalbar_2016/sel4/RNA_raw_data/sel4_SRR1719013.1.fastq.gz /proj/g2018003/nobackup/private/eckalbar_2016/sel4/RNA_raw_data/sel4_SRR1719013.2.fastq.gz /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/sel4_SRR1719013.1_trimmed.fastqc.gz ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.36/rackham/adapters/TruSeq2-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
