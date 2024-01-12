#!/bin/bash

anno_file=$1 #gff3 file from annotation
tsv_file=$2 # tsv file from interproscan output

#get single exon gene list from the renamed gff3 file

#example: python id_single_exon-augustus.py Nf_genome_final_annotation.gff3fixed_name.gff3

python id_single_exon-augustus.py $anno_file # this will output single_exon_augustus_only.txt file

#get unique ids from the interproscan tsv output file

#example: cut -f1 ips_output.tsv | cut -d'.' -f1 | sort | uniq > unique_ids.txt

cut -f1 $tsv_file | cut -d'.' -f1 | sort | uniq > unique_ids.txt

#now grep the single exon genes that are missing in the interproscan unique id file

grep -Fvxf unique_ids.txt single_exon_augustus_only.txt > missing_ids.txt

# Finally run the agat_sp_filter_feature_from_kill_list.surn script to filter the single exon genes from the gff3 file that lack protein evidence. This gff3 file will be final annotaion file.
