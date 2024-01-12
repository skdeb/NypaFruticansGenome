#!/bin/bash
#SBATCH -n 20
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


module load bio/repeatmodeler/2.0.3
export BLAST_USAGE_REPORT=false
genome=$1 # provide your genome
species=$2 #provide your species name. you can use it for naming the database

BuildDatabase -name $species -engine ncbi "$genome"
RepeatModeler -pa 16 -engine ncbi -database $species 2>&1 | tee repeatmodeler.log
