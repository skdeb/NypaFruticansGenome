import sys
import re

infile= sys.argv[1]
outfile= sys.argv[2]

with open(infile, 'r') as file, open(outfile, 'w') as out:
    id = None
    exon_counter = 0

    for line in file:
        line = line.strip()

        if 'AUGUSTUS' not in line:
            continue

        attributes = line.split()

        if attributes[2] == "gene":
            if id:
                if exon_counter == 1:
                    out.write(f'{id}\n')
                id = None
                exon_counter = 0

            match = re.search(r'ID=(.*?);', attributes[8])
            if match:
                id = match.group(1)

        if attributes[2] == "exon" and id:
            exon_counter += 1

    if exon_counter == 1:
        out.write(f'{id}\n')

