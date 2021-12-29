#! /usr/bin/env python

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as fin, open(outfile, 'w') as fout:
    for line in fin:
        if line.startswith('##'):
            fout.write(line)
            continue
        if line.startswith('#'):
            fout.write('##INFO=<ID=P_CONTAM,Number=1,Type=Float,Description="Posterior probability for alt allele to be due to contamination">\n')
            fout.write(line)
            continue
        l = line.strip().split()
        if ',' in l[3]+l[4]:
            continue
        fout.write(line)
