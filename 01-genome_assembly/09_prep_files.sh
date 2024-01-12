#!/bin/bash
#SBATCH -n 32
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

module load java/1.8.0
module load python/python3/3.6.5shared
export PATH=$PATH:/mrm/bin/bedtools2/:/mrm/bin/bwa-0.7.17/

genome=$1 # provide the name of the genome file
cd ./references

# make index files using bwa
bwa index $genome

cd ../

# get chromosome size file using bioawk
/mrm/bin/bioawk/bioawk \
 -c fastx '{print $name"\t"length($seq)}' \
 ./references/$genome > chrom.sizes

# use the generate_site_positions.py script from juicer github page to generate restriction enzyme site postions
# MboI --> restriction enzyme used for Nypa

python ./generate_site_positions.py \
 MboI $genome ./references/$genome
