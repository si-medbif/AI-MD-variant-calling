# WES trios

## SNP & INDEL

Create BAM files for the three samples.

```bash
run_fastq2bam.sh config-trios-wes.txt
```

Time spent: 13m, 13m, 19m 

Call variants in gvcf-format for the three samples individually.

```bash
run_haplotypecaller_gvcf.sh config-trios-wes.txt
```

Time spent: 13m, 13m, 19m

Combine the gvcf-files.

```bash
run_haplotypecaller_trios.sh config-trios-wes.txt
```

Time spent: 41m

Output:

* vcf/combined.hc.g.vcf
* vcf/combined.hc.vcf

Apply hard filtering to the combined variants

```bash
run_variantfiltration.sh vcf/combined.hc.vcf
```

Output:

* vcf/combined.hc.filtered.vcf

Time spent: 4m

Annotate variants.
```bash
run_snpswift.sh vcf/combined.hc.filtered.vcf
```

Output:

* vcf/combined.hc.filtered.annotated.vcf

Alternativ approach for joint variant calling is provided by Strelka.

```bash
run_strelka_joint.sh config-trios-wes.txt
```

Output:

* vcf/combined.strelka_work/results/variants/variants.vcf.gz

Time spent: 27m

## SV

Call structural variants jointly with Manta.

```bash
run_manta_joint.sh config-trios-wes.txt
```

Output:

* vcf/combined.manta_work/results/variants/diploidSV.vcf.gz

Time spent: 4m
