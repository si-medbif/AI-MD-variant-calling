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


To read the full documentation of the original software, click on the software name.

Illustration of the Parabricks variant calling process:

![alt text](https://www.nvidia.com/content/dam/en-zz/Solutions/healthcare/clara-parabricks/nvidia-parabricks-diagram-new@2x.png "Clara Parabricks")
