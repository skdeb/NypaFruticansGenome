import re
import sys

translation = {}
counter = 0

infile = sys.argv[1]
outfile = f"{input_filename}fixed_name.gff3"

with open(infile, 'r') as file, open(outfile, 'w') as out, open('Name_translation_table.txt', 'w') as out2:
    for line in file:
        line = line.rstrip('\n')

        if re.search('ID=|Parent=', line):
            match = re.search(r'ID=(g\d+).|;', line)
            name = match.group(1)

            if name not in translation:
                counter += 1

            templen = len(str(counter))
            zeroes = 6 - templen
            new_name = f'Nfruticans00001aa{"0" * zeroes}{counter}0'

            translation[name] = new_name

            line = re.sub(r'ID=(g\d+)(.|;)', f'ID={translation[name]}\\2', line)
            line = re.sub(r'Parent=(g\d+)(.|;)', f'Parent={translation[name]}\\2', line)

            out.write(f'{line}\n')

        else:
            out.write(f'{line}\n')

    for tid in sorted(translation.keys()):
        out2.write(f'{tid}\t{translation[tid]}\n')

