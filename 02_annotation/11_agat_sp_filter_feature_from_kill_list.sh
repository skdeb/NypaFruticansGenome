#!/bin/bash
#SBATCH -n 4
#SBATCH -p threaded
#SBATCH -q threaded
#SBATCH -N 1
#SBATCH --mem=10G
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu


module load singularity/3.7.2
container_path="/grps2/mrmckain/bin/docker_agat/agat_0.6.2--pl5262r35hdfd78af_0.sif"
gff3_file=$1
id_rm_list=$2 # gene ids that need to be removed from the gff3 file
out_gff3=$3 # output name of the gff3 file

singularity run --bind ${PWD}:${PWD} \
 "$container_path" agat_sp_filter_feature_from_kill_list.pl \
 --gff $gff3_file \
 --kill_list $id_rm_list \
 -o $out_gff3 




