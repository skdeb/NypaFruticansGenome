#!/bin/bash
#SBATCH -n 20
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


source ~/.bash_profile
conda activate purge_haplotigs

# all input files available in the current working directory

genome_fasta=$1 # genome fasta file, available in the current working directory
bam_file=$2 # aligned bam file output from minimap2
outfile=$3 # output file name for the purged genome

purge_haplotigs  hist \
 -b $bam_file \
 -g $genome_fasta -t 20

# After running the above step, check the output histogram plot and select cutoffs
# Then run the following steps

# get coverage stats
purge_haplotigs  cov  \
 -i ${bam_file}.gencov \
 -l 5  -m 90  -h 200 \
 -o coverage_stats.csv

# Now purge the genome

purge_haplotigs  purge \
 -g $genome_fasta \
 -c coverage_stats.csv \
 -a 50 -o $outfile

