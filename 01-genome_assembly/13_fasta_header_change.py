import sys
import os

'''
This script takes the output file from post_3ddna.sh after scaffolding the genome.
Nypa genome has 17 chromosomes. This scirpt replace the ">HiC_scaffold_" part of
the fasta header to ">chr_" for the first 17 scaffolds (after juicebox review
all the smaller contigs were put after the 17 chromosome-level scaffolds).
Then for the remaining smaller contigs ">HiC_scaffold_" is replaced by ">scaf_".
 
'''
input_fa = sys.argv[1] # input fasta file
out_fa = sys.argv[2] # output fasta file

changed_count = 0
out_fa_lines = []

with open(input_fa, "r") as f1:
    for line in f1:
        if line.startswith(">"):
            if line.startswith(">HiC_scaffold_"):
                changed_count += 1
                if changed_count <= 17:
                    line = line.replace(">HiC_scaffold_", ">chr_")
                else:
                    line = line.replace(">HiC_scaffold_", ">scaf_")
        out_fa_lines.append(line)

with open(out_fa, "w") as f2:
    f2.writelines(out_fa_lines)

print('done')
