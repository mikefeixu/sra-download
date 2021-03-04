#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 4
#$ -N SRA-Download
#$ -S /bin/bash
#$ -l h_vmem=16g
#$ -l h_rt=20:00:00
#$ -t 1-12

# Update above number (1-47) to reflect the number of samples to be downloaded simultaneously 

echo This is task $SGE_TASK_ID

module load sra-toolkit/2.9.6-1

sourcedir=$(pwd)
indir=$sourcedir/00_fastq


mkdir -p $indir

# Retrieve the accession numbers and sample names
accession=$(awk "NR==${SGE_TASK_ID}" $sourcedir/SraAccList.txt)
sample=$(awk "NR==${SGE_TASK_ID}" $sourcedir/sample_list.txt)
echo "Started task ${SGE_TASK_ID} for sample: ${sample} download"; date

# Download data
cd $indir
fastq-dump --gzip --split-3 --accession $accession

# Rename downloaded data per their sample names
# Make changes to below code according for Single Ended sequencing data
mv ${accession}_1.fastq.gz ${sample}_1.fastq.gz
mv ${accession}_2.fastq.gz ${sample}_1.fastq.gz