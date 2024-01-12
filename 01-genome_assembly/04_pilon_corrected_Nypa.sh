#!/bin/bash
#SBATCH -n 1
#SBATCH --mem-per-cpu=20000
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

module load bio/samtools/1.10
module load java/1.8.0
module load bio/bowtie/2.3

mkdir pilon_cleaning
cd pilon_cleaning


file=$1 # genome fasta file

#$2 provide an argument with the script
#script is modified from mrmckain
#single_line.pl perl script is written by Michael McKain

#doing three rounds of pilon cleaning
for i in {1..3}
do
	
	bowtie2-build $file $2\_iter$i
	bowtie2 --very-sensitive-local -x $2\_iter$i -1 $2.trimmed_P1.fq -2 $2.trimmed_P2.fq -S $2\_iter$i.sam
	samtools view -b $2\_iter$i.sam -o $2\_iter$i.bam
	samtools sort -m 5G -o $2\_iter$i\_sorted.bam $2\_iter$i.bam
	samtools index $2\_iter$i\_sorted.bam 
	perl /mrm/bin/single_line.pl $file
	java -Xmx10G -jar /mrm/bin/pilon-1.22.jar --genome $file\_single.fa --bam $2\_iter$i\_sorted.bam --output $2\_iter$i\_pilon --outdir $2\_iter$i\_pilon --changes 
	file=$2\_iter$i\_pilon/$2\_iter$i\_pilon.fasta
done
