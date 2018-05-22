#!/bin/bash -l
#SBATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_DESEQ2
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load RStudio
module load R_packages

Rscript deseq2_run.r


