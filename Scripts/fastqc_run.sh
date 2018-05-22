module load bioinfo-tools
module load FastQC

mkdir /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/RNA_FASTQC_RESULTS

for file in /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/*.gz
do fastqc ${file} -o /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/RNA_FASTQC_RESULTS
done

gunzip /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/RNA_FASTQC_RESULTS/*.gz

for file in /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/RNA_FASTQC_RESULTS/*.fastq
do fastqc -f fastq ${file} -o /home/sativus/Genome_Analysis_husw7546/genome_analysis_18/TRIMMOMATIC/RNA_FASTQC_RESULTS/ ${file}
done
