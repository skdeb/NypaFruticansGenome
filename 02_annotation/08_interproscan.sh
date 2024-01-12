#!/bin/bash
#SBATCH --job-name=interproscan
#SBATCH -n 1 #tasks
#SBATCH -N 1 #nodes
#SBATCH -c 16 #number of cores per task
#SBATCH --mem=100G #memory used
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH -p threaded
#SBATCH -q threaded
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


module load bio/interproscan/5.19
module load perl/5.22.1threaded

prot_file=$1 # proteins_no_asterisk_no_blanks.aa

interproscan.sh -b ips_output -f TSV -i $prot_file --iprlookup -t p -T ./


