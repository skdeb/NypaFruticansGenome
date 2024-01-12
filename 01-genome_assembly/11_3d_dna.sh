#!/bin/bash
#SBATCH --job-name=3dDNA
#SBATCH -n 20
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu
 
export PATH=$PATH:/mrm/bin/parallel-20211022/:/mrm/bin/parallel-20211022/bin:/mrm/bin/parallel-20211022/share

export PATH=$PATH:/mrm/bin/3D_DNA/3d-dna-201008

module load java/1.8.0
module load perl/5.22.1threaded

#provide full path of the both files
# or have them in the working directory or create soft links for both of the files in the working directory

genome=$1 # initial contig level genome file
merge_no_dup=$2 # output from juicer mapping

run-asm-pipeline.sh $genome $merge_no_dup
