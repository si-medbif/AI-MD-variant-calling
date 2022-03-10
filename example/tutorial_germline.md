# Step by step tutorial to analyse an example WES dataset, from a first time perspective

Create project folder
```bash
mkdir -p project/{bam,vcf,config}
cd project
```

Download this github project, and add the scripts folder to the PATH.
```bash
git clone https://github.com/si-medbif/AI-MD-variant-calling.git
export PATH="${PWD}/AI-MD-variant-calling/somatic":$PATH
export PATH="${PWD}/AI-MD-variant-calling/germline":$PATH
export PATH="${PWD}/AI-MD-variant-calling/support":$PATH
```

Create the configuration file with sample details (or edit the file in a text editor)
```bash
echo /shared/example_data/fastq,${PWD}/bam,${PWD}/vcf,WES_EA_N_1,WES_EA_N_1_R1.fastq.gz,WES_EA_N_1_R2.fastq.gz > config/config.txt
```

Run the project
```bash
run_full_germline.sh config/config.txt
```

Calculate QC-stats for the BAM files (output will be one folder for each BAM file in the BAM folder)
```bash
run_bammetrics.sh config/config.txt
run_collectmultiplemetrics.sh config/config.txt
```

The VCF file will be in the VCF folder:
```bash
cd vcf
ls
```

