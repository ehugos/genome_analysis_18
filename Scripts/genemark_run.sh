BATCH -A g2018003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 09:00:00
#SBATCH -J husw7547_Genome_Analysis_Paper_II_RNA_MAKER2
#SBATCH --mail-type=ALL
#SBATCH --mail-user hugo.swenson@gmail.com

# Load modules
module load bioinfo-tools
module load genemark

gmes_petap.pl -ES -fungus -cores 10 -sequence /home/data/my_assembly.fasta
