# Support functions

These are scripts that are not specific to any of the three other sections (germline, somatic or RNA).

Check quality of FASTQ files with FASTQC, output is located in the fastq-folder specified in the config-file:
```bash
run_fastqc.sh config.txt
```

Run just read alignment and create BAM files for further analysis
```bash
run_fastq2bam.sh config.txt
```

Calculate QC-stats of the generated BAM files, the output is located in the bam-folder specified in the config-file:
```bash
run_bammetrics.sh config.txt
run_collectmultiplemetrics.sh config.txt
```
