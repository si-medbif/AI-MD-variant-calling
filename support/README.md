# Support functions

These are scripts that are not specific to any of the three other sections (germline, somatic or RNA).

## FASTQ

Check quality of FASTQ files with FASTQC, output is located in the fastq-folder specified in the config-file:
```bash
run_fastqc.sh config.txt
```

## BAM

Run just DNA read alignment and create BAM files for further analysis
```bash
run_fastq2bam.sh config.txt
```

Calculate QC-stats of the generated BAM files, the output is located in the bam-folder specified in the config-file:
```bash
run_bammetrics.sh config.txt
run_collectmultiplemetrics.sh config.txt
```

## VCF

These tools filter and annotates VCF files. Due to the different ways the analysis might have been run, the helper scripts are less likely to work by default, but might be useful as a starting point.

Combine multiple VCF files with variant calls from the same sample into one. 
```bash
run_votebasedvcfmerger.sh config.txt
```
*Note:* This tool is currently set up to merge variant calls from the three main variant callers, HaplotypeCaller, DeepVariant and Strelka, following the suggested pipeline.

Annotate a VCF file with information from GnomAD, ClinVar and 1000 Genomes.
```bash
run_snpswift.sh sample.vcf
```

Hard filtering a VCF file based on selected annotations. This is mostly used to filter HaplotypeCaller output when the VQSR option is not available:
```bash
run_variantfiltration.sh sample.vcf
```

Filtering VCF files by numeric annotations (e.g. frequency annotation):
```bash
run_frequencyfiltration.sh sample.vcf
```

Quality reports for VCF:
```bash
run_vcfqc.sh sample.vcf
```
