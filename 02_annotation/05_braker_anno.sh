#!/bin/bash
#SBATCH --job-name=Braker
#SBATCH -n 1 #tasks
#SBATCH -N 1 #nodes
#SBATCH -c 16 #number of cores per task
#SBATCH --mem=999G #memory used
#SBATCH -o slurm_output.%J
#SBATCH -e slurm_error.%J
#SBATCH -p threaded
#SBATCH -q threaded
#SBATCH --mail-type=ALL
#SBATCH --mail-user=skdeb@uahpc.ua.edu

# Load Singularity module
module load singularity/3.7.2
module load perl/5.22.1threaded

# Define paths and filenames
container_path="/grps2/mrmckain/bin/annotation_tools/braker3.sif"
genome_file="/braker/nypa_genome_softmasked.fasta"
prot_seq_file="/braker/Viridiplantae.fa"
rnaseq_ids_file="$(pwd)/ids.txt"
rnaseq_sets_dirs="/braker/trimmed_nypa_only_data"
species="nypa"

# Read RNA-Seq IDs from the file
rnaseq_ids=$(paste -sd, "$rnaseq_ids_file")

singularity exec --bind $(pwd):/braker "$container_path" braker.pl \
  --genome="$genome_file" \
  --softmasking \
  --prot_seq="$prot_seq_file" \
  --rnaseq_sets_ids="$rnaseq_ids" \
  --rnaseq_sets_dirs="$rnaseq_sets_dirs" \
  --species="$species" \
  --threads 16 --gff3  --workingdir=/braker/nypa_anno_out

