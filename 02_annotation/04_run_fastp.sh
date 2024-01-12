#!/bin/bash
#SBATCH -n 20
#SBATCH -p ultrahigh
#SBATCH --qos mrmckain
#SBATCH -N 1
#SBATCH --mem=50G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


export PATH=$PATH:/grps2/mrmckain/bin/fastp
export PATH=$PATH:/mrm/bin/parallel-20211022/:/mrm/bin/parallel-20211022/bin:/mrm/bin/parallel-20211022/share

cat ids.txt | parallel -j 1 \
"fastp -i $(pwd)/sra_data/{}_1.fastq -o $(pwd)/trimmed_data/{}_1.fastq \
-I $(pwd)/sra_data/{}_2.fastq -O $(pwd)/trimmed_data/{}_2.fastq \
-h $(pwd)/trimmed_out_html/{}_fastp.html -w 10 -f 5 -g" 
