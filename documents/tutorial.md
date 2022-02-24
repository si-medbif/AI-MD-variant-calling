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
```

Create the configuration file with sample details (or edit the file in a text editor)
```bash
echo /shared/example_data/fastq,${PWD}/bam,${PWD}/vcf,WES_EA_T_1,WES_EA_T_1_R1.fastq.gz,WES_EA_T_1_R2.fastq.gz,WES_EA_N_1,WES_EA_N_1_R1.fastq.gz,WES_EA_N_1_R2.fastq.gz > config/config.txt
```

Run the project
```bash
run_full_somatic.sh config/config.txt
```

Calculate QC-stats
```bash
run_collectmultiplemetrics.sh config3.txt
```
