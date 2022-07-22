# Germline WGS

## Structural variants

This is a complete analysis of germline variation in a WGS dataset. Using 2 GPUs. The configuration file is assumed created and placed in the working directory.

---
First step is to map reads and create the bam file. This could come from running the main germline pipeline from Parabricks, or from just running the mapping step.

```bash
run_full_germline.sh config_WGS.txt
run_fastq2bam.sh config_WGS.txt
```

Output:

* bam/sample.bam

Time spent: 58m

---

CNVs are called using the sub-command batch (default) from CNVKIT. The main output is the vcf file with the variants, but there will also be files with coverage across regions.

```bash
run_cnvkit.sh config_WGS.txt
```

Output:

* vcf/sample_cnvkit-batch/
* vcf/sample_cnvkit-batch/BB-B0863.vcf

Time spent: 12m

---

Structural variants are called using smoove. The main outputs are the vcf file with SVs.

```bash
run_smoove.sh config_WGS.txt
```

Output:

* vcf/sample_smoove/sample-smoove.vcf.gz


Time spent:  27m

---

