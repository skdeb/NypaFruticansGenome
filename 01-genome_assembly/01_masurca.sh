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

module load perl/5.22.1
export PATH=/mrm/bin/Masurca4.0.6/masurca-4.0.6/MaSuRCA-4.0.6/bin/:$PATH

cp /mrm/bin/Masurca4.0.6/masurca-4.0.6/MaSuRCA-4.0.6/masurca_config_example.txt ./config.txt

# edit the config file with necessary input files and options

# then run masurca with the edited config.txt file.

masurca config.txt # will generate from the configuration file a shell script assemble.sh

./assemble.sh # the script assemble.sh will assemble the data.
