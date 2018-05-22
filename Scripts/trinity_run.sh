#!/bin/bash -l
#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load trinity

cd /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TOPHAT/Reads/

Trinity --seqType fq --max_memory 50G --left sel4_SRR1719013.trim_1P.fastq.gz, sel4_SRR1719014.trim_1P.fastq.gz, sel4_SRR1719015.trim_1P.fastq.gz, sel4_SRR1719016.trim_1P.fastq.gz, sel4_SRR1719017.trim_1P.fastq.gz, sel4_SRR1719018.trim_1P.fastq.gz, sel4_SRR1719204.trim_1P.fastq.gz, sel4_SRR1719206.trim_1P.fastq.gz, sel4_SRR1719207.trim_1P.fastq.gz, sel4_SRR1719208.trim_1P.fastq.gz, sel4_SRR1719209.trim_1P.fastq.gz, sel4_SRR1719211.trim_1P.fastq.gz, sel4_SRR1719212.trim_1P.fastq.gz, sel4_SRR1719213.trim_1P.fastq.gz, sel4_SRR1719214.trim_1P.fastq.gz, sel4_SRR1719241.trim_1P.fastq.gz, sel4_SRR1719242.trim_1P.fastq.gz, sel4_SRR1719266.trim_1P.fastq.gz --right sel4_SRR1719013.trim_2P.fastq.gz, sel4_SRR1719014.trim_2P.fastq.gz, sel4_SRR1719015.trim_2P.fastq.gz, sel4_SRR1719016.trim_2P.fastq.gz, sel4_SRR1719017.trim_2P.fastq.gz, sel4_SRR1719018.trim_2P.fastq.gz, sel4_SRR1719204.trim_2P.fastq.gz, sel4_SRR1719206.trim_2P.fastq.gz, sel4_SRR1719207.trim_2P.fastq.gz, sel4_SRR1719208.trim_2P.fastq.gz, sel4_SRR1719209.trim_2P.fastq.gz, sel4_SRR1719211.trim_2P.fastq.gz, sel4_SRR1719212.trim_2P.fastq.gz, sel4_SRR1719213.trim_2P.fastq.gz, sel4_SRR1719214.trim_2P.fastq.gz, sel4_SRR1719241.trim_2P.fastq.gz, sel4_SRR1719242.trim_2P.fastq.gz, sel4_SRR1719266.trim_2P.fastq.gz --SS_lib_type FR --CPU 8 --normalize_reads --no_cleanup --output /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRINITY/TRINITY_RESULTS/
