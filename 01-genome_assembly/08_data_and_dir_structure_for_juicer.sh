#!/bin/bash

# Juicer needs a certain diretory structure with scripts and data.
# This script will generate the appropriate directories and put data accordingly.
# This is juicer 1.6 version. more stable to use the CPU version in uahpc cluster.
# Before running the script make a directory in scratch for scaffolding and copy this script there.

#set path for genome and hic data

genome=$1 # genome with full path
hic_dir=$2 # path of your hic_data directory
scripts_dir="/grps2/mrmckain/bin/genome_scaffold_tools"
# Assuming you are in a directory which is dedicated for genome scaffolding

#set juicer and the scripts according to the juicer github instructions

mkdir juicer_mapping
cd juicer_mapping/
cp -r $scripts_dir/juicer .
ln -s ./juicer/CPU scripts
cd scripts/common
ln -s juicer_tools.1.9.9_jcuda.0.8.jar  juicer_tools.jar

# Now get data and put them in appropriate directory

# Get genome using for scaffolding to make indexes and further use
cd ../../
mkdir references
cd references/
cp $genome .

# Make symbolic link of hic files in a directory
cd ../
mkdir fastq
cd fastq/
ln -s $hic_dir/*.fastq.gz .
cd ../

# Now copy other scripts for indexing, restriction enzyme site, and chrom sizes
cp $scripts_dir/generate_site_positions.py .
cp $scripts_dir/prep_files.srun .
cp $scripts_dir/run_juicer.srun .
echo "done"

