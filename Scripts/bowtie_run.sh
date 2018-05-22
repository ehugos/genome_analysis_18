#!/bin/bash -l

#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 09:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_BOWTIE
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load bowtie2

bowtie2-build sel4_NW_015503979.fna sel4_NW_015503979_mapped

