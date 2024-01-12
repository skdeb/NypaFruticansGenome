#!/bin/sh
#SBATCH -n 20
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=50G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --job-name=sra_data_download

export PATH=$PATH:/grps2/mrmckain/bin/annotation_tools/sratoolkit.3.0.5-centos_linux64/bin

mkdir temp
mkdir sra_data

FILENAME="ids.txt" # SRA ids to download saved in a txt file
count=0

while read LINE
do
    let count++
    fasterq-dump --split-files $LINE -e 20 -t $(pwd)/temp -O $(pwd)/sra_data 
    echo "$LINE"

done < $FILENAME
echo -e "\nTotal lines read = $count"

