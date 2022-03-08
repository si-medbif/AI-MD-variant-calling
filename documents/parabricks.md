# NVIDIA CLARA PARABRICKS

## Pipelines:

### Somatic variant calling

The [default](https://docs.nvidia.com/clara/parabricks/3.7.0/Documentation/ToolDocs/man_somatic.html#man-somatic) somatic variant call pipeline is designed to generate the same results as a comparable pipeline with the following software:

## Individual software 

This is the list of comparable CPU-based [software tools](https://docs.nvidia.com/clara/parabricks/3.7.0/SoftwareOverview.html#software-tools) that will generate the same results.

| Software | Function | Version |
| --- | --- | --- |
| [BWA](http://bio-bwa.sourceforge.net/bwa.shtml) | Read alignment | 0.7.15 |
| [GATK](https://gatk.broadinstitute.org/hc/en-us) | Mark duplicates/BQSR/Variant Call | 4.2.0.0 |
| [lofreq](https://csb5.github.io/lofreq/) | Variant Call | 2.1.5 |
| [somaticsniper](https://gmt.genome.wustl.edu/packages/somatic-sniper/documentation.html) | Variant Call | 1.0.5.0 |
| [manta](https://github.com/Illumina/manta#manta-structural-variant-caller) | Structural Variant Call | 1.6.0 |
| [strelka](https://github.com/Illumina/strelka#strelka2-small-variant-caller) | Variant Call | 2.9.0 |
| [MuSE](https://bioinformatics.mdanderson.org/public-software/muse/) | SNV Calls | 2.0 |


To read the full documentation of the original software, click on the software name.

Illustration of the Parabricks variant calling process:

![alt text](https://www.nvidia.com/content/dam/en-zz/Solutions/healthcare/clara-parabricks/nvidia-parabricks-diagram-new@2x.png "Clara Parabricks")



### SomaticSniper

SomaticSniper is typically run on BAM files that have neither been base quality recalibrated nor locally realigned around indels (such as with the GATK). Either of these preprocessing steps can be optionally performed before running SomaticSniper, but we have observed some decrease in sensitivity after base quality recalibration. (Larson, David E., et al. 2014)

### MuSE

The BAM files need to be processed by following the Genome Analysis Toolkit (GATK) Best Practices that include marking duplicates, realigning the paired tumor-normal BAMs jointly and recalibrating base quality scores. (https://bioinformatics.mdanderson.org/public-software/muse/)

### Smoove

For large cohorts, it's better to parallelize across samples rather than using a large $threads per sample. smoove can only parallelize up to 2 or 3 threads on a single-sample and it's most efficient to use 1 thread. (https://github.com/brentp/smoove)
