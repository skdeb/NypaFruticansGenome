#!/bin/bash
#SBATCH -n 10
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH --mem=20G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

module load bio/samtools/1.9
export PATH=$PATH:/mrm/bin/minimap2-2.22/

reads_dir=$1 # path of the data directory
genome_fasta=$2 # genome fasta file, available in the current working directory
sample_id=$3 # common id among the samples
outfile=$4  # output bam file name

minimap2 -ax sr $genome_fasta \
 $reads_dir/${sample_id}_R1.fastq \
 $reads_dir/${sample_id}_R2.fastq --secondary=no \
    | samtools sort -o ${outifle}_aligned.bam -T tmp.ali

