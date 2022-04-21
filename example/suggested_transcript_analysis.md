# Transcriptome analysis

## Short variants, SNPs and INDELs

The main pipeline uses STAR for mapping and GATK for bam processing and variant calling

```bash
run_full_rna.sh config_wts.txt
```

Output: 

* bam/sample.bam
* bam/sample.recal.txt
* vcf/sample_hc.vcf

Time spent: 35m

## Fusions

```bash
run_arriba.sh config_wts.txt
```

Output:

* vcf/sample_passingFusions.tsv
* vcf/sample_discardedFusions.tsv

Time spent: 14m

## Structural variants
