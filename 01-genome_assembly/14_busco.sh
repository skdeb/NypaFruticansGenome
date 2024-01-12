#!/bin/bash
#SBATCH -n 20
#SBATCH -p main
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

source /share/apps/modulefiles/conda_init.sh
conda activate busco_5_0_0

genome=$1 # provide genome fasta file
out_pref=$2 # provide a prefix for output directory
busco_lineage="$(pwd)/embryophyta_odb10"

busco -i $genome -o $out_pref \
 -l $busco_lineage \
 -m genome --cpu 4
