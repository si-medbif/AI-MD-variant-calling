# Germline WGS

## Short variants, SNP and INDEL

This is a complete analysis of germline variation in a WGS dataset. Using 2 GPUs.

---
First step is to map reads, process bam files and call short variants with HaplotypeCaller. This is done using the main germline pipeline from Parabricks.

```bash
run_full_germline.sh config_WGS.txt
```

Output:

* bam/sample.recal.txt
* bam/sample.bam
* vcf/sample.hc.vcf

Time spent: 2h 7m

---

Next, the variants are filtered using the VariantRecalibration procedure from GATK.

```bash
run_vqsr.sh config_WGS.txt
```

Output:

* vcf/sample.hc.vqsr.vcf

Time spent: 11m

---

DeepVariant and Strelka are also used to call variants, to provide better support for final list of variants.

```bash
run_strelka_germline.sh config_WGS.txt
run_deepvariant_WGS.sh config_WGS.txt
```

Output:

* vcf/sample.deepvariant.vcf
* vcf/sample.strelka_work/results/variants/variants.vcf.gz


Time spent:  37m (strelka), 57m (DeepVariant)

---

The three VCF files containing the called germline variants are combined. The input needs to be bgzipped and indexed with tabix, which means the variant calls from DeepVariant and HaplotypeCaller needs the be pre-processed.

```bash
singularity run /shared/example_data/singularity/tabix.1.9.sif bgzip -c vcf/sample.hc.vqsr.vcf > vcf/sample.hc.vqsr.vcf.gz
singularity run /shared/example_data/singularity/tabix.1.9.sif tabix -fp vcf vcf/sample.hc.vqsr.vcf.gz
singularity run /shared/example_data/singularity/tabix.1.9.sif bgzip -c vcf/sample.deepvariant.vcf > vcf/sample.deepvariant.vcf.gz
singularity run /shared/example_data/singularity/tabix.1.9.sif tabix -fp vcf vcf/sample.deepvariant.vcf.gz
```

The individually called germline variants are combined, creating one file with all variants called by either tool (union) and one file with all variants called by all three (intersect).

```bash
run_votebasedvcfmerger.sh config_WGS.txt
```

Output:

* vcf/sample.vbvm/filteredVCF.vcf
* vcf/sample.vbvm/unionVCF.vcf

Time spent: 5m

---

The file with the intersection of variants are annotated with GnomAD, ClinVar and 1000Genomes:

```bash
run_snpswift.sh config_WGS.txt
```
Ouput:

* vcf/sample.vbvm/filteredVCF.annotated.vcf

Time spent: 15m

---

## Structural variants

Search for CNV's in the dataset with CNVkit

```bash
run_cnvkit.sh config_WGS.txt
```

Output:

* vcf/sample_cnvkit/sample.vcf

Time spent: 19m

---

Search for general structural variants with Smoove:

```bash
run_smoove.sh config_WGS.txt
```
Output:

* vcf/sample_smoove/sample-smoove.vcf.gz

Time spent: 31m
