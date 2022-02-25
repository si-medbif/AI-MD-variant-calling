# Step by step tutorial to analyse an example WES dataset, from a first time perspective

Create project folder
```bash
mkdir -p project/{bam,vcf,config}
cd project
```

Download this github project, and add the scripts folder to the PATH.
```bash
git clone https://github.com/si-medbif/hpc-pipelines.git
export PATH="${PWD}/hpc-pipelines/somatic":$PATH
export PATH="${PWD}/hpc-pipelines/support":$PATH
```

Create the configuration file with sample details (or edit the file in a text editor)
```bash
echo /shared/example_data/fastq,${PWD}/bam,${PWD}/vcf,WES_EA_T_1,WES_EA_T_1_R1.fastq.gz,WES_EA_T_1_R2.fastq.gz,WES_EA_N_1,WES_EA_N_1_R1.fastq.gz,WES_EA_N_1_R2.fastq.gz > config/config.txt
awk 'BEGIN { FS = ","; OFS = "," } ; { print $2,$3,$4,$4,$7,$7 }' config/config.txt  > config/config2.txt
printf "${PWD}/bam,WES_EA_T_1,WES_EA_T_1\n${PWD}/bam,WES_EA_N_1,WES_EA_N_1\n" > config/config3.txt
```

Run the project
```bash
run_full_somatic.sh config/config.txt
```

Calculate QC-stats for the BAM files (output will be one folder for each BAM file in the BAM folder)
```bash
run_collectmultiplemetrics.sh config/config3.txt
```

The filtered VCF file will be in the VCF folder:
```bash
ll vcf
```

Run the remaining variantcallers:
```bash
run_somaticsniper.sh config/config2.txt
run_lofreq.sh config/config2.txt
run_sv_strelkamanta.sh config/config2.txt
```


