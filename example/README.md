The example datasets are collected from [MAQC-IV (also known as SEQC2)](https://www.fda.gov/science-research/bioinformatics-tools/microarraysequencing-quality-control-maqcseqc#MAQC_IV).

The data was downloaded as BAM files and converted to FASTQ using the Parabricks function bam2fq.

[Data repository](https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/)

The provided configuration file can be used as input to run the full pipeline, just change the location you want to create the BAM files and the VCF files.
```bash
./run_full_somatic.sh ../example/config1_WES_example.txt
```

Total runtimes using 4 GPU, 32 CPU, 256gb RAM:
```
WES = 19 m
WGS = 
```


WES:
````
WES_EA_T_1_R1.fastq.gz	4.9G
WES_EA_T_1_R2.fastq.gz	5.0G
WES_EA_N_1_R1.fastq.gz	4.1G
WES_EA_N_1_R2.fastq.gz	4.3G
```


WGS:
```
WGS_EA_T_1_R1.fastq.gz	G
WGS_EA_T_1_R2.fastq.gz	G
WGS_EA_N_1_R1.fastq.gz	G
WGS_EA_N_1_R2.fastq.gz	G
`
```
