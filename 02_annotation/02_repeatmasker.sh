#!/bin/bash
#SBATCH -n 16
#SBATCH -p main
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=100G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


## Run this script after running repeatmodeler.
## repeatmodeler will create a directory staring with RM
## You need to use consensi.fa.classified file from that directory.
## You can create a softlink of that file or copy it to your working directory

module load bio/blast/2.9.0

export PATH="/grps2/mrmckain/bin/RepeatMasker:$PATH"
export REPEATMASKER_LIB_DIR="/grps2/mrmckain/bin/RepeatMasker/Libraries/"
export BLASTDB_LMDB_MAP_SIZE=100000000 # If your genome is large, you might need to increase the size. Otherwise repeatmasker will show errors.


# path of required files

genome=$1 # use path for your genome. I am running from my working directory
lib_name=$2 # path to your library file (consensi.fa.classified) created by repeatmodeler as mentioned in the begining of the script.

# Now softmasked the genome

RepeatMasker -pa 16 -gff -nolow -lib $lib_name $genome -xsmall -dir softmasking
