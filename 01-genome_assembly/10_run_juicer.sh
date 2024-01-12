#!/bin/bash
#SBATCH -n 32
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=256G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

module load java/1.8.0
module load bio/samtools/1.9
module load perl/5.22.1

genome=$1 # provide genome name with the script

./scripts/juicer.sh -g $genome \
 -z ./references/$genome \
 -p chrom.sizes -s MboI -D . \
 -y ${genome}_MboI.txt -t 32
