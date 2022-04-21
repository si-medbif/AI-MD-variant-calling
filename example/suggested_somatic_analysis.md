# Somatic WGS

## Short variants, SNP and INDEL

This is a complete analysis of somatic variation in a WGS dataset. Using 2 GPUs.


Starting with FASTQ files, call SNPs and short INDELs with Mutect2.

```bash
run_full_somatic.sh config_WGS.txt
```

Output:

* vcf/sample_m2_filter.vcf

Time spent: 4h 43m

---

Call somatic variants from other tools:

```bash
run_muse_WGS.sh config_WGS.txt
run_somaticsniper.sh config_WGS.txt
run_strelkamanta.sh config_WGS.txt
```

Time spent: 

* Manta 20m
* Strelka 31m
* Somaticsniper 1h 54m
* Muse  1h 14m

Output:

* vcf/strelka_manta_BB-T0863.manta_work/results/variants/somaticSV.vcf.gz
* vcf/strelka_manta_BB-T0863.strelka_work/results/variants/somatic.snvs.vcf.gz
* vcf/strelka_manta_BB-T0863.strelka_work/results/variants/somatic.indels.vcf.gz
* vcf/BB-T0863_somaticsniper.vcf
* vcf/BB-T0863_muse_sump_results.vcf

